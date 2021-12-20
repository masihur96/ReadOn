import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:read_on/eBook/reading_screen.dart/book_library/model/book.dart';
import 'package:read_on/eBook/reading_screen.dart/book_library/model/book_list.dart';
// import 'package:auto_scrolling_readon/book_library/model/book.dart';
// import 'package:auto_scrolling_readon/book_library/model/book_list.dart';

import '../../../../mina_reader.dart';

part 'book_event.dart';
part 'book_state.dart';

class BookBloc extends Bloc<BookEvent, BookState> {
  BookBloc() : super(BookInitial());

  @override
  Stream<BookState> mapEventToState(
    BookEvent event,
  ) async* {
    yield BookLoading();
    if (event is BookTapped) {
      yield* _mapBookTappedToState(event);
    }
  }

  Stream<BookState> _mapBookTappedToState(BookTapped event) async* {
    final book = event.book;
    if (book.title == SampleRisaleBookList.littleBooksLabel) {
      yield BookGoToSection(bookType: BookTypes.littleBook, book: book);
    } else {
      yield BookGoToSection(bookType: BookTypes.normalBook, book: book);
    }
  }
}
