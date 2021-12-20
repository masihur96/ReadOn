import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:read_on/eBook/reading_screen.dart/book_library/model/book.dart';
import 'package:read_on/eBook/reading_screen.dart/book_library/screens/books/bloc/book_bloc.dart';
import 'package:read_on/eBook/reading_screen.dart/book_library/screens/sections/SectionScreen.dart';
// import 'package:auto_scrolling_readon/book_library/model/book.dart';
// import 'package:auto_scrolling_readon/book_library/screens/books/bloc/book_bloc.dart';
// import 'package:auto_scrolling_readon/book_library/screens/sections/SectionScreen.dart';

import 'book_list_tile_widget.dart';

class BooksWidget extends StatefulWidget {
  const BooksWidget({
    Key? key,
    required this.books,
  }) : super(key: key);

  final List<Book> books;

  @override
  State<BooksWidget> createState() => _BooksWidgetState();
}

class _BooksWidgetState extends State<BooksWidget> {

  int counter=0;
  customInit(){

    setState(() {
      counter++;
    });
    BlocProvider.of<BookBloc>(context)
        .add(BookTapped(widget.books[0]));

  }
  @override
  Widget build(BuildContext context) {
    if(counter==0) {

      customInit();


    }

    return BlocListener(
      bloc: BlocProvider.of<BookBloc>(context),
      listener: (BuildContext context, BookState state) {
        if (state is BookGoToSection) {
          if (state.bookType == BookTypes.normalBook) {
            gotoSectionScreen(context, state);
          }
        }
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, crossAxisSpacing: 4.0, mainAxisSpacing: 4.0),
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                BlocProvider.of<BookBloc>(context)
                    .add(BookTapped(widget.books[index]));
              },
              child: BookListTileWidget(book: widget.books[index]),
            );
          },
          itemCount: widget.books.length,
        ),
      ),
    );
  }

  void gotoSectionScreen(BuildContext context, BookGoToSection state) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SectionScreen(state.book)),
    );
  }
}
