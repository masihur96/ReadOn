import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:read_on/eBook/reading_screen.dart/book_library/model/book.dart';
import 'package:read_on/eBook/reading_screen.dart/book_library/screens/sections/bloc/section_bloc.dart';
import 'package:read_on/eBook/reading_screen.dart/book_library/screens/sections/helper/name_parsing_helper.dart';
// import 'package:auto_scrolling_readon/book_library/model/book.dart';
// import 'package:auto_scrolling_readon/book_library/screens/sections/bloc/section_bloc.dart';
// import 'package:auto_scrolling_readon/book_library/screens/sections/helper/name_parsing_helper.dart';

class SectionList extends StatelessWidget {
  final Book book;
  SectionList(this.book, {Key? key}) : super(key: key);
  int count = 0;
  customInit(BuildContext context) {
    count++;
    BlocProvider.of<SectionBloc>(context)
        .add(SectionTapped(book: book, sectionIndex: 0, title: ''));
  }

  @override
  Widget build(BuildContext context) {
    if (count == 0) {
      customInit(context);
    }
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView.builder(
        itemBuilder: (context, index) {
          final title = getSectionTitle(index, book);
          final fileName = book.sections[index].fileName;
          return Container();
        },
        itemCount: book.sections.length,
      ),
    );
  }
}
