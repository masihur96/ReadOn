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
import 'package:read_on/controller/public_controller.dart';
import 'package:read_on/controller/sqlite_database_helper.dart';
import 'package:read_on/eBook/ebook_model_classes/sqlite_database_models/my_book_info_model.dart';
import 'package:read_on/public_variables/color_variable.dart';
import 'package:read_on/public_variables/toast.dart';

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
  List<MyBookInfoModel> myBookList = [];

  void _customInit(DatabaseHelper databaseHelper) async {
    _count++;
    setState(() => _loading = true);
    await databaseHelper.getMyBookList();
    // ignore: avoid_print
    print("my book list length = ${databaseHelper.myBookList.length}");
    setState(() {
      myBookList = databaseHelper.myBookList;
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final PublicController publicController = Get.find();
    final DatabaseHelper databaseHelper = Get.find();
    double size = publicController.size.value;
    if (_count == 0) _customInit(databaseHelper);

    return _loading
        ? const CircularProgressIndicator()
        : Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Icon(FontAwesomeIcons.book, color: Colors.grey,size: size*.15,),
              // SizedBox(height: size*.04,),
              // Text(
              //   'কোন ইবুক পাওয়া যায় নি!',
              //   style: TextStyle(
              //     color: Colors.black,
              //     fontSize: size*.04
              //   ),
              // ),
              ElevatedButton(
                  onPressed: () async {
                    await downloadImage();
                    MyBookInfoModel bookModel = MyBookInfoModel(
                        '20', "চক্ষে আমার তৃষ্ণা", "হুমায়ুন আহমেদ", source);
                    await databaseHelper.insertPurchasedBook(bookModel);
                    showToast("downloaded");
                    // await databaseHelper.getMyBookList();
                    // print("books found: ${databaseHelper.myBookList.length}");
                  },
                  child: const Text("insert")),
              SizedBox(height: size * .04),
              GridView.builder(
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
                  decodeBytes = base64Decode(
                      myBookList[index].bookThumbnail!);
                  return GestureDetector(
                    onTap: () {
                      getCustomPointedPopup(context, size, databaseHelper, index).show(
                        widgetKey: widgetKey,
                      );
                    },
                    child: Column(
                      key: widgetKey,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        /// book image
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
                              child: Image.memory(
                                decodeBytes!,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: publicController.size.value * .01,
                        ),

                        /// book name
                        SizedBox(
                          width: publicController.size.value * .26,
                          child: Text(myBookList[index].bookName,
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
                              myBookList[index].writerName,
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
              )
            ],
          );
    return Container(
      width: Get.width,
      child: Column(
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
                    color: Colors.red),
                child: Image.network(
                    'https://i.pinimg.com/236x/e7/6b/2a/e76b2a468cf1e4b9e479f999c9b09384.jpg')),
          ),
          SizedBox(
            height: size * .04,
          ),
          ElevatedButton(
              onPressed: () async {
                downloadImage();
              },
              child: const Text('download')),
          decodeBytes != null ? Image.memory(decodeBytes!) : SizedBox()
        ],
      ),
    );
  }

  CustomPointedPopup getCustomPointedPopup(BuildContext context, double size, DatabaseHelper databaseHelper, int index) {
    return CustomPointedPopup(
      backgroundColor: Colors.red.withOpacity(0.2),
      context: context,
      widthFractionWithRespectToDeviceWidth: 3,
      displayBelowWidget: true,
      triangleDirection: TriangleDirection.Straight,
      popupElevation: 3,

      ///you can also add border radius
      ////popupBorderRadius:,
      item: CustomPointedPopupItem(
          textStyle: Theme.of(context).textTheme.caption!.copyWith(
                color: Theme.of(context).cardColor,
              ),
          itemWidget: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: size*.04,vertical: size*.02),
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
              SizedBox(
                width: size * .1,
              ),
              GestureDetector(
                onTap: () async {
                  print("deleting clicked!");
                  setState(() =>  _loading = true);
                  await databaseHelper.deleteDownloadedBooks(myBookList[index].bookId, index);
                  setState(() =>  _loading = false);
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: size*.04,vertical: size*.02),
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
          )

          ///Or you can add custom item widget below instead above 3
          ///itemWidget: Container(),
          ),
    );
  }

  Future<void> downloadImage() async {
    print("download start.");

    /// make file
    var response = await http.get(Uri.parse(
        'https://i.gr-assets.com/images/S/compressed.photo.goodreads.com/books/1423233218l/19491488.jpg'));
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
    print(source);

    // var response = await Dio().get(
    //     'https://i.pinimg.com/236x/e7/6b/2a/e76b2a468cf1e4b9e479f999c9b09384.jpg',
    //     options: Options(responseType: ResponseType.bytes));
    // final result = await ImageGallerySaver.saveImage(
    //   Uint8List.fromList(response.data),
    //   quality: 60,
    //   name: DateTime.now().millisecondsSinceEpoch.toString(),
    // );
    // print(result);
    // var path = result['filePath'].toString().replaceAll(RegExp('file://'), '');
    // setState(() {
    //   file = File(path);
    // });

    // ignore: avoid_print
    //print("download complete, path = $path");
  }

  String base64Encode(bytes) => base64.encode(bytes);

  Uint8List base64Decode(String source) => base64.decode(source);

}
