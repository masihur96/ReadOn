import 'package:flutter/material.dart';
import 'package:flutter_shimmer/flutter_shimmer.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:read_on/controller/ebook_api_controller.dart';
import 'package:read_on/controller/public_controller.dart';
import 'package:read_on/eBook/ebook_widgets/book_front_preview.dart';
import '../ebook_screens/writter_detail_page.dart';
import 'package:read_on/public_variables/color_variable.dart';
import 'package:read_on/public_variables/style_variable.dart';

class BoighorWriterTabPage extends StatefulWidget {
  const BoighorWriterTabPage({Key? key}) : super(key: key);

  @override
  _BoighorWriterTabPageState createState() => _BoighorWriterTabPageState();
}

class _BoighorWriterTabPageState extends State<BoighorWriterTabPage> {
  int _count = 0;
  int _tappedIndex = 0;
  int _writterListLength = 0;
  int _bookListLength = 0;
  bool _loading = false;

  Future <void> _customInit(EbookApiController ebookApiController) async {
    _count++;
    setState(() {
      _writterListLength = ebookApiController.writeModel.value.data!.length > 9 ? 10 : ebookApiController.writeModel.value.data!.length;
      _loading = true;
    });
    // ignore: avoid_print
    print('writer length = $_writterListLength');
    await ebookApiController.getWriterWiseBookList(ebookApiController.writeModel.value.data![0].writer![0].id!.toString());
    // ignore: avoid_print
    print('first writer name = ${ebookApiController.writeModel.value.data![0].writer![0].name}  book length = ${ebookApiController.writerWiseBookList.length}');
    setState(() {
      _bookListLength = ebookApiController.writerWiseBookList.length > 9 ? 9 : ebookApiController.writerWiseBookList.length;
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final PublicController publicController = Get.find();
    final EbookApiController ebookApiController = Get.find();
    double size = publicController.size.value;
    if(_count == 0) _customInit(ebookApiController);

    return Scaffold(
      body: _bodyUI(size, ebookApiController),
    );
  }

  Widget _bodyUI(double size, EbookApiController ebookApiController) => SizedBox(
        width: Get.width,

        child: Column(
          children: [
            Container(
              width: size,
              height: size * .3,
              color: const Color(0xffDEDFE1),
              padding: EdgeInsets.symmetric(horizontal: size * .04),
              child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  physics: const ClampingScrollPhysics(),
                  itemCount: _writterListLength,
                  itemBuilder: (context, index) {
                    return _writterListLength >9 ? index < _writterListLength-1
                        ? GestureDetector(
                            onTap: () async {
                              setState((){
                                _tappedIndex = index;
                                _loading = true;
                              });
                              await ebookApiController.getWriterWiseBookList(ebookApiController.writeModel.value.data![index].writer![0].id.toString());
                              setState(() {
                                _bookListLength = ebookApiController.writerWiseBookList.length > 9 ? 9 : ebookApiController.writerWiseBookList.length;
                                _loading = false;
                              });
                            },
                            child: Row(
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    /// writer image
                                    Container(
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                              color: _tappedIndex == index
                                                  ? CColor.themeColor
                                                  : Colors.white,
                                              width: size * .005)),
                                      child: CircleAvatar(
                                        backgroundColor: Colors.grey.shade200,
                                        backgroundImage: const NetworkImage(
                                          'https://m.media-amazon.com/images/M/MV5BNTM5YmQ5ZGYtMzRiMC00ZmVkLWIzMGItYjkwMTRkZWIyMTk1XkEyXkFqcGdeQXVyNDI3NjcxMDA@._V1_.jpg',
                                        ),
                                        radius: size * .065,
                                      ),
                                    ),
                                    SizedBox(height: size * .015),

                                    /// writer name
                                    Text(
                                      ebookApiController.writeModel.value.data![index].writer![0].name!,
                                      style: Style.bodyTextStyle(
                                          size * .035,
                                          _tappedIndex == index
                                              ? CColor.themeColor
                                              : Colors.black,
                                          FontWeight.w500),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  width: size * .06,
                                )
                              ],
                            ),
                          )
                        : Row(
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  /// writer image
                                  Container(
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                            color: _tappedIndex == index
                                                ? CColor.themeColor
                                                : Colors.white,
                                            width: size * .005)),
                                    child: CircleAvatar(
                                      child: const Icon(
                                        LineAwesomeIcons.angle_double_right,
                                        color: Colors.white,
                                      ),
                                      radius: size * .065,
                                      backgroundColor: CColor.themeColor,
                                    ),
                                  ),
                                  SizedBox(height: size * .015),

                                  /// writer name
                                  Text(
                                    'আরও দেখুন',
                                    style: Style.bodyTextStyle(
                                        size * .035,
                                        _tappedIndex == index
                                            ? CColor.themeColor
                                            : Colors.black,
                                        FontWeight.w500),
                                  )
                                ],
                              ),
                              SizedBox(
                                width: size * .06,
                              )
                            ],
                          ) :
                    GestureDetector(
                      onTap: () {
                        setState(() => _tappedIndex = index);
                        Get.to(() => WriterDetailPage(writerInfoData: ebookApiController.writeModel.value.data![index],));
                      },
                      child: Row(
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              /// writer image
                              Container(
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                        color: _tappedIndex == index
                                            ? CColor.themeColor
                                            : Colors.white,
                                        width: size * .005)),
                                child: CircleAvatar(
                                  backgroundColor: Colors.grey.shade200,
                                  backgroundImage: const NetworkImage(
                                    'https://m.media-amazon.com/images/M/MV5BNTM5YmQ5ZGYtMzRiMC00ZmVkLWIzMGItYjkwMTRkZWIyMTk1XkEyXkFqcGdeQXVyNDI3NjcxMDA@._V1_.jpg',
                                  ),
                                  radius: size * .065,
                                ),
                              ),
                              SizedBox(height: size * .015),

                              /// writer name
                              Text(
                                ebookApiController.writeModel.value.data![index].writer![0].name!,
                                style: Style.bodyTextStyle(
                                    size * .035,
                                    _tappedIndex == index
                                        ? CColor.themeColor
                                        : Colors.black,
                                    FontWeight.w500),
                              )
                            ],
                          ),
                          SizedBox(
                            width: size * .06,
                          )
                        ],
                      ),
                    );
                  }),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(size * .02),
                child: _loading? ListView.builder(
                  itemCount: 3,
                    itemBuilder: (context, index) => SizedBox(
                      height: size*.38,
                      child: const VideoShimmer(
                        isRectBox: true,
                        padding: EdgeInsets.zero,
                        margin: EdgeInsets.zero,
                      ),
                    ))
                    : ebookApiController.writerWiseBookList.isNotEmpty?
                GridView.builder(
                    physics: const ClampingScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            childAspectRatio: 3 / 5,
                            mainAxisSpacing: 2),
                    itemCount: _bookListLength,
                    itemBuilder: (context, index) {
                      return index != 8
                          ? BookPreview(
                          bookImageWidth: size * .26,
                          bookImageHeight: size * .4,
                          bookImage:
                          '${ebookApiController.domainName}/public//frontend/images/book_thumbnail/${ebookApiController.writerWiseBookList[index].bookThumbnail!}',
                          bookName: ebookApiController.writerWiseBookList[index].name!,
                          writerName: ebookApiController.writerWiseBookList[index].wname!,
                          product: ebookApiController
                              .writerWiseBookList[index]
                      )
                          : Padding(
                        padding: EdgeInsets.all(size * .02),
                        child: Container(
                          width: size * .2,
                          height: size * .3,
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: CColor.themeColor,
                                width: 2),
                            borderRadius:
                            BorderRadius.circular(4.0),
                          ),
                          child: Column(
                            mainAxisAlignment:
                            MainAxisAlignment.center,
                            children: [
                              const Icon(
                                LineAwesomeIcons
                                    .angle_double_right,
                                color: CColor.themeColor,
                              ),
                              SizedBox(
                                height: size * .02,
                              ),
                              Text(
                                'আরও দেখুন',
                                style: Style.bodyTextStyle(
                                    size * .035,
                                    CColor.themeColor,
                                    FontWeight.w500),
                              )
                            ],
                          ),
                        ),
                      );
                    }) : Padding(
                  padding: EdgeInsets.only(top: size*.5),
                  child: const Text('কোন বই খুঁজে পাওয়া যায় নি!'),
                ),
              ),
            ),
          ],
        ),
      );
}
