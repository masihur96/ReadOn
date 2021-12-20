part of 'section_bloc.dart';

abstract class SectionState extends Equatable {
  const SectionState();
}

class SectionInitial extends SectionState {
  @override
  List<Object> get props => [];
}

class SectionLoading extends SectionState {
  @override
  List<Object> get props => [];
}

class SectionGoToReader extends SectionState {
  final int sectionIndex;

  final Book book;

  SectionGoToReader({required this.book, required this.sectionIndex});
  @override
  List<Object> get props => [sectionIndex, book];
}
