import 'package:flutter/material.dart';
import 'package:read_on/eBook/reading_screen.dart/book_library/model/book.dart';
import 'package:read_on/eBook/reading_screen.dart/book_library/model/highlight.dart';
import 'package:read_on/eBook/reading_screen.dart/book_library/screens/reader/bloc/reader_bloc.dart';
import 'package:read_on/eBook/reading_screen.dart/book_library/theme/text_theme.dart';
// import 'package:auto_scrolling_readon/book_library/model/highlight.dart';
// import 'package:auto_scrolling_readon/book_library/screens/reader/bloc/reader_bloc.dart';
// import 'package:auto_scrolling_readon/book_library/theme/text_theme.dart';
import '../../../../mina_reader.dart';
import '../../../model/highlight_type.dart';

void addHighlight(TextSelection selection,
    {int color = 0xFFFFCC00,
    required highlight_type type,
    required String sectionFileName,
    required ReaderBloc readerBloc}) {
  if (selection.baseOffset == -1) return;
  final newHighlight = Highlight(
      color: color,
      baseOffset: selection.baseOffset,
      extendOffset: selection.extentOffset,
      type: type);

  readerBloc.highlights.add(
    newHighlight,
  );

  readerBloc.highlights.sort((a, b) => a.compareTo(b));

  print(readerBloc.highlights.last);
  readerBloc.saveHighlights();
}

void clearHighlights(int sectionIndex, Book book, ReaderBloc readerBloc) {
  box.put(book.getHighlightFileName(sectionIndex), null);
  readerBloc.highlights = [];
  // setState(() {});
}

getTextStyle(Highlight highlight,double fontSize,String selectedFont) {
  switch (highlight.type) {
    case highlight_type.underline:
      return readerBaseTextStyle.copyWith(decoration: TextDecoration.underline,fontSize: fontSize,fontFamily:selectedFont);
    case highlight_type.bold:
      return readerBaseTextStyle.copyWith(fontWeight: FontWeight.w900,fontSize: fontSize,fontFamily:selectedFont);
    case highlight_type.italic:
      return readerBaseTextStyle.copyWith(fontStyle: FontStyle.italic,fontSize: fontSize,fontFamily:selectedFont);
    default:
      return readerBaseTextStyle.copyWith(
          backgroundColor: Color(highlight.color),fontSize: fontSize,fontFamily:selectedFont);
  }
}
