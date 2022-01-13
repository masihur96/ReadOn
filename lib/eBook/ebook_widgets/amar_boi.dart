import 'dart:io';
import 'dart:convert';
import 'dart:typed_data';
import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:custom_pointed_popup/custom_pointed_popup.dart';
import 'package:custom_pointed_popup/utils/triangle_painter.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:read_on/controller/ebook_api_controller.dart';
import 'package:read_on/controller/public_controller.dart';
import 'package:read_on/controller/sqlite_database_helper.dart';
import 'package:read_on/controller/user_controller.dart';
import 'package:read_on/eBook/ebook_model_classes/my_purchased_book_model.dart';
import 'package:read_on/eBook/ebook_model_classes/sqlite_database_models/my_book_info_model.dart';
import 'package:read_on/eBook/ebook_screens/story_preview.dart';
import 'package:read_on/eBook/ebook_widgets/download_dialog.dart';
import 'package:read_on/eBook/ebook_widgets/downloading_progress_dialog.dart';
import 'package:read_on/public_variables/toast.dart';
import 'package:shimmer/shimmer.dart';

class AmarBoi extends StatefulWidget {
  const AmarBoi({Key? key}) : super(key: key);

  @override
  _AmarBoiState createState() => _AmarBoiState();
}

class _AmarBoiState extends State<AmarBoi> {
  int _count = 0;
  File? file;
  String imagePath = '';
  File? mFile;
  String? source;
  Uint8List? decodeBytes;
  bool _loading = false;
  List<Datum> myBookList = [];
  List<String> _downloadedBookIdList = [];
  CustomPointedPopup? customPointedPopup;

