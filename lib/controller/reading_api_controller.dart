
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
  RxInt fontCircleColor=1.obs;


  RxInt bgCircleColor = 1.obs;


  var  readerBloc;

  updateBookName(String val){
    bookName.value = val ;
    update();
  }
  updateFontCircleColor(int val){
    fontCircleColor.value = val ;
    update();
    print(fontCircleColor);
  }

  updateScreenFitMode(bool val){

    isScreenFit.value = val ;

    update();


  }

  updateColorMode(int val){

    bgCircleColor.value = val ;

    update();

     print(bgCircleColor);
  }


  updateSize(double val){

    redingFontSize.value = val ;

    update();
  }
  updateFont(String val){

    selectedFont.value = val ;

    update();
    print(selectedFont);
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
  final String domainName = 'http://readon.genextbd.net';

  RxList<ReadingModel> ContentList = RxList<ReadingModel>([]);

  int? contentIndex = 0;

  bool ektuPorun =false;


  String? bookId ;
  /// books content List
  Future<void> getChapterContent(String bookID ) async {

    bookId = bookID;
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