part of 'section_bloc.dart';

abstract class SectionEvent extends Equatable {
  const SectionEvent();
}

class SectionTapped extends SectionEvent {
  final int sectionIndex;
  final Book book;
  final String title;

  SectionTapped(
      {required this.title, required this.book, required this.sectionIndex});

  @override
  List<Object?> get props => [book, sectionIndex, title];
}

class SectionGoToLastReadingRequired extends SectionEvent {
  @override
  List<Object?> get props => [];
}
