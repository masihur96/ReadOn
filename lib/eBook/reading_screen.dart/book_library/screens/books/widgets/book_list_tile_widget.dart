import 'package:flutter/material.dart';
import 'package:read_on/eBook/reading_screen.dart/book_library/model/book.dart';
import 'package:read_on/eBook/reading_screen.dart/book_library/theme/text_theme.dart';
// import 'package:auto_scrolling_readon/book_library/model/book.dart';
// import 'package:auto_scrolling_readon/book_library/theme/text_theme.dart';

class BookListTileWidget extends StatelessWidget {
  const BookListTileWidget({
    Key? key,
    required this.book,
  }) : super(key: key);

  final Book book;

  @override
  Widget build(BuildContext context) {
    return Card(
       elevation: 0,
      // color: kBookCardBackgroundColor,
      // child: Center(
      //     child: Text(
      //   book.title,
      //   style: bookNameTextStyle,
      // )),
    );
  }
}
