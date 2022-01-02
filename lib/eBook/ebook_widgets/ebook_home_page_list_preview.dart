import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:read_on/controller/ebook_api_controller.dart';
import 'package:read_on/controller/public_controller.dart';
import 'package:read_on/eBook/ebook_model_classes/product.dart';
import 'package:read_on/eBook/ebook_widgets/book_front_preview.dart';
import '../ebook_screens/more_books_page.dart';
import 'package:read_on/public_variables/style_variable.dart';

class EbookHomePageListPreview extends StatelessWidget {
  String title;
  List<Product> bookList;
  EbookHomePageListPreview({Key? key, required this.title, required this.bookList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final PublicController publicController = Get.find();
    final EbookApiController ebookApiController = Get.find();

    double size = publicController.size.value;
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: size * .03),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Text(
                  title,
                  style: Style.headerTextStyle(
                      size * .05, Colors.black, FontWeight.normal),
                ),
              ),
              GestureDetector(
                onTap: (){
                  String categoryId = bookList[0].categoryId!;
                  Get.to(() => MoreBooksPage(title: title, categoryId: int.parse(categoryId)));
                },
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(size * .4),
                      border: Border.all(color: Colors.red, width: size * .005)),
                  padding: EdgeInsets.symmetric(vertical: size * .004, horizontal: size * .03),
                  child: Text(
                    'আরও',
                    style: Style.headerTextStyle(
                        size * .035, Colors.black, FontWeight.normal),
                  ),
                ),
              )
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: size * .03),
          height: size * .6,
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              physics: const ClampingScrollPhysics(),
              itemCount: bookList.length > 10? 10 : bookList.length,
              itemBuilder: (context, index) => Padding(
                padding: EdgeInsets.only(right: size * .03),
                child: BookPreview(
                    bookImageWidth: size * .26,
                    bookImageHeight: size * .36,
                    bookImage: "${ebookApiController.domainName}/public//frontend/images/book_thumbnail/${bookList[index].bookThumbnail!}",
                    bookName: bookList[index].name!,
                    writerName: bookList[index].wname!,
                    product: bookList[index],
                ),
              )),
        ),
      ],
    );
  }
}
