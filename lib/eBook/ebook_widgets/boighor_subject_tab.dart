import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:read_on/controller/ebook_api_controller.dart';
import 'package:read_on/controller/public_controller.dart';
import 'package:read_on/eBook/ebook_widgets/book_front_preview.dart';
import 'package:read_on/public_variables/color_variable.dart';
import 'package:read_on/public_variables/style_variable.dart';

class BoighorSubjectTabPage extends StatefulWidget {
  @override
  _BoighorSubjectTabPageState createState() => _BoighorSubjectTabPageState();
}

class _BoighorSubjectTabPageState extends State<BoighorSubjectTabPage> {
  int _tappedIndex = 0;
  int? _categoryId;

  @override
  Widget build(BuildContext context) {
    final PublicController publicController = Get.find();
    final EbookApiController ebookApiController = Get.find();
    double size = publicController.size.value;

    return Scaffold(
      body: _bodyUI(size, ebookApiController),
    );
  }

  Widget _bodyUI(double size, EbookApiController ebookApiController) => SizedBox(
        width: Get.width,
        child: Column(
          children: [
            Container(
                height: size * .15,
                alignment: Alignment.center,
                color: const Color(0xffDEDFE1),
                padding:  EdgeInsets.symmetric(horizontal: size*.04),
                child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    physics: const ClampingScrollPhysics(),
                    // ignore: invalid_use_of_protected_member
                    itemCount: ebookApiController.subjectCategoryList.value.length,
                    itemBuilder: (context, index) => GestureDetector(
                        onTap: () async {
                          setState(() {
                            _tappedIndex = index;
                            // ignore: invalid_use_of_protected_member
                            _categoryId = ebookApiController.subjectCategoryList.value[index].id;
                          });
                          await ebookApiController.getSubjectSubCategoryOfCategory(_categoryId!);
                          // ignore: avoid_print, invalid_use_of_protected_member
                          print('sub category length = ${ebookApiController.subjectSubcategoryListOfCategory.value.length}\n');
                        },
                        child: Container(
                          padding:  EdgeInsets.fromLTRB(size*.04, size*.05, size*.04, size*.05),
                          child: Text(
                            ebookApiController.subjectCategoryList[index].categoryName!,
                            style: TextStyle(
                                color: _tappedIndex == index? CColor.themeColor : Colors.black, fontSize: size * .04, fontWeight: FontWeight.w500),
                          ),
                        )))),
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(size * .02),
                child: GridView.builder(
                    physics: const ClampingScrollPhysics(),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3, childAspectRatio: 3 / 5, mainAxisSpacing: 1),
                    itemCount: 9,
                    itemBuilder: (context, index) {
                      return index != 8? BookPreview(
                          bookImageWidth: size * .26,
                          bookImageHeight: size * .4,
                          bookImage:
                          "https://1.bp.blogspot.com/-QoKjWWKcnC0/XWVnOba6kbI/AAAAAAAAXn4/fwXfr6wBflcYMrUlRSFxfB9K62_5SONAgCLcBGAs/s1600/Ekjon%2BMayaboti%2Bby%2BHumayun%2BAhmed%2B-%2BBangla%2BRomantic%2BNovel%2BPDF%2BBooks.jpg",
                          bookName: 'একজন মায়াবতী ',
                          writerName: 'হুমায়ুন আহমেদ') : Padding(
                        padding: EdgeInsets.all(size*.02),
                        child: Container(
                          width: size * .2,
                          height: size * .3,
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: CColor.themeColor, width: 2),
                            borderRadius: BorderRadius.circular(4.0),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                LineAwesomeIcons.angle_double_right,
                                color: CColor.themeColor,
                              ),
                              SizedBox(height: size*.02,),
                              Text(
                                'আরও দেখুন',
                                style: Style.bodyTextStyle(size * .035,
                                    CColor.themeColor, FontWeight.w500),
                              )
                            ],
                          ),
                        ),
                      );
                    }),
              ),
            ),
          ],
        ),
      );
}
