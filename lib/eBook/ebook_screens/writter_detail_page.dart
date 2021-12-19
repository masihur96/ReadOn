import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:read_on/controller/ebook_api_controller.dart';
import 'package:read_on/controller/public_controller.dart';
import 'package:read_on/eBook/ebook_model_classes/writter_model.dart';
import 'package:read_on/eBook/ebook_widgets/book_front_preview.dart';
import 'package:read_on/eBook/ebook_widgets/custom_appbar.dart';
import 'package:read_on/eBook/ebook_widgets/custom_drawer.dart';
import 'my_cart_page.dart';
import 'package:read_on/public_variables/color_variable.dart';
import 'package:read_on/public_variables/language_convert.dart';
import 'package:read_on/public_variables/style_variable.dart';

class WriterDetailPage extends StatefulWidget {
  WriterInfoData writerInfoData;
  WriterDetailPage({Key? key, required this.writerInfoData}) : super(key: key);

  @override
  _WriterDetailPageState createState() => _WriterDetailPageState();
}

class _WriterDetailPageState extends State<WriterDetailPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  int _count = 0;
  bool _loading = false;

  void _customInit(EbookApiController ebookApiController) async {
    _count++;
    setState(() => _loading = true);
    await ebookApiController.getWriterWiseBookList(widget.writerInfoData.writer![0].id!.toString());
    setState(() => _loading = false);
  }

  @override
  Widget build(BuildContext context) {
    final PublicController publicController = Get.find();
    final EbookApiController ebookApiController = Get.find();
    double size = publicController.size.value;
    if(_count == 0) _customInit(ebookApiController);
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: PreferredSize(
            preferredSize: AppBar().preferredSize,
            child: _pageAppBar(size, publicController)),
        body: Scaffold(
          key: _scaffoldKey,
          drawer: Drawer(child: CustomDrawer()),
          body: _bodyUI(size, ebookApiController),
        ),
      ),
    );
  }

  Widget _bodyUI(double size, EbookApiController ebookApiController) => SingleChildScrollView(
    child: Column(
          children: [
            SizedBox(
              width: size,
              height: size * .62,
              child: Stack(
                children: [
                  Positioned(
                    top: -size * .47,
                    left: -size * .2,
                    child: Container(
                      width: size,
                      height: size,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(0xff86878B),
                      ),
                    ),
                  ),

                  /// writer's image
                  Positioned(
                    bottom: size * .04,
                    left: size * .33,
                    child: Container(
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                              color: CColor.greenColor, width: size * .006)),
                      child: CircleAvatar(
                        backgroundImage: const NetworkImage(
                          'https://m.media-amazon.com/images/M/MV5BNTM5YmQ5ZGYtMzRiMC00ZmVkLWIzMGItYjkwMTRkZWIyMTk1XkEyXkFqcGdeQXVyNDI3NjcxMDA@._V1_.jpg',
                        ),
                        radius: size * .16,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            /// writer's name
            Padding(
              padding:  EdgeInsets.symmetric(horizontal: size*.04),
              child: Text(
                widget.writerInfoData.writer![0].name!,
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: size * .06,
                    fontWeight: FontWeight.w600),
              ),
            ),
            SizedBox(
              height: size * .04,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'জন্ম : ',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: size * .04,
                      fontWeight: FontWeight.w500),
                ),

                /// birth date
                Text(
                  '১৩ নভেম্বর ১৯৪৮',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: size * .04,
                      fontWeight: FontWeight.w500),
                ),
              ],
            ),
            widget.writerInfoData.writer![0].award != null? Padding(
              padding: EdgeInsets.symmetric(horizontal: size*.04),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'পুরস্কার : ',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: size * .04,
                        fontWeight: FontWeight.w500),
                  ),

                  /// award of writer
                  Text(
                    widget.writerInfoData.writer![0].award!,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: size * .04,
                        fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ) : const SizedBox(),
            SizedBox(
              height: size * .04,
            ),

            /// button
            Container(
              width: size * .32,
              padding: EdgeInsets.symmetric(
                  vertical: size * .01, horizontal: size * .04),
              decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [CColor.themeColor, CColor.themeColorLite],
                  ),
                  borderRadius: BorderRadius.circular(size * .02)),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.person,
                    color: Colors.white,
                    size: size * .06,
                  ),
                  SizedBox(
                    width: size * .02,
                  ),
                  Text(
                    'অনুসরণ',
                    style: Style.buttonTextStyle(
                        size * .04, Colors.white, FontWeight.w500),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: size * .025,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: size * .35,
                  padding: EdgeInsets.symmetric(
                    vertical: size * .03,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xffF1F3F2),
                    border: Border.all(color: const Color(0xffB8B8B8)),
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(size * .03),
                        bottomLeft: Radius.circular(size * .03)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'মোট বই : ',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: size * .04,
                            fontWeight: FontWeight.w600),
                      ),

                      /// number of books
                      Text(
                        enToBnNumberConvert(widget.writerInfoData.totalBooks.toString()),
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: size * .04,
                            fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: size * .015,
                ),
                Container(
                  width: size * .35,
                  padding: EdgeInsets.symmetric(
                    vertical: size * .03,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xffF1F3F2),
                    border: Border.all(color: const Color(0xffB8B8B8)),
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(size * .03),
                        bottomLeft: Radius.circular(size * .03)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'অনুসারী : ',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: size * .04,
                            fontWeight: FontWeight.w600),
                      ),

                      /// number of followers
                      Text(
                        enToBnNumberConvert(widget.writerInfoData.writer![0].followerCount!),
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: size * .04,
                            fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: size * .05,
            ),

            /// about writer
            widget.writerInfoData.writer![0].writerDescription != null? Container(
              width: size,
              padding: EdgeInsets.symmetric(horizontal: size*.04),
              child: ExpandableText(
                widget.writerInfoData.writer![0].writerDescription!,
                textAlign: TextAlign.justify,
                expandText: 'আরও পড়ুন',
                collapseText: 'অল্প পড়ুন',
                maxLines: 4,
                linkColor: CColor.greenColor,
                style: Style.bodyTextStyle(
                    size * .04, Colors.black, FontWeight.w500),
              ),
            ) : const SizedBox(),
            SizedBox(
              height: size * .06,
            ),
            Container(
              width: size,
              padding: EdgeInsets.symmetric(horizontal: size * .04),
              child: Text(
                'লেখকের বই',
                style: Style.bodyTextStyle(
                    size * .05, const Color(0xff6E6E6E), FontWeight.w700),
              ),
            ),

            /// writer's books
            _loading? CupertinoActivityIndicator() :
            Container(
              height: size*.6,
              padding: EdgeInsets.symmetric(horizontal: size*.04),
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  physics: const ClampingScrollPhysics(),
                  itemCount: ebookApiController.writerWiseBookList.length,
                  itemBuilder: (context, index) => Padding(
                    padding: EdgeInsets.only(right: size*.06),
                    child: BookPreview(
                        bookImageWidth: size*.26,
                        bookImageHeight: size*.4,
                        bookImage: "${ebookApiController.domainName}/public//frontend/images/book_thumbnail/${ebookApiController.writerWiseBookList[index].bookThumbnail!}",
                        bookName: ebookApiController.writerWiseBookList[index].name!,
                        writerName: ebookApiController.writerWiseBookList[index].wname!,
                      product: ebookApiController.writerWiseBookList[index],
                    ),
                  )),
            )
          ],
        ),
  );

  CustomAppBar _pageAppBar(double size, PublicController publicController) =>
      CustomAppBar(
        title: "",
        iconData: LineAwesomeIcons.bars,
        action: [
          Icon(
            Icons.search_outlined,
            color: Colors.white,
            size: publicController.size.value * .08,
          ),
          SizedBox(width: size * .04),
          GestureDetector(
            onTap: () {
              Get.to(() => MyCartPage());
            },
            child: Container(
              width: size * .085,
              height: size * .085,
              alignment: Alignment.center,
              child: Stack(
                children: [
                  Icon(
                    LineAwesomeIcons.shopping_cart,
                    color: Colors.white,
                    size: size * .085,
                  ),
                  Positioned(
                    top: 0,
                    right: 0,
                    child: Container(
                      width: size * .035,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                      ),

                      /// notification count
                      child: Center(
                        child: Text(
                          '2',
                          style: TextStyle(
                              color: Colors.red,
                              fontSize: size * .03,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
        scaffoldKey: _scaffoldKey,
      );
}
