
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:read_on/eBook/ebook_model_classes/product.dart';
import 'package:read_on/eBook/ebook_model_classes/reading_model.dart';


class ReadingApiController extends GetxController {

  RxDouble redingFontSize=20.0.obs ;
  RxString selectedFont=''.obs;
  RxDouble colorOpacity=0.0.obs;
  RxBool isScreenFit =false.obs;

  RxString bookName=''.obs;


  var bgColor = Color(0xff1a237e).obs;

  updateBookName(String val){

    bookName.value = val ;

    update();

    print(bgColor);
  }

  updateScreenFitMode(bool val){

    isScreenFit.value = val ;

    update();

    print(bgColor);
  }

  updateColorMode(Color val){

    bgColor.value = val ;

    update();

     print(bgColor);
  }


  updateSize(double val){

    redingFontSize.value = val ;

    update();
  }
  updateFont(String val){

    selectedFont.value = val ;

    update();
    // print(selectedFont);
  }

  updateColorOpacity(double val){

    colorOpacity.value = val ;

    update();

  //  print(colorOpacity);
  }






  // @override
  // void onInit() {
  //   super.onInit();
  //
  //   getChapterContent();
  // }
  final String domainName = 'http://readon.glamworlditltd.com';

  RxList<ReadingModel> ContentList = RxList<ReadingModel>([]);

  int? contentIndex = 0;

  bool ektuPorun =false;

  /// books content List
  Future<void> getChapterContent(String bookID ) async {
    String baseUrl = '$domainName/api/booksdetails/$bookID';

    try {
    // ContentList.clear();
      http.Response response = await http.get(Uri.parse(baseUrl));
      ContentList.value = readingModelFromJson(response.body);
      update();
      print('getting free book list: ${ContentList[contentIndex!].lessonStory.obs}');
    } catch (error) {
      // ignore: avoid_print
      print('getting free book list error: $error');
    }
  }


}