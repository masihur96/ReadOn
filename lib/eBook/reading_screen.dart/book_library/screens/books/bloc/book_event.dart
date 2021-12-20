part of 'book_bloc.dart';

abstract class BookEvent extends Equatable {
  const BookEvent();
}

class BookTapped extends BookEvent {
  final Book book;

  BookTapped(this.book);
  @override
  List<Object?> get props => [book];
}
