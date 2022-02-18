import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:read_on/controller/reading_api_controller.dart';
import 'package:read_on/eBook/reading_screen.dart/book_library/model/book.dart';
import 'package:read_on/eBook/reading_screen.dart/book_library/model/section.dart';
import 'package:read_on/eBook/reading_screen.dart/book_library/screens/books/books_screen.dart';

class ReadingScreen extends StatefulWidget {
  const ReadingScreen({Key? key}) : super(key: key);
  @override
  _ReadingScreenState createState() => _ReadingScreenState();
}

class _ReadingScreenState extends State<ReadingScreen> {
  int _count = 0;
  bool _loading = false;
  void _customInit(ReadingApiController readingApiController) async {
    _count++;
    setState(() => _loading = true);
    await readingApiController.getChapterContent(readingApiController.bookId!);

    setState(() {
      _loading = false;
    });
  }

  List content = [
    'ঢাকা দক্ষিণ এশিয়ার রাষ্ট্র বাংলাদেশের রাজধানী ও বৃহত্তম শহর। প্রশাসনিকভাবে এটি ঢাকা জেলার প্রধান শহর। ভৌগোলিকভাবে এটি বাংলাদেশের মধ্যভাগে বুড়িগঙ্গা নদীর উত্তর তীরে একটি সমতল এলাকাতে অবস্থিত। ঢাকা দক্ষিণ এশিয়ায় মুম্বাইয়ের পরে দ্বিতীয় বৃহৎ অর্থনীতির শহর। ঢাকার জিডিপি ১৬২ বিলিয়ন মার্কিন ডলার, ২০২০ সালের হিসেবে। এছাড়া ঢাকার পিপিপি ২৩৫ বিলিয়ন মার্কিন ডলার, ২০২০ সালের হিসেবে। ভৌগোলিকভাবে ঢাকা একটি অতিমহানগরী বা মেগাসিটি; ঢাকা মহানগরী এলাকার জনসংখ্যা প্রায় ২ কোটি ১০ লক্ষ।[৪] জনসংখ্যার বিচারে ঢাকা দক্ষিণ এশিয়ার দ্বিতীয় বৃহত্তম এবং বিশ্বের সপ্তম বৃহত্তম শহর।[৫] জনঘনত্বের বিচারে ঢাকা বিশ্বের সবচেয়ে ঘনবসতিপূর্ণ শহর; ৩০৬ বর্গকিলোমিটার আয়তনের এই শহরে প্রতি বর্গকিলোমিটার এলাকায় ২৩ হাজার লোক বাস করে।[৬] বাংলাদেশ (এই শব্দ সম্পর্কেশুনুন (সাহায্য·তথ্য)) দক্ষিণ এশিয়ার একটি সার্বভৌম রাষ্ট্র। বাংলাদেশের সাংবিধানিক নাম গণপ্রজাতন্ত্রী বাংলাদেশ। ভূ-রাজনৈতিক ভাবে বাংলাদেশের পশ্চিমে ভারতের পশ্চিমবঙ্গ, উত্তরে পশ্চিমবঙ্গ, আসাম ও মেঘালয়, পূর্ব সীমান্তে আসাম, ত্রিপুরা ও মিজোরাম, দক্ষিণ-পূর্ব সীমান্তে মায়ানমারের চিন ও রাখাইন রাজ্য এবং দক্ষিণ উপকূলের দিকে বঙ্গোপসাগর অবস্থিত।[১৪] ভৌগোলিকভাবে পৃথিবীর বৃহত্তম ব-দ্বীপের সিংহভাগ অঞ্চল জুড়ে বাংলাদেশ ভূখণ্ড অবস্থিত। নদীমাতৃক বাংলাদেশ ভূখণ্ডের উপর দিয়ে বয়ে গেছে ৫৭টি আন্তর্জাতিক নদী। বাংলাদেশের উত্তর-পূর্বে ও দক্ষিণ-পূর্বে টারশিয়ারি যুগের পাহাড় ছেয়ে আছে। বিশ্বের বৃহত্তম ম্যানগ্রোভ অরণ্য সুন্দরবন ও দীর্ঘতম প্রাকৃতিক সৈকত কক্সবাজার সমুদ্র সৈকত বাংলাদেশে অবস্থিত।দক্ষিণ এশিয়ার প্রাচীন ও ধ্রুপদী যুগে বাংলাদেশ অঞ্চলটিতে বঙ্গ, পুণ্ড্র, গৌড়, গঙ্গাঋদ্ধি, সমতট ও হরিকেল নামক জনপদ গড়ে উঠেছিল। মৌর্য যুগে মৌর্য সাম্রাজ্যের একটি প্রদেশ ছিল অঞ্চলটি। জনপদগুলো নৌ-শক্তি ও সামুদ্রিক বাণিজ্যের জন্য বিখ্যাত ছিল। মধ্য প্রাচ্য, রোমান সাম্রাজ্যে মসলিন ও সিল্ক রপ্তানি করতো জনপদগুলো। প্রথম সহস্রাব্দিতে বাংলাদেশ অঞ্চলকে কেন্দ্র করে পাল সাম্রাজ্য, চন্দ্র রাজবংশ, সেন রাজবংশ গড়ে উঠেছিল। বখতিয়ার খলজীর গৌড় জয়ের পরে ও দিল্লি সালতানাত আমলে এ অঞ্চলে ইসলাম ছড়িয়ে পরে। ইউরোপীয়রা শাহী বাংলাকে পৃথিবীর সবচেয়ে ধনী বাণিজ্য দেশ হিসেবে গণ্য করতো।[১৫]মুঘল আমলে বিশ্বের মোট উৎপাদনের (জিডিপির) ১২ শতাংশ উৎপন্ন হতো সুবাহ বাংলায়,[১৬][১৭][১৮] যা সে সময় সমগ্র পশ্চিম ইউরোপের জিডিপির চেয়ে বেশি ছিল।[১৯] ১৭৬৫ থেকে ১৯৪৭ পর্যন্ত বাংলাদেশ ভূখণ্ডটি প্রেসিডেন্সি বাংলার অংশ ছিল। ১৯৪৭-এর ভারত ভাগের পর বাংলাদেশ অঞ্চল পূর্ব বাংলা (১৯৪৭–১৯৫৬; পূর্ব পাকিস্তান, ১৯৫৬–১৯৭১) নামে নবগঠিত পাকিস্তান অধিরাজ্যের অন্তর্ভুক্ত হয়। ১৯৪৭ থেকে ১৯৫৬ পর্যন্ত বাংলা ভাষা আন্দোলনকে কেন্দ্র করে বাঙালি জাতীয়তাবাদের বিকাশ হলে পশ্চিম পাকিস্তানের বিবিধ রাজনৈতিক, সাংস্কৃতিক ও অর্থনৈতিক শোষণ, বৈষম্য ও নিপীড়নের বিরুদ্ধে ভারতের সহায়তায় গণতান্ত্রিক ও সশস্ত্র সংগ্রামের মধ্য দিয়ে ১৯৭১ খ্রিষ্টাব্দে পূর্ব পাকিস্তান বাংলাদেশ নামক স্বাধীন ও সার্বভৌম জাতিরাষ্ট্র হিসাবে প্রতিষ্ঠিত হয়। স্বাধীনতা পরবর্তী সময়ে দারিদ্র্যপীড়িত বাংলাদেশে বিভিন্ন সময় ঘটেছে দুর্ভিক্ষ ও প্রাকৃতিক দুর্যোগ; এছাড়াও প্রলম্বিত রাজনৈতিক অস্থিতিশীলতা ও পুনঃপৌনিক সামরিক অভ্যুত্থান এদেশের সামগ্রিক রাজনৈতিক স্থিতিশীলতা বারংবার ব্যাহত করেছে। নব্বইয়ের স্বৈরাচার বিরোধী আন্দোলনের মধ্য দিয়ে ১৯৯১ খ্রিষ্টাব্দে সংসদীয় শাসনব্যবস্থা পুনঃপ্রতিষ্ঠিত হয়েছে যার ধারাবাহিকতা আজ অবধি বিদ্যমান। সকল প্রতিকূলতা সত্ত্বেও গত দুই দশকে বাংলাদেশের অর্থনৈতিক প্রগতি ও সমৃদ্ধি সারা বিশ্বে স্বীকৃতি লাভ করেছে।',
    'প্রশাসনিকভাবে এটি ঢাকা জেলার প্রধান শহর। ভৌগোলিকভাবে এটি বাংলাদেশের মধ্যভাগে বুড়িগঙ্গা নদীর উত্তর তীরে একটি সমতল এলাকাতে অবস্থিত। ঢাকা দক্ষিণ এশিয়ায় মুম্বাইয়ের পরে দ্বিতীয় বৃহৎ অর্থনীতির শহর। ঢাকার জিডিপি ১৬২ বিলিয়ন মার্কিন ডলার, ২০২০ সালের হিসেবে। এছাড়া ঢাকার পিপিপি ২৩৫ বিলিয়ন মার্কিন ডলার, ২০২০ সালের হিসেবে। ভৌগোলিকভাবে ঢাকা একটি অতিমহানগরী বা মেগাসিটি; ঢাকা মহানগরী এলাকার জনসংখ্যা প্রায় ২ কোটি ১০ লক্ষ।[৪] জনসংখ্যার বিচারে ঢাকা দক্ষিণ এশিয়ার দ্বিতীয় বৃহত্তম এবং বিশ্বের সপ্তম বৃহত্তম শহর।[৫] জনঘনত্বের বিচারে ঢাকা বিশ্বের সবচেয়ে ঘনবসতিপূর্ণ শহর; ৩০৬ বর্গকিলোমিটার আয়তনের এই শহরে প্রতি বর্গকিলোমিটার এলাকায় ২৩ হাজার লোক বাস করে।[৬] বাংলাদেশ (এই শব্দ সম্পর্কেশুনুন (সাহায্য·তথ্য)) দক্ষিণ এশিয়ার একটি সার্বভৌম রাষ্ট্র। বাংলাদেশের সাংবিধানিক নাম গণপ্রজাতন্ত্রী বাংলাদেশ। ভূ-রাজনৈতিক ভাবে বাংলাদেশের পশ্চিমে ভারতের পশ্চিমবঙ্গ, উত্তরে পশ্চিমবঙ্গ, আসাম ও মেঘালয়, পূর্ব সীমান্তে আসাম, ত্রিপুরা ও মিজোরাম, দক্ষিণ-পূর্ব সীমান্তে মায়ানমারের চিন ও রাখাইন রাজ্য এবং দক্ষিণ উপকূলের দিকে বঙ্গোপসাগর অবস্থিত।[১৪] ভৌগোলিকভাবে পৃথিবীর বৃহত্তম ব-দ্বীপের সিংহভাগ অঞ্চল জুড়ে বাংলাদেশ ভূখণ্ড অবস্থিত। নদীমাতৃক বাংলাদেশ ভূখণ্ডের উপর দিয়ে বয়ে গেছে ৫৭টি আন্তর্জাতিক নদী। বাংলাদেশের উত্তর-পূর্বে ও দক্ষিণ-পূর্বে টারশিয়ারি যুগের পাহাড় ছেয়ে আছে। বিশ্বের বৃহত্তম ম্যানগ্রোভ অরণ্য সুন্দরবন ও দীর্ঘতম প্রাকৃতিক সৈকত কক্সবাজার সমুদ্র সৈকত বাংলাদেশে অবস্থিত।দক্ষিণ এশিয়ার প্রাচীন ও ধ্রুপদী যুগে বাংলাদেশ অঞ্চলটিতে বঙ্গ, পুণ্ড্র, গৌড়, গঙ্গাঋদ্ধি, সমতট ও হরিকেল নামক জনপদ গড়ে উঠেছিল। মৌর্য যুগে মৌর্য সাম্রাজ্যের একটি প্রদেশ ছিল অঞ্চলটি। জনপদগুলো নৌ-শক্তি ও সামুদ্রিক বাণিজ্যের জন্য বিখ্যাত ছিল। মধ্য প্রাচ্য, রোমান সাম্রাজ্যে মসলিন ও সিল্ক রপ্তানি করতো জনপদগুলো। প্রথম সহস্রাব্দিতে বাংলাদেশ অঞ্চলকে কেন্দ্র করে পাল সাম্রাজ্য, চন্দ্র রাজবংশ, সেন রাজবংশ গড়ে উঠেছিল। বখতিয়ার খলজীর গৌড় জয়ের পরে ও দিল্লি সালতানাত আমলে এ অঞ্চলে ইসলাম ছড়িয়ে পরে। ইউরোপীয়রা শাহী বাংলাকে পৃথিবীর সবচেয়ে ধনী বাণিজ্য দেশ হিসেবে গণ্য করতো।[১৫]মুঘল আমলে বিশ্বের মোট উৎপাদনের (জিডিপির) ১২ শতাংশ উৎপন্ন হতো সুবাহ বাংলায়,[১৬][১৭][১৮] যা সে সময় সমগ্র পশ্চিম ইউরোপের জিডিপির চেয়ে বেশি ছিল।[১৯] ১৭৬৫ থেকে ১৯৪৭ পর্যন্ত বাংলাদেশ ভূখণ্ডটি প্রেসিডেন্সি বাংলার অংশ ছিল। ১৯৪৭-এর ভারত ভাগের পর বাংলাদেশ অঞ্চল পূর্ব বাংলা (১৯৪৭–১৯৫৬; পূর্ব পাকিস্তান, ১৯৫৬–১৯৭১) নামে নবগঠিত পাকিস্তান অধিরাজ্যের অন্তর্ভুক্ত হয়। ১৯৪৭ থেকে ১৯৫৬ পর্যন্ত বাংলা ভাষা আন্দোলনকে কেন্দ্র করে বাঙালি জাতীয়তাবাদের বিকাশ হলে পশ্চিম পাকিস্তানের বিবিধ রাজনৈতিক, সাংস্কৃতিক ও অর্থনৈতিক শোষণ, বৈষম্য ও নিপীড়নের বিরুদ্ধে ভারতের সহায়তায় গণতান্ত্রিক ও সশস্ত্র সংগ্রামের মধ্য দিয়ে ১৯৭১ খ্রিষ্টাব্দে পূর্ব পাকিস্তান বাংলাদেশ নামক স্বাধীন ও সার্বভৌম জাতিরাষ্ট্র হিসাবে প্রতিষ্ঠিত হয়। স্বাধীনতা পরবর্তী সময়ে দারিদ্র্যপীড়িত বাংলাদেশে বিভিন্ন সময় ঘটেছে দুর্ভিক্ষ ও প্রাকৃতিক দুর্যোগ; এছাড়াও প্রলম্বিত রাজনৈতিক অস্থিতিশীলতা ও পুনঃপৌনিক সামরিক অভ্যুত্থান এদেশের সামগ্রিক রাজনৈতিক স্থিতিশীলতা বারংবার ব্যাহত করেছে। নব্বইয়ের স্বৈরাচার বিরোধী আন্দোলনের মধ্য দিয়ে ১৯৯১ খ্রিষ্টাব্দে সংসদীয় শাসনব্যবস্থা পুনঃপ্রতিষ্ঠিত হয়েছে যার ধারাবাহিকতা আজ অবধি বিদ্যমান। সকল প্রতিকূলতা সত্ত্বেও গত দুই দশকে বাংলাদেশের অর্থনৈতিক প্রগতি ও সমৃদ্ধি সারা বিশ্বে স্বীকৃতি লাভ করেছে।',
    'ভৌগোলিকভাবে এটি বাংলাদেশের মধ্যভাগে বুড়িগঙ্গা নদীর উত্তর তীরে একটি সমতল এলাকাতে অবস্থিত। ঢাকা দক্ষিণ এশিয়ায় মুম্বাইয়ের পরে দ্বিতীয় বৃহৎ অর্থনীতির শহর। ঢাকার জিডিপি ১৬২ বিলিয়ন মার্কিন ডলার, ২০২০ সালের হিসেবে। এছাড়া ঢাকার পিপিপি ২৩৫ বিলিয়ন মার্কিন ডলার, ২০২০ সালের হিসেবে। ভৌগোলিকভাবে ঢাকা একটি অতিমহানগরী বা মেগাসিটি; ঢাকা মহানগরী এলাকার জনসংখ্যা প্রায় ২ কোটি ১০ লক্ষ।[৪] জনসংখ্যার বিচারে ঢাকা দক্ষিণ এশিয়ার দ্বিতীয় বৃহত্তম এবং বিশ্বের সপ্তম বৃহত্তম শহর।[৫] জনঘনত্বের বিচারে ঢাকা বিশ্বের সবচেয়ে ঘনবসতিপূর্ণ শহর; ৩০৬ বর্গকিলোমিটার আয়তনের এই শহরে প্রতি বর্গকিলোমিটার এলাকায় ২৩ হাজার লোক বাস করে।[৬] বাংলাদেশ (এই শব্দ সম্পর্কেশুনুন (সাহায্য·তথ্য)) দক্ষিণ এশিয়ার একটি সার্বভৌম রাষ্ট্র। বাংলাদেশের সাংবিধানিক নাম গণপ্রজাতন্ত্রী বাংলাদেশ। ভূ-রাজনৈতিক ভাবে বাংলাদেশের পশ্চিমে ভারতের পশ্চিমবঙ্গ, উত্তরে পশ্চিমবঙ্গ, আসাম ও মেঘালয়, পূর্ব সীমান্তে আসাম, ত্রিপুরা ও মিজোরাম, দক্ষিণ-পূর্ব সীমান্তে মায়ানমারের চিন ও রাখাইন রাজ্য এবং দক্ষিণ উপকূলের দিকে বঙ্গোপসাগর অবস্থিত।[১৪] ভৌগোলিকভাবে পৃথিবীর বৃহত্তম ব-দ্বীপের সিংহভাগ অঞ্চল জুড়ে বাংলাদেশ ভূখণ্ড অবস্থিত। নদীমাতৃক বাংলাদেশ ভূখণ্ডের উপর দিয়ে বয়ে গেছে ৫৭টি আন্তর্জাতিক নদী। বাংলাদেশের উত্তর-পূর্বে ও দক্ষিণ-পূর্বে টারশিয়ারি যুগের পাহাড় ছেয়ে আছে। বিশ্বের বৃহত্তম ম্যানগ্রোভ অরণ্য সুন্দরবন ও দীর্ঘতম প্রাকৃতিক সৈকত কক্সবাজার সমুদ্র সৈকত বাংলাদেশে অবস্থিত।দক্ষিণ এশিয়ার প্রাচীন ও ধ্রুপদী যুগে বাংলাদেশ অঞ্চলটিতে বঙ্গ, পুণ্ড্র, গৌড়, গঙ্গাঋদ্ধি, সমতট ও হরিকেল নামক জনপদ গড়ে উঠেছিল। মৌর্য যুগে মৌর্য সাম্রাজ্যের একটি প্রদেশ ছিল অঞ্চলটি। জনপদগুলো নৌ-শক্তি ও সামুদ্রিক বাণিজ্যের জন্য বিখ্যাত ছিল। মধ্য প্রাচ্য, রোমান সাম্রাজ্যে মসলিন ও সিল্ক রপ্তানি করতো জনপদগুলো। প্রথম সহস্রাব্দিতে বাংলাদেশ অঞ্চলকে কেন্দ্র করে পাল সাম্রাজ্য, চন্দ্র রাজবংশ, সেন রাজবংশ গড়ে উঠেছিল। বখতিয়ার খলজীর গৌড় জয়ের পরে ও দিল্লি সালতানাত আমলে এ অঞ্চলে ইসলাম ছড়িয়ে পরে। ইউরোপীয়রা শাহী বাংলাকে পৃথিবীর সবচেয়ে ধনী বাণিজ্য দেশ হিসেবে গণ্য করতো।[১৫]মুঘল আমলে বিশ্বের মোট উৎপাদনের (জিডিপির) ১২ শতাংশ উৎপন্ন হতো সুবাহ বাংলায়,[১৬][১৭][১৮] যা সে সময় সমগ্র পশ্চিম ইউরোপের জিডিপির চেয়ে বেশি ছিল।[১৯] ১৭৬৫ থেকে ১৯৪৭ পর্যন্ত বাংলাদেশ ভূখণ্ডটি প্রেসিডেন্সি বাংলার অংশ ছিল। ১৯৪৭-এর ভারত ভাগের পর বাংলাদেশ অঞ্চল পূর্ব বাংলা (১৯৪৭–১৯৫৬; পূর্ব পাকিস্তান, ১৯৫৬–১৯৭১) নামে নবগঠিত পাকিস্তান অধিরাজ্যের অন্তর্ভুক্ত হয়। ১৯৪৭ থেকে ১৯৫৬ পর্যন্ত বাংলা ভাষা আন্দোলনকে কেন্দ্র করে বাঙালি জাতীয়তাবাদের বিকাশ হলে পশ্চিম পাকিস্তানের বিবিধ রাজনৈতিক, সাংস্কৃতিক ও অর্থনৈতিক শোষণ, বৈষম্য ও নিপীড়নের বিরুদ্ধে ভারতের সহায়তায় গণতান্ত্রিক ও সশস্ত্র সংগ্রামের মধ্য দিয়ে ১৯৭১ খ্রিষ্টাব্দে পূর্ব পাকিস্তান বাংলাদেশ নামক স্বাধীন ও সার্বভৌম জাতিরাষ্ট্র হিসাবে প্রতিষ্ঠিত হয়। স্বাধীনতা পরবর্তী সময়ে দারিদ্র্যপীড়িত বাংলাদেশে বিভিন্ন সময় ঘটেছে দুর্ভিক্ষ ও প্রাকৃতিক দুর্যোগ; এছাড়াও প্রলম্বিত রাজনৈতিক অস্থিতিশীলতা ও পুনঃপৌনিক সামরিক অভ্যুত্থান এদেশের সামগ্রিক রাজনৈতিক স্থিতিশীলতা বারংবার ব্যাহত করেছে। নব্বইয়ের স্বৈরাচার বিরোধী আন্দোলনের মধ্য দিয়ে ১৯৯১ খ্রিষ্টাব্দে সংসদীয় শাসনব্যবস্থা পুনঃপ্রতিষ্ঠিত হয়েছে যার ধারাবাহিকতা আজ অবধি বিদ্যমান। সকল প্রতিকূলতা সত্ত্বেও গত দুই দশকে বাংলাদেশের অর্থনৈতিক প্রগতি ও সমৃদ্ধি সারা বিশ্বে স্বীকৃতি লাভ করেছে।',
    'বুড়িগঙ্গা নদীর উত্তর তীরে একটি সমতল এলাকাতে অবস্থিত। ঢাকা দক্ষিণ এশিয়ায় মুম্বাইয়ের পরে দ্বিতীয় বৃহৎ অর্থনীতির শহর। ঢাকার জিডিপি ১৬২ বিলিয়ন মার্কিন ডলার, ২০২০ সালের হিসেবে। এছাড়া ঢাকার পিপিপি ২৩৫ বিলিয়ন মার্কিন ডলার, ২০২০ সালের হিসেবে। ভৌগোলিকভাবে ঢাকা একটি অতিমহানগরী বা মেগাসিটি; ঢাকা মহানগরী এলাকার জনসংখ্যা প্রায় ২ কোটি ১০ লক্ষ।[৪] জনসংখ্যার বিচারে ঢাকা দক্ষিণ এশিয়ার দ্বিতীয় বৃহত্তম এবং বিশ্বের সপ্তম বৃহত্তম শহর।[৫] জনঘনত্বের বিচারে ঢাকা বিশ্বের সবচেয়ে ঘনবসতিপূর্ণ শহর; ৩০৬ বর্গকিলোমিটার আয়তনের এই শহরে প্রতি বর্গকিলোমিটার এলাকায় ২৩ হাজার লোক বাস করে।[৬] বাংলাদেশ (এই শব্দ সম্পর্কেশুনুন (সাহায্য·তথ্য)) দক্ষিণ এশিয়ার একটি সার্বভৌম রাষ্ট্র। বাংলাদেশের সাংবিধানিক নাম গণপ্রজাতন্ত্রী বাংলাদেশ। ভূ-রাজনৈতিক ভাবে বাংলাদেশের পশ্চিমে ভারতের পশ্চিমবঙ্গ, উত্তরে পশ্চিমবঙ্গ, আসাম ও মেঘালয়, পূর্ব সীমান্তে আসাম, ত্রিপুরা ও মিজোরাম, দক্ষিণ-পূর্ব সীমান্তে মায়ানমারের চিন ও রাখাইন রাজ্য এবং দক্ষিণ উপকূলের দিকে বঙ্গোপসাগর অবস্থিত।[১৪] ভৌগোলিকভাবে পৃথিবীর বৃহত্তম ব-দ্বীপের সিংহভাগ অঞ্চল জুড়ে বাংলাদেশ ভূখণ্ড অবস্থিত। নদীমাতৃক বাংলাদেশ ভূখণ্ডের উপর দিয়ে বয়ে গেছে ৫৭টি আন্তর্জাতিক নদী। বাংলাদেশের উত্তর-পূর্বে ও দক্ষিণ-পূর্বে টারশিয়ারি যুগের পাহাড় ছেয়ে আছে। বিশ্বের বৃহত্তম ম্যানগ্রোভ অরণ্য সুন্দরবন ও দীর্ঘতম প্রাকৃতিক সৈকত কক্সবাজার সমুদ্র সৈকত বাংলাদেশে অবস্থিত।দক্ষিণ এশিয়ার প্রাচীন ও ধ্রুপদী যুগে বাংলাদেশ অঞ্চলটিতে বঙ্গ, পুণ্ড্র, গৌড়, গঙ্গাঋদ্ধি, সমতট ও হরিকেল নামক জনপদ গড়ে উঠেছিল। মৌর্য যুগে মৌর্য সাম্রাজ্যের একটি প্রদেশ ছিল অঞ্চলটি। জনপদগুলো নৌ-শক্তি ও সামুদ্রিক বাণিজ্যের জন্য বিখ্যাত ছিল। মধ্য প্রাচ্য, রোমান সাম্রাজ্যে মসলিন ও সিল্ক রপ্তানি করতো জনপদগুলো। প্রথম সহস্রাব্দিতে বাংলাদেশ অঞ্চলকে কেন্দ্র করে পাল সাম্রাজ্য, চন্দ্র রাজবংশ, সেন রাজবংশ গড়ে উঠেছিল। বখতিয়ার খলজীর গৌড় জয়ের পরে ও দিল্লি সালতানাত আমলে এ অঞ্চলে ইসলাম ছড়িয়ে পরে। ইউরোপীয়রা শাহী বাংলাকে পৃথিবীর সবচেয়ে ধনী বাণিজ্য দেশ হিসেবে গণ্য করতো।[১৫]মুঘল আমলে বিশ্বের মোট উৎপাদনের (জিডিপির) ১২ শতাংশ উৎপন্ন হতো সুবাহ বাংলায়,[১৬][১৭][১৮] যা সে সময় সমগ্র পশ্চিম ইউরোপের জিডিপির চেয়ে বেশি ছিল।[১৯] ১৭৬৫ থেকে ১৯৪৭ পর্যন্ত বাংলাদেশ ভূখণ্ডটি প্রেসিডেন্সি বাংলার অংশ ছিল। ১৯৪৭-এর ভারত ভাগের পর বাংলাদেশ অঞ্চল পূর্ব বাংলা (১৯৪৭–১৯৫৬; পূর্ব পাকিস্তান, ১৯৫৬–১৯৭১) নামে নবগঠিত পাকিস্তান অধিরাজ্যের অন্তর্ভুক্ত হয়। ১৯৪৭ থেকে ১৯৫৬ পর্যন্ত বাংলা ভাষা আন্দোলনকে কেন্দ্র করে বাঙালি জাতীয়তাবাদের বিকাশ হলে পশ্চিম পাকিস্তানের বিবিধ রাজনৈতিক, সাংস্কৃতিক ও অর্থনৈতিক শোষণ, বৈষম্য ও নিপীড়নের বিরুদ্ধে ভারতের সহায়তায় গণতান্ত্রিক ও সশস্ত্র সংগ্রামের মধ্য দিয়ে ১৯৭১ খ্রিষ্টাব্দে পূর্ব পাকিস্তান বাংলাদেশ নামক স্বাধীন ও সার্বভৌম জাতিরাষ্ট্র হিসাবে প্রতিষ্ঠিত হয়। স্বাধীনতা পরবর্তী সময়ে দারিদ্র্যপীড়িত বাংলাদেশে বিভিন্ন সময় ঘটেছে দুর্ভিক্ষ ও প্রাকৃতিক দুর্যোগ; এছাড়াও প্রলম্বিত রাজনৈতিক অস্থিতিশীলতা ও পুনঃপৌনিক সামরিক অভ্যুত্থান এদেশের সামগ্রিক রাজনৈতিক স্থিতিশীলতা বারংবার ব্যাহত করেছে। নব্বইয়ের স্বৈরাচার বিরোধী আন্দোলনের মধ্য দিয়ে ১৯৯১ খ্রিষ্টাব্দে সংসদীয় শাসনব্যবস্থা পুনঃপ্রতিষ্ঠিত হয়েছে যার ধারাবাহিকতা আজ অবধি বিদ্যমান। সকল প্রতিকূলতা সত্ত্বেও গত দুই দশকে বাংলাদেশের অর্থনৈতিক প্রগতি ও সমৃদ্ধি সারা বিশ্বে স্বীকৃতি লাভ করেছে।',
  ];

  List chapterName = [
    'Mukaddimat',
    'İkinci Mesele',
    'İkinci',
    'Mesele',
  ];

  @override
  Widget build(BuildContext context) {
    final ReadingApiController readingApiController = Get.find();
    //  if (_count == 0) _customInit(readingApiController);
    return Scaffold(
      backgroundColor: Colors.white,
      body: BooksScreen(
        title: 'Books',
        booksAssetsFolder: "assets/books/",
        books: [
          Book(
            title: 'Musa',
            assetFolder: 'asayi_musa',
            sections: [
              Section(
                title: chapterName[0],
                fileName: content[0],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
