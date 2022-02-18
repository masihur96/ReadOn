import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';

class AudioApiController extends GetxController {
  RxString bookName = ''.obs;
  RxString writerName = ''.obs;

  RxList audioChapterName = [
    '০১। আধার রাতের শিহরন',
    '০২। কুওাশাচ্ছান্ন ভোর',
    '০৩। শিতের সকাল',
    '০৪। করোনা কাল',
    '০৫। অফিস শেষে',
  ].obs;
  RxList audioMp3 = [
    "https://www.soundhelix.com/examples/mp3/SoundHelix-Song-1.mp3",
    "https://s3.amazonaws.com/scifri-episodes/scifri20181123-episode.mp3",
    "https://www.soundhelix.com/examples/mp3/SoundHelix-Song-2.mp3",
    "https://www.soundhelix.com/examples/mp3/SoundHelix-Song-6.mp3",
    "https://www.soundhelix.com/examples/mp3/SoundHelix-Song-3.mp3"
  ].obs;

  RxString currentMP3 = ''.obs;

  updateBookName(String val) {
    bookName.value = val;
    update();
  }

  // @override
  // void onInit() {
  //   super.onInit();
  //
  //   getChapterContent();
  // }
  // final String domainName = 'http://readon.genextbd.net';
  //
  // RxList<ReadingModel> ContentList = RxList<ReadingModel>([]);
  //
  // int? contentIndex = 0;
  //
  // bool ektuPorun = false;
  //
  // String? bookId;
  //
  // String? note;
  //
  // /// books content List
  // Future<void> getChapterContent(String bookID) async {
  //   bookId = bookID;
  //   String baseUrl = '$domainName/api/booksdetails/$bookID';
  //
  //   try {
  //     // ContentList.clear();
  //     http.Response response = await http.get(Uri.parse(baseUrl));
  //     ContentList.value = readingModelFromJson(response.body);
  //     update();
  //     print(
  //         'getting free book list: ${ContentList[contentIndex!].lessonStory.obs}');
  //   } catch (error) {
  //     // ignore: avoid_print
  //     print('getting free book list error: $error');
  //   }
  // }
}
