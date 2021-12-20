part of 'book_bloc.dart';

abstract class BookState extends Equatable {
  const BookState();
}

class BookInitial extends BookState {
  @override
  List<Object> get props => [];
}

class BookLoading extends BookState {
  @override
  List<Object> get props => [];
}

enum BookTypes {
  normalBook,
  littleBook,
}

class BookGoToSection extends BookState {
  final BookTypes bookType;

  final Book book;

  BookGoToSection({required this.book, required this.bookType});
  @override
  List<Object> get props => [bookType, book];
}
