
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:read_on/eBook/ebook_model_classes/product.dart';
import 'package:read_on/eBook/ebook_model_classes/reading_model.dart';


class ReadingApiController extends GetxController {
  // @override
  // void onInit() {
  //   super.onInit();
  //
  //   getChapterContent();
  // }
  final String domainName = 'http://readon.glamworlditltd.com';

  RxList<ReadingModel> ContentList = RxList<ReadingModel>([]);

  String? bookIndex ='48';
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