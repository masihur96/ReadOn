import 'package:read_on/eBook/reading_screen.dart/book_library/model/book.dart';
import 'package:read_on/eBook/reading_screen.dart/book_library/model/menu_button.dart';
import 'package:read_on/eBook/reading_screen.dart/book_library/screens/books/bloc/book_bloc.dart';
import 'package:read_on/eBook/reading_screen.dart/book_library/screens/reader/bloc/reader_bloc.dart';
import 'package:read_on/eBook/reading_screen.dart/book_library/text_selection_controls.dart';
import 'package:read_on/eBook/reading_screen.dart/book_library/theme/text_theme.dart';

import 'widgets/books_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:auto_scrolling_readon/book_library/model/book.dart';
// import 'package:auto_scrolling_readon/book_library/theme/text_theme.dart';
// import 'package:auto_scrolling_readon/book_library/model/menu_button.dart';
// import 'package:auto_scrolling_readon/book_library/text_selection_controls.dart';
// import 'package:auto_scrolling_readon/book_library/screens/books/bloc/book_bloc.dart';
// import 'package:auto_scrolling_readon/book_library/screens/reader/bloc/reader_bloc.dart';




class BooksScreen extends StatelessWidget {

  final List<Book> books;
  final String title;
  final List<HighlightMenuButton>? highlightMenuColorButtons;

  BooksScreen({
    required this.title,
    required String booksAssetsFolder,
    required this.books,
    this.highlightMenuColorButtons,
  }) {
    ReaderBloc.booksAssetsFolder = booksAssetsFolder;

    if (highlightMenuColorButtons != null) {
      MyMaterialTextSelectionControls.defaultColorButtons =
          highlightMenuColorButtons!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: ScreenUtil.defaultSize,
      builder: () => Scaffold(
        backgroundColor: Colors.white,
        // appBar: AppBar(
        //   backgroundColor: kBookCardBackgroundColor,
        //   title: Text(
        //     title,
        //     style: TextStyle(color: kBookTitleColor),
        //   ),
        // ),
        body: SafeArea(
          child: BlocProvider<BookBloc>(
            create: (context) => BookBloc(),
            child: BlocBuilder<BookBloc, BookState>(
              buildWhen: (context, state) =>
                  !(state is BookGoToSection || state is BookLoading),
              builder: (context, state) {
                if (state is BookInitial) {
                  return BooksWidget(books: books);
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
