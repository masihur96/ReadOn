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
  const SectionList(this.book, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView.builder(
        itemBuilder: (context, index) {
          final title = getSectionTitle(index, book);
          final fileName = book.sections[index].fileName;

          return ListTile(
            title: Text(''),
            onTap: () {
              BlocProvider.of<SectionBloc>(context).add(SectionTapped(
                  book: book, sectionIndex: index, title: title ?? ''));
            },
          );
        },
        itemCount: book.sections.length,
      ),
    );
  }
}
