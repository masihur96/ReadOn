import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:read_on/eBook/reading_screen.dart/book_library/components/scroll_speed_widget.dart';
import 'package:read_on/eBook/reading_screen.dart/book_library/model/highlight.dart';
// import 'package:auto_scrolling_readon/book_library/components/scroll_speed_widget.dart';
// import 'package:auto_scrolling_readon/book_library/model/highlight.dart';
import '../../../../mina_reader.dart';
import '../keys.dart';

part 'reader_event.dart';
part 'reader_state.dart';

class ReaderBloc extends Bloc<ReaderEvent, ReaderState> {
  final String sectionFileName;
  final String highlightFileName;
  final ScrollController scrollController = ScrollController();
  final String bookFolder;

  // zoom variables
  double scaleFactor = 1.0;
  double baseScaleFactor = 1.0;

  // highlight variables
  List<Highlight> highlights = [];
  Highlight? currentSelectedHighlight;

  //
  String allText = "";

  static String booksAssetsFolder = "";

  ReaderBloc(
      {required this.sectionFileName,
      required this.highlightFileName,
        required this.bookFolder})
      : super(ReaderInitial()) {
    loadSectionText();
  }

  // dictionary
  List<dynamic>? lugat;

  void saveHighlights() {

   // print(highlights);
    box.put(highlightFileName, highlights);
    print(highlights);
  }

  Future<void> loadSectionTextAndHighlights() async {

    allText = sectionFileName;
    highlights = getHighlights(highlightFileName);

  }

  List<Highlight> getHighlights(String fileName) {
    // clearHighlights();
    // await box.empty(fileName);
    return box.get(fileName, defaultValue: null)?.cast<Highlight>() ??
        <Highlight>[];
  }

  double lastSavedLocation = 0.0;

  @override
  Stream<ReaderState> mapEventToState(
    ReaderEvent event,
  ) async* {
    if (event is ReaderLastLocationChanged) {
      yield* _mapReaderLastLocationChangedToState(event);
    }
  }

  Stream<ReaderState> _mapReaderLastLocationChangedToState(
      ReaderLastLocationChanged event) async* {
    if ((event.newOffset - lastSavedLocation).abs() > 30) {
      lastSavedLocation = event.newOffset;
      // print(event.newOffset);
    }
    // return;
    boxLastLocation.put(
        key_last_location + highlightFileName, lastSavedLocation);
  }

  Future<void> toggleAutoScroll() async {
    final maxExtent = scrollController.position.maxScrollExtent;
    final distanceDifference = maxExtent - scrollController.offset;
    final durationDouble = distanceDifference / scrollSpeedFactor;

    // setState
    isScrolling = !isScrolling;

    if (isScrolling) {
      scrollController.animateTo(scrollController.position.maxScrollExtent,
          duration: Duration(seconds: durationDouble.toInt()),
          curve: Curves.linear);
    } else {
      scrollController.animateTo(scrollController.offset,
          duration: const Duration(seconds: 1), curve: Curves.linear);
    }
  }

  bool isScrolling = false;
  double scrollSpeedFactor = ScrollSpeedWidget.getScrollSpeed();

  scrollSpeedChanged(newValue) async {
    scrollSpeedFactor = newValue;
    await toggleAutoScroll();
    await toggleAutoScroll();
  }

  void gotoLastLocation() async {
    final lastLocationOffset = await boxLastLocation
        .get(key_last_location + highlightFileName, defaultValue: 0.0);
    scrollController.animateTo(lastLocationOffset,
        duration: const Duration(milliseconds: 30), curve: Curves.linear);
  }

  void loadSectionText() async {
    await loadSectionTextAndHighlights();
    emit(ReaderReady());
    Future.delayed(const Duration(milliseconds: 50), () {
      gotoLastLocation();
    });
  }
}
