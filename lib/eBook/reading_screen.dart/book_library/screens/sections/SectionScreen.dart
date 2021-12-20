// ignore: file_names
// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:read_on/eBook/reading_screen.dart/book_library/components/loading.dart';
import 'package:read_on/eBook/reading_screen.dart/book_library/model/book.dart';
import 'package:read_on/eBook/reading_screen.dart/book_library/screens/reader/book_reader_screen.dart';
import 'package:read_on/eBook/reading_screen.dart/book_library/screens/sections/bloc/section_bloc.dart';
import 'package:read_on/eBook/reading_screen.dart/book_library/theme/text_theme.dart';
// import 'package:auto_scrolling_readon/book_library/components/loading.dart';
// import 'package:auto_scrolling_readon/book_library/model/book.dart';
// import 'package:auto_scrolling_readon/book_library/screens/reader/book_reader_screen.dart';
// import 'package:auto_scrolling_readon/book_library/screens/sections/bloc/section_bloc.dart';
// import 'package:auto_scrolling_readon/book_library/theme/text_theme.dart';

import 'helper/name_parsing_helper.dart';
import 'widgets/section_list_widget.dart';

class SectionScreen extends StatefulWidget {
  final Book book;

  SectionScreen(this.book, {Key? key}) : super(key: key);

  @override
  _SectionScreenState createState() => _SectionScreenState();
}

class _SectionScreenState extends State<SectionScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // appBar: AppBar(
      //   iconTheme: IconTheme.of(context).copyWith(color: kBookTitleColor),
      //   backgroundColor: kBookCardBackgroundColor,
      //   title: FittedBox(
      //     child: Text(
      //       widget.book.title,
      //       style: TextStyle(color: kBookTitleColor),
      //     ),
      //   ),
      // ),
      body: BlocProvider(
        create: (context) => SectionBloc(widget.book),
        child: BlocConsumer<SectionBloc, SectionState>(
          listener: (BuildContext context, SectionState state) {
            if (state is SectionGoToReader) {
              gotoReaderScreen(context, state);
            }
          },
          buildWhen: (context, state) =>
              !(state is SectionGoToReader || state is SectionLoading),
          builder: (context, state) {
            print('state is :: ' + state.toString());
            if (state is SectionInitial) {
              return SectionList(widget.book);
            } else {
              return Loading();
            }
          },
        ),
      ),
    );
  }

  void gotoReaderScreen(BuildContext context, SectionGoToReader state) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => BookReaderScreen(
            book: state.book,
            sectionIndex: state.sectionIndex,
            onTapNextSection: () {
              BlocProvider.of<SectionBloc>(context).add(SectionTapped(
                  book: state.book,
                  sectionIndex: state.sectionIndex + 1,
                  title:
                  getSectionTitle(state.sectionIndex + 1, state.book) ??
                      ''));
            },
            nextSectionTitle:
            (state.sectionIndex + 1) >= state.book.sections.length
                ? null
                : getSectionTitle(state.sectionIndex + 1, state.book),
          )),
    );
  }
}