  void _customInit(EbookApiController ebookApiController,
      UserController userController, DatabaseHelper databaseHelper) async {
    _count++;
    setState(() => _loading = true);
    await ebookApiController.getMyPurchasedBooks(userController);
    await databaseHelper.getMyBookList();

    print(
        "my book list length = ${ebookApiController.myPurchasedBookModel.value.data!.length}");
    setState(() {
      myBookList = ebookApiController.myPurchasedBookModel.value.data!;
      for (int i = 0; i < databaseHelper.myBookList.length; i++) {
        print(" api id = ${myBookList[i].bookdata![0].id}");
      }
      for (int i = 0; i < databaseHelper.myBookList.length; i++) {
        _downloadedBookIdList.add(databaseHelper.myBookList[i].bookId);
      }
      print("downloaded book id list length = ${_downloadedBookIdList.length}");
      for (int i = 0; i < databaseHelper.myBookList.length; i++) {
        print("id = ${_downloadedBookIdList[i]}");
      }
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final PublicController publicController = Get.find();
    final UserController userController = Get.find();
    final EbookApiController ebookApiController = Get.find();
    final DatabaseHelper databaseHelper = Get.find();
    final double size = publicController.size.value;
    if (_count == 0) {
      _customInit(ebookApiController, userController, databaseHelper);
    }

    return _loading
        ? Shimmer.fromColors(
            baseColor: Colors.grey.shade300,
            highlightColor: Colors.grey.shade100,
            enabled: true,
            child: Padding(
              padding: EdgeInsets.all(size * .03),
              child: GridView.builder(
                  itemCount: 9,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      childAspectRatio: 9 / 15,
                      crossAxisSpacing: 0.7),
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        Container(
                          width: size * .26,
                          height: size * .36,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(size * .01),
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: size * .02),
                        Container(
                          width: size * .26,
                          height: size * .03,
                          color: Colors.white,
                        ),
                        SizedBox(height: size * .02),
                        Container(
                          width: size * .2,
                          height: size * .03,
                          color: Colors.white,
                        )
                      ],
                    );
                  }),
            ),
          )
        : Padding(
            padding: EdgeInsets.symmetric(vertical: size * .03),
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 9 / 13,
                  crossAxisSpacing: 0.7,
                  mainAxisSpacing: 5),
              physics: const ClampingScrollPhysics(),
              shrinkWrap: true,
              itemCount: myBookList.length,
              itemBuilder: (context, index) {
                final GlobalKey widgetKey = GlobalKey();
                bool isDownloaded = _downloadedBookIdList
                        .contains(myBookList[index].bookdata![0].id)
                    ? true
                    : false;
                return GestureDetector(
                  onTap: () {
                    if (_downloadedBookIdList
                        .contains(myBookList[index].bookdata![0].id)) {
                      getCustomPointedPopup(
                              context, size, databaseHelper, index)!
                          .show(
                        widgetKey: widgetKey,
                      );
                    } else {
                      print("bookdetam: ${myBookList[index].bookdata![0].id!}");
                      showDownloadDialog(
                          context,
                          publicController,
                          () => downloadBook(
                              myBookList[index].bookdata![0],
                              databaseHelper,
                              ebookApiController,
                              context,
                              publicController));
                    }
                  },
                  child: Column(
                    key: widgetKey,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      /// book image
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4.0),
                            ),
                            margin: EdgeInsets.zero,
                            child: Container(
                              width: size * .26,
                              height: size * .36,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4.0),
                                  color: Colors.grey.shade50),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(4.0),
                                child: CachedNetworkImage(
                                  fit: BoxFit.cover,
                                  imageUrl:
                                      "${ebookApiController.domainName}/public//frontend/images/book_thumbnail/${myBookList[index].bookdata![0].bookThumbnil!}",
                                  placeholder: (context, url) => Image.asset(
                                    'assets/book_art.png',
                                    fit: BoxFit.contain,
                                  ),
                                  errorWidget: (context, url, error) =>
                                      const Icon(Icons.error),
                                ),
                              ),
                            ),
                          ),
                          isDownloaded
                              ? const SizedBox()
                              : Container(
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.black.withOpacity(0.5)),
                                  padding: EdgeInsets.all(size * .02),
                                  child: Icon(
                                    LineAwesomeIcons.alternate_cloud_download,
                                    color: Colors.white,
                                    size: size * .085,
                                  ),
                                ),
                          Positioned(
                              bottom: 2,
                              left: 2,
                              child: isDownloaded
                                  ? Container(
                                      padding: EdgeInsets.zero,
                                      child: Icon(Icons.check_circle,
                                          color: Colors.green.shade900,
                                          size: size * .05),
                                      decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.white),
                                    )
                                  : const SizedBox())
                        ],
                      ),
                      SizedBox(
                        height: publicController.size.value * .01,
                      ),

                      /// book name
                      SizedBox(
                        width: publicController.size.value * .26,
                        child: Text(
                            myBookList[index].bookdata![0].bookname!.length < 18
                                ? myBookList[index].bookdata![0].bookname!
                                : "${myBookList[index].bookdata![0].bookname!.substring(0, 15)}...",
                            maxLines: 1,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: size * .032,
                                fontWeight: FontWeight.w500)),
                      ),

                      /// writer name
                      SizedBox(
                        width: publicController.size.value * .26,
                        child: Text(
                            myBookList[index].bookdata![0].wname!.length < 18
                                ? myBookList[index].bookdata![0].wname!
                                : "${myBookList[index].bookdata![0].wname!.substring(0, 15)}...",
                            maxLines: 1,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: size * .032,
                                fontWeight: FontWeight.w500)),
                      ),
                    ],
                  ),
                );
              },
            ),
          );
  }

  CustomPointedPopup? getCustomPointedPopup(BuildContext context, double size,
      DatabaseHelper databaseHelper, int index) {
    customPointedPopup = CustomPointedPopup(
      backgroundColor: Colors.red.withOpacity(0.2),
      context: context,
      widthFractionWithRespectToDeviceWidth: 3,
      displayBelowWidget: true,
      triangleDirection: TriangleDirection.Straight,
      popupElevation: 3,
      item: CustomPointedPopupItem(
          textStyle: Theme.of(context).textTheme.caption!.copyWith(
                color: Theme.of(context).cardColor,
              ),
          itemWidget: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                onTap: () {
                  customPointedPopup!.dismiss();
                  Get.to(
                      StoryPreview(bookId: myBookList[index].bookdata![0].id!));
                },
                child: Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: size * .03, vertical: size * .02),
                  child: Column(
                    children: [
                      const Icon(
                        FontAwesomeIcons.bookOpen,
                        color: Colors.black,
                      ),
                      SizedBox(
                        height: size * .02,
                      ),
                      Text(
                        "বই পড়ুন",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: size * .035,
                            fontWeight: FontWeight.w500),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                width: size * .04,
              ),
              InkWell(
                onTap: () async {
                  // ignore: avoid_print
                  print("deleting clicked!");
                  setState(() => _loading = true);
                  await databaseHelper.deleteDownloadedBooks(
                      myBookList[index].bookdata![0].id!, index);
                  setState(() => _loading = false);
                  customPointedPopup!.dismiss();
                },
                child: Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: size * .03, vertical: size * .02),
                  child: Column(
                    children: [
                      Icon(
                        FontAwesomeIcons.times,
                        color: Colors.black,
                        size: size * .08,
                      ),
                      SizedBox(
                        height: size * .02,
                      ),
                      Text(
                        "ডিলিট করুন",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: size * .035,
                            fontWeight: FontWeight.w500),
                      )
                    ],
                  ),
                ),
              ),
            ],
          )),
    );
    return customPointedPopup;
  }

  void downloadBook(
      Bookdatum bookdatum,
      DatabaseHelper databaseHelper,
      EbookApiController ebookApiController,
      BuildContext context,
      PublicController publicController) async {
    Navigator.pop(context);
    showDownloadingProgressDialog(
        context, publicController, bookdatum.bookname!);
    print("${bookdatum.id!} is got");
    await downloadImage(bookdatum.bookThumbnil!, ebookApiController);
    MyBookInfoModel bookInfoModel = MyBookInfoModel(
        bookdatum.id!, bookdatum.bookname!, bookdatum.wname!, source);
    await databaseHelper.insertPurchasedBook(bookInfoModel);
    setState(() {
      _downloadedBookIdList.add(bookdatum.id!);
    });
    Navigator.pop(context);
    showToast("ইবুক ডাউনলোড সম্পন্ন হয়েছে। অফলাইনেও বইটি পড়তে পারবেন।");
    print("hoise");
  }

  Future<void> downloadImage(
      String bookThumbnail, EbookApiController ebookApiController) async {
    // ignore: avoid_print
    print("download start.");
    var response = await http.get(Uri.parse(
        "${ebookApiController.domainName}/public//frontend/images/book_thumbnail/$bookThumbnail"));
    var dir = await getApplicationDocumentsDirectory();
    File file = File(join(dir.path, 'imagetest.png'));
    file.writeAsBytesSync(response.bodyBytes);
    var size = await file.length();
    // ignore: avoid_print
    print("file path = ${dir.path} & file size = $size");

    /// convert file to base64
    final bytes = await file.readAsBytes();
    setState(() {
      source = base64Encode(bytes);
    });
    // ignore: avoid_print
    print(source);
  }

  String base64Encode(bytes) => base64.encode(bytes);

  Uint8List base64Decode(String source) => base64.decode(source);
}
