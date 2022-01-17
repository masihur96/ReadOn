import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:read_on/controller/sqlite_database_helper.dart';
import 'package:read_on/controller/sqlite_reading_helper.dart';
import 'package:read_on/eBook/ebook_model_classes/product.dart';
import 'package:read_on/eBook/ebook_model_classes/reading_model.dart';
import 'package:read_on/eBook/ebook_model_classes/sqlite_database_models/note_model.dart';
import 'package:read_on/public_variables/toast.dart';

class ReadingApiController extends GetxController {
  RxDouble redingFontSize = 20.0.obs;
  RxString selectedFont = ''.obs;
  RxDouble colorOpacity = 0.0.obs;
  RxBool isScreenFit = false.obs;
  RxString bookName = ''.obs;
  RxInt fontCircleColor = 1.obs;
  RxInt bgCircleColor = 1.obs;
  var readerBloc;

  //make_node
  RxString selectedText = ''.obs;
  RxString selectedNoteText = ''.obs;
  RxString selectedSaveText = ''.obs;

  //DatabaseHelper databaseHelper = DatabaseHelper();
  ReadingDatabaseHelper databaseHelper = ReadingDatabaseHelper();
  updateSaveValue(String val) {
    selectedSaveText.value = val;
    update();
    print('FromController: $selectedSaveText');

    if (val == 'save') {
      print('Function save');
    } else {
      showDialog(
          context: Get.context!,
          builder: (context) {
            final TextEditingController _textFieldController =
                TextEditingController();
            return AlertDialog(
              title: const Text('Save'),
              content: TextField(
                controller: _textFieldController,
                decoration: const InputDecoration(hintText: "Save"),
                onChanged: (val) {},
              ),
              actions: <Widget>[
                ElevatedButton(
                  child: const Text('CANCEL'),
                  onPressed: () {
                    //  Navigator.pop(context);
                  },
                ),
                ElevatedButton(
                  child: const Text('OK'),
                  onPressed: () async {
                    print(_textFieldController.text);

                    NoteModel noteModel = NoteModel(
                      bookId,
                      _textFieldController.text,
                      note,
                    );
                    await databaseHelper.insertNoteData(noteModel);
                    _textFieldController.clear();
                    showToast("Successfully Note Saved");

                    await databaseHelper.getNoteList();
                    print("Note found: ${databaseHelper.noteList.length}");
                    // Navigator.pop(context);
                  },
                ),
              ],
            );
          });
      print('Function note');
    }
  }

  // updateNoteValue(String val) {
  //   selectedNoteText.value = val;
  //   update();
  //   print('FromController: $selectedNoteText');
  // }

  updateSelectedText(String val) {
    selectedText.value = val;
    print('FromController Text: $selectedText');
    update();
  }

  updateBookName(String val) {
    bookName.value = val;
    update();
  }

  updateFontCircleColor(int val) {
    fontCircleColor.value = val;
    update();
    print(fontCircleColor);
  }

  updateScreenFitMode(bool val) {
    isScreenFit.value = val;

    update();
  }

  updateColorMode(int val) {
    bgCircleColor.value = val;

    update();

    print(bgCircleColor);
  }

  updateSize(double val) {
    redingFontSize.value = val;

    update();
  }

  updateFont(String val) {
    selectedFont.value = val;

    update();
    print(selectedFont);
  }

  updateColorOpacity(double val) {
    colorOpacity.value = val;

    update();

    //  print(colorOpacity);
  }

  // @override
  // void onInit() {
  //   super.onInit();
  //
  //   getChapterContent();
  // }
  final String domainName = 'http://readon.genextbd.net';

  RxList<ReadingModel> ContentList = RxList<ReadingModel>([]);

  int? contentIndex = 0;

  bool ektuPorun = false;

  String? bookId;

  String? note;

  /// books content List
  Future<void> getChapterContent(String bookID) async {
    bookId = bookID;
    String baseUrl = '$domainName/api/booksdetails/$bookID';

    try {
      // ContentList.clear();
      http.Response response = await http.get(Uri.parse(baseUrl));
      ContentList.value = readingModelFromJson(response.body);
      update();
      print(
          'getting free book list: ${ContentList[contentIndex!].lessonStory.obs}');
    } catch (error) {
      // ignore: avoid_print
      print('getting free book list error: $error');
    }
  }
}
