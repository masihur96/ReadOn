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
    box.put(highlightFileName, highlights);
  }

  Future<void> loadSectionTextAndHighlights() async {


    // TODO: dictionary
    // try {
    //   final lugats =
    //       await rootBundle.loadString(path.replaceFirst('.txt', '.json'));
    //
    //   lugat = jsonDecode(lugats);
    // } catch (e) {
    //
    // }
    ////
   // final path = ReaderBloc.booksAssetsFolder + bookFolder + "/" + sectionFileName;
   // final path = sectionFileName;
     // allText = path;
      allText = sectionFileName;

  // allText = 'বাংলাদেশ (এই শব্দ সম্পর্কেশুনুন (সাহায্য·তথ্য)) দক্ষিণ এশিয়ার একটি সার্বভৌম রাষ্ট্র। বাংলাদেশের সাংবিধানিক নাম গণপ্রজাতন্ত্রী বাংলাদেশ। ভূ-রাজনৈতিক ভাবে বাংলাদেশের পশ্চিমে ভারতের পশ্চিমবঙ্গ, উত্তরে পশ্চিমবঙ্গ, আসাম ও মেঘালয়, পূর্ব সীমান্তে আসাম, ত্রিপুরা ও মিজোরাম, দক্ষিণ-পূর্ব সীমান্তে মায়ানমারের চিন ও রাখাইন রাজ্য এবং দক্ষিণ উপকূলের দিকে বঙ্গোপসাগর অবস্থিত।[১৪] ভৌগোলিকভাবে পৃথিবীর বৃহত্তম ব-দ্বীপের সিংহভাগ অঞ্চল জুড়ে বাংলাদেশ ভূখণ্ড অবস্থিত। নদীমাতৃক বাংলাদেশ ভূখণ্ডের উপর দিয়ে বয়ে গেছে ৫৭টি আন্তর্জাতিক নদী। বাংলাদেশের উত্তর-পূর্বে ও দক্ষিণ-পূর্বে টারশিয়ারি যুগের পাহাড় ছেয়ে আছে। বিশ্বের বৃহত্তম ম্যানগ্রোভ অরণ্য সুন্দরবন ও দীর্ঘতম প্রাকৃতিক সৈকত কক্সবাজার সমুদ্র সৈকত বাংলাদেশে অবস্থিত।দক্ষিণ এশিয়ার প্রাচীন ও ধ্রুপদী যুগে বাংলাদেশ অঞ্চলটিতে বঙ্গ, পুণ্ড্র, গৌড়, গঙ্গাঋদ্ধি, সমতট ও হরিকেল নামক জনপদ গড়ে উঠেছিল। মৌর্য যুগে মৌর্য সাম্রাজ্যের একটি প্রদেশ ছিল অঞ্চলটি। জনপদগুলো নৌ-শক্তি ও সামুদ্রিক বাণিজ্যের জন্য বিখ্যাত ছিল। মধ্য প্রাচ্য, রোমান সাম্রাজ্যে মসলিন ও সিল্ক রপ্তানি করতো জনপদগুলো। প্রথম সহস্রাব্দিতে বাংলাদেশ অঞ্চলকে কেন্দ্র করে পাল সাম্রাজ্য, চন্দ্র রাজবংশ, সেন রাজবংশ গড়ে উঠেছিল। বখতিয়ার খলজীর গৌড় জয়ের পরে ও দিল্লি সালতানাত আমলে এ অঞ্চলে ইসলাম ছড়িয়ে পরে। ইউরোপীয়রা শাহী বাংলাকে পৃথিবীর সবচেয়ে ধনী বাণিজ্য দেশ হিসেবে গণ্য করতো।[১৫]মুঘল আমলে বিশ্বের মোট উৎপাদনের (জিডিপির) ১২ শতাংশ উৎপন্ন হতো সুবাহ বাংলায়,[১৬][১৭][১৮] যা সে সময় সমগ্র পশ্চিম ইউরোপের জিডিপির চেয়ে বেশি ছিল।[১৯] ১৭৬৫ থেকে ১৯৪৭ পর্যন্ত বাংলাদেশ ভূখণ্ডটি প্রেসিডেন্সি বাংলার অংশ ছিল। ১৯৪৭-এর ভারত ভাগের পর বাংলাদেশ অঞ্চল পূর্ব বাংলা (১৯৪৭–১৯৫৬; পূর্ব পাকিস্তান, ১৯৫৬–১৯৭১) নামে নবগঠিত পাকিস্তান অধিরাজ্যের অন্তর্ভুক্ত হয়। ১৯৪৭ থেকে ১৯৫৬ পর্যন্ত বাংলা ভাষা আন্দোলনকে কেন্দ্র করে বাঙালি জাতীয়তাবাদের বিকাশ হলে পশ্চিম পাকিস্তানের বিবিধ রাজনৈতিক, সাংস্কৃতিক ও অর্থনৈতিক শোষণ, বৈষম্য ও নিপীড়নের বিরুদ্ধে ভারতের সহায়তায় গণতান্ত্রিক ও সশস্ত্র সংগ্রামের মধ্য দিয়ে ১৯৭১ খ্রিষ্টাব্দে পূর্ব পাকিস্তান বাংলাদেশ নামক স্বাধীন ও সার্বভৌম জাতিরাষ্ট্র হিসাবে প্রতিষ্ঠিত হয়। স্বাধীনতা পরবর্তী সময়ে দারিদ্র্যপীড়িত বাংলাদেশে বিভিন্ন সময় ঘটেছে দুর্ভিক্ষ ও প্রাকৃতিক দুর্যোগ; এছাড়াও প্রলম্বিত রাজনৈতিক অস্থিতিশীলতা ও পুনঃপৌনিক সামরিক অভ্যুত্থান এদেশের সামগ্রিক রাজনৈতিক স্থিতিশীলতা বারংবার ব্যাহত করেছে। নব্বইয়ের স্বৈরাচার বিরোধী আন্দোলনের মধ্য দিয়ে ১৯৯১ খ্রিষ্টাব্দে সংসদীয় শাসনব্যবস্থা পুনঃপ্রতিষ্ঠিত হয়েছে যার ধারাবাহিকতা আজ অবধি বিদ্যমান। সকল প্রতিকূলতা সত্ত্বেও গত দুই দশকে বাংলাদেশের অর্থনৈতিক প্রগতি ও সমৃদ্ধি সারা বিশ্বে স্বীকৃতি লাভ করেছে।';

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
          duration: Duration(seconds: 1), curve: Curves.linear);
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
        duration: Duration(milliseconds: 30), curve: Curves.linear);
  }

  void loadSectionText() async {
    await loadSectionTextAndHighlights();
    emit(ReaderReady());
    Future.delayed(Duration(milliseconds: 50), () {
      gotoLastLocation();
    });
  }
}
