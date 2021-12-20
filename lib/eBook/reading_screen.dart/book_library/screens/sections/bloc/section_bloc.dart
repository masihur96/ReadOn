import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:auto_scrolling_readon/book_library/model/book.dart';
// import 'package:auto_scrolling_readon/extensions/extensions_future.dart';
import 'package:read_on/eBook/reading_screen.dart/book_library/model/book.dart';
import 'package:read_on/eBook/reading_screen.dart/extensions/extensions_future.dart';

import '../../../../mina_reader.dart';

part 'section_event.dart';
part 'section_state.dart';

class SectionBloc extends Bloc<SectionEvent, SectionState> {
  final Book book;

  SectionBloc(this.book) : super(SectionInitial()) {
    400.msAfter(run: () {
      gotoLastReadingSection();
    });
  }

  @override
  Stream<SectionState> mapEventToState(
    SectionEvent event,
  ) async* {
    yield SectionLoading();
    if (event is SectionTapped) {
      yield* _mapSectionTappedToState(event);
    }
    if (event is SectionGoToLastReadingRequired) {
      yield* _mapSectionGoToLastReadingRequiredToState(event);
    }
  }

  Stream<SectionState> _mapSectionTappedToState(SectionTapped event) async* {
    yield SectionGoToReader(book: event.book, sectionIndex: event.sectionIndex);
    saveLastReadedSection(event.sectionIndex);
  }

  void gotoLastReadingSection() {
    final lastReadedSectionId =
        boxLastReadedSectionId.get(book.assetFolder, defaultValue: -1);
    if (lastReadedSectionId != -1) {
      add(SectionTapped(
          title: book.sections[lastReadedSectionId].title ?? '',
          book: book,
          sectionIndex: lastReadedSectionId)
      );
    }
  }

  void saveLastReadedSection(int index) {
    boxLastReadedSectionId.put(book.assetFolder, index);
  }

  Stream<SectionState> _mapSectionGoToLastReadingRequiredToState(
      SectionGoToLastReadingRequired event) async* {
    gotoLastReadingSection();
  }
}
