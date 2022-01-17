import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:read_on/controller/sqlite_database_helper.dart';
import 'package:read_on/eBook/ebook_model_classes/sqlite_database_models/downloaded_chapter_model.dart';

class StoryPreview extends StatefulWidget {
  String bookId;

  StoryPreview({Key? key, required this.bookId}) : super(key: key);

  @override
  _StoryPreviewState createState() => _StoryPreviewState();
}

class _StoryPreviewState extends State<StoryPreview> {
  int count = 0;
  List<DownloadedChapterModel> lessonsList = [];

  _customInit(DatabaseHelper databaseHelper) async {
    count++;
    await databaseHelper.getLessonList(widget.bookId);
    setState(() {
      lessonsList = databaseHelper.lessonsList;
    });
    print("lesson list = ${lessonsList.length}");
  }

  @override
  Widget build(BuildContext context) {
    final DatabaseHelper databaseHelper = Get.find();
    if (count == 0) _customInit(databaseHelper);
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView.builder(
          shrinkWrap: true,
          physics: ClampingScrollPhysics(),
          itemCount: lessonsList.length,
          itemBuilder: (context, index) {
            return Column(
              children: [
                Text(lessonsList[index].chapterName),
                SizedBox(
                  height: 10,
                ),
                Text(lessonsList[index].story),
                SizedBox(
                  height: 10,
                ),
              ],
            );
          }),
    );
  }
}
