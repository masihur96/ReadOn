import 'package:flutter/material.dart';
import 'package:flutter_shimmer/flutter_shimmer.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:read_on/controller/ebook_api_controller.dart';
import 'package:read_on/controller/public_controller.dart';
import 'package:read_on/eBook/ebook_widgets/book_front_preview.dart';
import 'package:read_on/public_variables/color_variable.dart';
import 'package:read_on/public_variables/style_variable.dart';

class BoighorPublicationTabPage extends StatefulWidget {
  const BoighorPublicationTabPage({Key? key}) : super(key: key);

  @override
  _BoighorPublicationTabPageState createState() =>
      _BoighorPublicationTabPageState();
}

class _BoighorPublicationTabPageState extends State<BoighorPublicationTabPage> {
  int _count = 0;
  int _tappedIndex = 0;
  int _publicationsLength = 0;
  bool _loading = false;
  int _bookListLength = 0;

  Future <void> _customInit(EbookApiController ebookApiController) async {
    _count++;
    setState(() {
      _publicationsLength = ebookApiController.publicationList.length > 9 ? 10 : ebookApiController.publicationList.length;
      _loading = true;
    });
    await ebookApiController.getPublicationWiseBookList(ebookApiController.publicationList[0].id.toString()).then((value){
      setState(() {
        _loading = false;
        _bookListLength = ebookApiController.publicationWiseBookList.length > 9 ? 9 : ebookApiController.publicationWiseBookList.length;
      });
    });
    // ignore: avoid_print
    print('publication length = $_publicationsLength booklist length = $_bookListLength');
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
                color: const Color(0xffDEDFE1),
                height: size * .3,
                padding: EdgeInsets.symmetric(horizontal: size * .04),
                child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    physics: const ClampingScrollPhysics(),
                    itemCount: _publicationsLength,
                    itemBuilder: (context, index) => _publicationsLength>9? index != _publicationsLength-1
                        ? GestureDetector(
                            onTap: () {
                              setState(() => _tappedIndex = index);
                            },
                            child: Row(
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    /// publication image
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
                                        backgroundImage:  NetworkImage(
                                          'http://${ebookApiController.domainName}/public//frontend/images/publicationImage/${ebookApiController.publicationList[index].publicationImage}',
                                        ),
                                        radius: size * .065,
                                      ),
                                    ),
                                    SizedBox(height: size * .015),

                                    /// publication name
                                    Text(
                                      ebookApiController.publicationList[index].publicationName!,
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
                                  /// publication image
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
                          ): GestureDetector(
                      onTap: () {
                        setState(() => _tappedIndex = index);
                      },
                      child: Row(
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              /// publication image
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
                                  backgroundImage:  NetworkImage(
                                    '${ebookApiController.domainName}/public//frontend/images/publicationImage/${ebookApiController.publicationList[index].publicationImage}',
                                  ),
                                  radius: size * .065,
                                ),
                              ),
                              SizedBox(height: size * .015),

                              /// publication name
                              Text(
                                ebookApiController.publicationList[index].publicationName!,
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
                )
            ),
            _loading
                ? Expanded(
              child: ListView.builder(
                  itemCount: 3,
                  itemBuilder: (context, index) => SizedBox(
                    height: size * .38,
                    child: const VideoShimmer(
                      isRectBox: true,
                      padding: EdgeInsets.zero,
                      margin: EdgeInsets.zero,
                    ),
                  )),
            )
                : ebookApiController.publicationWiseBookList.isNotEmpty
                ? Expanded(
              child: Padding(
                padding: EdgeInsets.all(size * .02),
                child: GridView.builder(
                    physics: const ClampingScrollPhysics(),
                    gridDelegate:
                    const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        childAspectRatio: 3 / 5,
                        mainAxisSpacing: 1),
                    itemCount: _bookListLength,
                    itemBuilder: (context, index) {
                      return index != 8
                          ? BookPreview(
                          bookImageWidth: size * .26,
                          bookImageHeight: size * .4,
                          bookImage:
                          '${ebookApiController.domainName}/public//frontend/images/book_thumbnail/${ebookApiController.publicationWiseBookList[index].bookThumbnail!}',
                          bookName: ebookApiController
                              .publicationWiseBookList[index].name!,
                          writerName: ebookApiController
                              .publicationWiseBookList[index].wname!,
                        product: ebookApiController
                            .publicationWiseBookList[index],
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
                    }),
              ),
            )
                : Padding(
              padding: EdgeInsets.only(top: size * .5),
              child: const Text('কোন বই খুঁজে পাওয়া যায় নি!'),
            ),
          ],
        ),
      );
}
