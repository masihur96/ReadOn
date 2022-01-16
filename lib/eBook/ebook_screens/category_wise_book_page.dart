import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:read_on/controller/ebook_api_controller.dart';
import 'package:read_on/controller/public_controller.dart';
import 'package:read_on/eBook/ebook_widgets/book_front_preview.dart';
import '../../widgets/custom_appbar.dart';
import 'package:read_on/public_variables/color_variable.dart';
import 'package:read_on/widgets/custom_loading.dart';

class CategoryWiseBookPage extends StatefulWidget {
  String categoryName;
  String categoryId;
  CategoryWiseBookPage({Key? key, required this.categoryName, required this.categoryId}) : super(key: key);

  @override
  _CategoryWiseBookPageState createState() => _CategoryWiseBookPageState();
}

class _CategoryWiseBookPageState extends State<CategoryWiseBookPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  int _count = 0;
  bool _loading = false;
  int _tappedIndex = 0;
  int _subCategoryId = 0;

  void _customInit(EbookApiController ebookApiController) async {
    _count++;
    setState(() => _loading = true);
    await ebookApiController.getSubjectSubCategoryOfCategory(int.parse(widget.categoryId));
    print('subcategory length = ${ebookApiController.subjectSubcategoryListOfCategory.length}');
    await ebookApiController.getCategoryWiseBooks(int.parse(widget.categoryId));
    setState(() => _loading = false);
  }

  @override
  Widget build(BuildContext context) {
    final PublicController publicController = Get.find();
    final EbookApiController ebookApiController = Get.put(EbookApiController());
    double size = publicController.size.value;
    if(_count == 0) _customInit(ebookApiController);
    return Obx(() => SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: PreferredSize(
            preferredSize: AppBar().preferredSize,
            child: _pageAppBar(size, publicController)),
        body: Column(
          children: [
            ebookApiController.subjectSubcategoryListOfCategory.length >= 2 ? Container(
                height: size * .15,
                alignment: Alignment.center,
                color: const Color(0xffDEDFE1),
                padding: EdgeInsets.symmetric(horizontal: size * .04),
                child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    physics: const ClampingScrollPhysics(),
                    itemCount: ebookApiController.subjectSubcategoryListOfCategory.length,
                    itemBuilder: (context, index) => GestureDetector(
                        onTap: () async {
                          setState(() {
                            _tappedIndex = index;
                            _subCategoryId = ebookApiController.subjectSubcategoryListOfCategory[index].id!;
                            _loading = true;
                          });
                          await ebookApiController.getSubCategoryWiseBooks(_subCategoryId);
                          setState(() => _loading = false);
                          // ignore: avoid_print
                          print('sub category length = ${ebookApiController.subjectSubcategoryListOfCategory.length}\n');
                        },
                        child: Container(
                          padding: EdgeInsets.fromLTRB(
                              size * .04, size * .05, size * .04, size * .05),
                          child: Text(
                            ebookApiController
                                .subjectSubcategoryListOfCategory[index].subCategoryName!,
                            style: TextStyle(
                                color: _tappedIndex == index
                                    ? CColor.themeColor
                                    : Colors.black,
                                fontSize: size * .04,
                                fontWeight: FontWeight.w500),
                          ),
                        )))): const SizedBox(),
            Expanded(
              child: _loading? const Center(child: CustomLoading()) :  ebookApiController.categoryWiseBookList.isNotEmpty ? GridView.builder(
                physics: const ClampingScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    childAspectRatio: 3 / 5,
                    mainAxisSpacing: 2),
                itemCount: ebookApiController.subCategoryWiseBookList.length,
                itemBuilder: (context, index) => BookPreview(
                  bookImageWidth: size * .26,
                  bookImageHeight: size * .4,
                  bookImage:
                  "${ebookApiController.domainName}/public//frontend/images/book_thumbnail/${ebookApiController.subCategoryWiseBookList[index].bookThumbnail!}",
                  bookName: ebookApiController.subCategoryWiseBookList[index].name!,
                  writerName: ebookApiController.subCategoryWiseBookList[index].wname!,
                  product: ebookApiController.subCategoryWiseBookList[index],
                ),
              ) : const Center(child: Text('কোন বই খুঁজে পাওয়া যায় নি!')),
            ),
          ],
        ),
      ),
    ));
  }

  /// app bar
  CustomAppBar _pageAppBar(double size, PublicController publicController) => CustomAppBar(
    title: widget.categoryName,
    iconData: LineAwesomeIcons.arrow_left,
    action: [
      Icon(
        Icons.search_outlined,
        color: Colors.white,
        size: publicController.size.value * .08,
      ),
    ],
    scaffoldKey: _scaffoldKey,
  );
}
