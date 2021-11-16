import 'package:carousel_pro_nullsafety/carousel_pro_nullsafety.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:read_on/controller/public_controller.dart';
import 'package:read_on/eBook/ebook_widgets/book_front_preview.dart';
import 'package:read_on/public_variables/color_variable.dart';
import 'package:read_on/public_variables/style_variable.dart';

class HomePageEbook extends StatefulWidget {
  const HomePageEbook({Key? key}) : super(key: key);

  @override
  State<HomePageEbook> createState() => _HomePageEbookState();
}

class _HomePageEbookState extends State<HomePageEbook> {
  @override
  Widget build(BuildContext context) {
    final PublicController publicController = Get.find();
    double size = publicController.size.value;
    return SingleChildScrollView(
      child: Container(
        decoration: const BoxDecoration(
            color: Colors.white,
            image: DecorationImage(
                image: AssetImage('assets/dot_bg.png'), fit: BoxFit.cover)),
        child: Column(
          children: [
            SizedBox(height: size * .05),
            Container(
                width: size,
                height: size * .6,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(size * .06)),
                child: Carousel(
                  dotSize: size*.016,
                  dotSpacing: size*.05,
                  dotColor: Colors.black,
                  indicatorBgPadding: size*.02,
                  dotBgColor: Colors.white24,
                  borderRadius: true,
                  images: [
                    ClipRRect(
                      child: Image.network(
                        'https://www.newagebd.com/files/records/news/202009/115828_140.jpg',
                        fit: BoxFit.cover,
                      ),
                      borderRadius: BorderRadius.circular(size * .06),
                    ),
                    ClipRRect(
                        child: Image.network(
                            'https://bangladeshbusinessdir.com/wp-content/uploads/2015/06/Boi-Mela2.jpg',
                            fit: BoxFit.cover),
                        borderRadius: BorderRadius.circular(size * .06)),
                    ClipRRect(
                        child: Image.network(
                            'https://2.bp.blogspot.com/-CRSDzOvxXBU/Wn3gvRdDbMI/AAAAAAAASds/-VHI6eYdQco4Cs9ck9NvFXedUOLmzwwEACLcBGAs/s1600/boi%2Bmela.jpg',
                            fit: BoxFit.cover),
                        borderRadius: BorderRadius.circular(size * .06)),
                  ],
                )),
            SizedBox(height: size * .04),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: size * .04),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Text(
                      'ফ্রি বই',
                      style: Style.bodyTextStyle(
                          size * .05, Colors.black, FontWeight.w700),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(size * .4),
                        border:
                            Border.all(color: Colors.red, width: size * .005)),
                    padding: EdgeInsets.symmetric(
                        vertical: size * .004, horizontal: size * .045),
                    child: Text(
                      'আরও',
                      style: Style.bodyTextStyle(
                          size * .035, Colors.black, FontWeight.w500),
                    ),
                  )
                ],
              ),
            ),
            //SizedBox(height: size * .04),
            Container(
              height: size * .6,
              padding: EdgeInsets.symmetric(horizontal: size * .04),
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  physics: const ClampingScrollPhysics(),
                  itemCount: 10,
                  itemBuilder: (context, index) => Padding(
                        padding: EdgeInsets.only(right: size * .06),
                        child: BookPreview(
                            bookImageWidth: size * .26,
                            bookImageHeight: size * .4,
                            bookImage:
                                "https://1.bp.blogspot.com/-QoKjWWKcnC0/XWVnOba6kbI/AAAAAAAAXn4/fwXfr6wBflcYMrUlRSFxfB9K62_5SONAgCLcBGAs/s1600/Ekjon%2BMayaboti%2Bby%2BHumayun%2BAhmed%2B-%2BBangla%2BRomantic%2BNovel%2BPDF%2BBooks.jpg",
                            bookName: 'একজন মায়াবতী',
                            writerName: 'হুমায়ুন আহমেদ'),
                      )),
            ),
            SizedBox(height: size * .04),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: size * .04),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Text(
                      'বেস্ট সেলার',
                      style: Style.bodyTextStyle(
                          size * .05, Colors.black, FontWeight.w700),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(size * .4),
                        border:
                            Border.all(color: Colors.red, width: size * .005)),
                    padding: EdgeInsets.symmetric(
                        vertical: size * .004, horizontal: size * .045),
                    child: Text(
                      'আরও',
                      style: Style.bodyTextStyle(
                          size * .035, Colors.black, FontWeight.w500),
                    ),
                  )
                ],
              ),
            ),
            Container(
              height: size * .6,
              padding: EdgeInsets.symmetric(horizontal: size * .04),
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  physics: const ClampingScrollPhysics(),
                  itemCount: 10,
                  itemBuilder: (context, index) => Padding(
                        padding: EdgeInsets.only(right: size * .06),
                        child: BookPreview(
                            bookImageWidth: size * .26,
                            bookImageHeight: size * .4,
                            bookImage:
                                "https://1.bp.blogspot.com/-QoKjWWKcnC0/XWVnOba6kbI/AAAAAAAAXn4/fwXfr6wBflcYMrUlRSFxfB9K62_5SONAgCLcBGAs/s1600/Ekjon%2BMayaboti%2Bby%2BHumayun%2BAhmed%2B-%2BBangla%2BRomantic%2BNovel%2BPDF%2BBooks.jpg",
                            bookName: 'একজন মায়াবতী',
                            writerName: 'হুমায়ুন আহমেদ'),
                      )),
            )
          ],
        ),
      ),
    );
  }
}
