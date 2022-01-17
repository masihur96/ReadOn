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

  @override
  Widget build(BuildContext context) {
    final ReadingApiController readingApiController = Get.find();
    if (_count == 0) _customInit(readingApiController);
    return Scaffold(
      backgroundColor: Colors.white,
      body: _loading == true
          ? Center(child: Text('অপেক্ষা করুন'))
          : readingApiController.ContentList.isEmpty
              ? Center(child: Text("কোন লেখা খুজে পাওয়া যায় নি।"))
              : BooksScreen(
                  title: 'Books',
                  booksAssetsFolder: "assets/books/",
                  books: [
                    Book(
                      title: 'Musa',
                      assetFolder: 'asayi_musa',
                      sections: [
                        Section(
                          title: readingApiController.ContentList[0].lesson,
                          fileName:
                              readingApiController.ContentList[0].lessonStory!,
                        ),
                      ],
                    ),
                  ],
                ),
    );
  }
}
