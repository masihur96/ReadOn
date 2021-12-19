import 'package:flutter/material.dart';
import 'package:flutter_shimmer/flutter_shimmer.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:read_on/controller/ebook_api_controller.dart';
import 'package:read_on/controller/public_controller.dart';
import 'package:read_on/eBook/ebook_widgets/book_front_preview.dart';
import 'package:read_on/public_variables/color_variable.dart';
import 'package:read_on/public_variables/style_variable.dart';
import 'package:read_on/widgets/custom_loading.dart';

class BoighorSubjectTabPage extends StatefulWidget {
  @override
  _BoighorSubjectTabPageState createState() => _BoighorSubjectTabPageState();
}

class _BoighorSubjectTabPageState extends State<BoighorSubjectTabPage> {
  int _tappedIndex = 0;
  int? _categoryId;
  int _count = 0;
  bool _loading = false;
  int _bookListLength = 0;

  void _customInit(EbookApiController ebookApiController) async {
    _count++;
    setState(() => _loading = true);
    await ebookApiController
        .getCategoryWiseBooks(ebookApiController.subjectCategoryList[0].id!)
        .then((value) {
      setState(() {
        _loading = false;
        _bookListLength = ebookApiController.categoryWiseBookList.length > 9 ? 9 : ebookApiController.categoryWiseBookList.length;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final PublicController publicController = Get.find();
    final EbookApiController ebookApiController = Get.find();
    double size = publicController.size.value;
    if (_count == 0) _customInit(ebookApiController);

    return Scaffold(
      body: _bodyUI(size, ebookApiController),
    );
  }

  Widget _bodyUI(double size, EbookApiController ebookApiController) =>
      SizedBox(
        width: Get.width,
        child: Column(
          children: [
            Container(
                height: size * .15,
                alignment: Alignment.center,
                color: const Color(0xffDEDFE1),
                padding: EdgeInsets.symmetric(horizontal: size * .04),
                child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    physics: const ClampingScrollPhysics(),
                    itemCount: ebookApiController.subjectCategoryList.length,
                    itemBuilder: (context, index) => GestureDetector(
                        onTap: () async {
                          setState(() {
                            _tappedIndex = index;
                            _categoryId = ebookApiController.subjectCategoryList[index].id;
                            _loading = true;
                          });
                          await ebookApiController.getCategoryWiseBooks(ebookApiController.subjectCategoryList[index].id!);
                          setState(() => _bookListLength = ebookApiController.categoryWiseBookList.length > 9 ? 9 : ebookApiController.categoryWiseBookList.length);
                          await ebookApiController.getSubjectSubCategoryOfCategory(_categoryId!);
                          setState(() => _loading = false);
                          // ignore: avoid_print
                          print('sub category length = ${ebookApiController.subjectSubcategoryListOfCategory.length}\n');
                        },
                        child: Container(
                          padding: EdgeInsets.fromLTRB(
                              size * .04, size * .05, size * .04, size * .05),
                          child: Text(
                            ebookApiController
                                .subjectCategoryList[index].categoryName!,
                            style: TextStyle(
                                color: _tappedIndex == index
                                    ? CColor.themeColor
                                    : Colors.black,
                                fontSize: size * .04,
                                fontWeight: FontWeight.w500),
                          ),
                        )))),
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
                : ebookApiController.categoryWiseBookList.isNotEmpty
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
                                            '${ebookApiController.domainName}/public//frontend/images/book_thumbnail/${ebookApiController.categoryWiseBookList[index].bookThumbnail!}',
                                        bookName: ebookApiController
                                            .categoryWiseBookList[index].name!,
                                        writerName: ebookApiController
                                            .categoryWiseBookList[index].wname!,
                                        product: ebookApiController
                                            .categoryWiseBookList[index])
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
