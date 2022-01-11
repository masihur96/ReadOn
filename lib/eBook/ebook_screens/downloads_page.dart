import 'dart:convert';
import 'dart:typed_data';

import 'package:custom_pointed_popup/custom_pointed_popup.dart';
import 'package:custom_pointed_popup/utils/triangle_painter.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:read_on/controller/public_controller.dart';
import 'package:read_on/controller/sqlite_database_helper.dart';
import 'package:read_on/eBook/ebook_model_classes/sqlite_database_models/my_book_info_model.dart';
import 'package:read_on/eBook/ebook_widgets/custom_appbar.dart';

class DownloadsPage extends StatefulWidget {
  const DownloadsPage({Key? key}) : super(key: key);

  @override
  _DownloadsPageState createState() => _DownloadsPageState();
}

class _DownloadsPageState extends State<DownloadsPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  int _count = 0;
  bool _loading = false;
  List<MyBookInfoModel> myBookList = [];
  Uint8List? decodeBytes;


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
    final double size = publicController.size.value;
    if (_count == 0) _customInit(databaseHelper);
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: PreferredSize(
            preferredSize: AppBar().preferredSize, child: _pageAppBar()),
        body: _bodyUI(size, databaseHelper),
      ),
    );
  }

  Widget _bodyUI(double size, DatabaseHelper databaseHelper) => SizedBox(
        width: Get.width,
        height: Get.height,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: size * .02),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    childAspectRatio: 9 / 13,
                    crossAxisSpacing: 0.7,
                    mainAxisSpacing: 5),
                physics: const ClampingScrollPhysics(),
                // shrinkWrap: true,
                itemCount: myBookList.length,
                itemBuilder: (context, index) {
                  final GlobalKey widgetKey = GlobalKey();
                  decodeBytes = base64Decode(myBookList[index].bookThumbnail!);
                  return GestureDetector(
                    onTap: () {
                      getCustomPointedPopup(
                              context, size, databaseHelper, index)
                          .show(
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
                          height: size * .01,
                        ),

                        /// book name
                        SizedBox(
                          width: size * .26,
                          child: Text(
                              myBookList[index].bookName.length < 18
                                  ? myBookList[index].bookName
                                  : "${myBookList[index].bookName.substring(0, 15)}...",
                              maxLines: 1,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: size * .032,
                                  fontWeight: FontWeight.w500)),
                        ),

                        /// writer name
                        SizedBox(
                          width: size * .26,
                          child: Text(
                              myBookList[index].writerName.length < 18
                                  ? myBookList[index].writerName
                                  : "${myBookList[index].writerName.substring(0, 15)}...",
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
            ),
            Positioned(
              bottom: 0,
              child: Container(
                width: size,
                color: Colors.black,
                padding: EdgeInsets.symmetric(vertical: size * .01),
                child: Text(
                  'ইন্টারনেট সংযোগ নেই!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: size * .035,
                      fontWeight: FontWeight.w500),
                ),
              ),
            )
          ],
        ),
      );

  CustomAppBar _pageAppBar() => CustomAppBar(
        title: "ডাউনলোডস",
        iconData: LineAwesomeIcons.arrow_left,
        action: const [],
        scaffoldKey: _scaffoldKey,
      );

  CustomPointedPopup getCustomPointedPopup(BuildContext context, double size,
      DatabaseHelper databaseHelper, int index) {
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
              SizedBox(
                width: size * .04,
              ),
              InkWell(
                onTap: () async {
                  print("deleting clicked!");
                  setState(() => _loading = true);
                  await databaseHelper.deleteDownloadedBooks(
                      myBookList[index].bookId, index);
                  setState(() => _loading = false);
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
          )

          ///Or you can add custom item widget below instead above 3
          ///itemWidget: Container(),
          ),
    );
  }

  Uint8List base64Decode(String source) => base64.decode(source);
}
