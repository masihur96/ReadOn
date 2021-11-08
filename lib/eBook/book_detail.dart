import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:read_on/controller/public_controller.dart';
import 'package:read_on/eBook/ebook_widgets/custom_appbar.dart';
import 'package:read_on/eBook/my_cart_page.dart';
import 'package:read_on/public_variables/color_variable.dart';
import 'package:read_on/public_variables/style_variable.dart';

class BookDetail extends StatefulWidget {
  const BookDetail({Key? key}) : super(key: key);

  @override
  _BookDetailState createState() => _BookDetailState();
}

class _BookDetailState extends State<BookDetail> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final PublicController publicController = Get.find();
    double size = publicController.size.value;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
          preferredSize: AppBar().preferredSize,
          child: _pageAppBar(size, publicController)),
      body: _bodyUI(size),
    );
  }

  Widget _bodyUI(double size) => Stack(
    clipBehavior: Clip.none,
    children: [
      Positioned(
        top: -size*.45,
        left: -size*.2,
        child: Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.grey.shade500,
          ),
        ),
      ),
      Positioned(
        top: size*.2,
        left: size*.1,
        child: Container(
          width: size * .4,
          height: size * .6,
          decoration: BoxDecoration(
            borderRadius:
            BorderRadius.circular(size * .05),
          ),
          child: ClipRRect(
              borderRadius:
              BorderRadius.circular(size * .05),
              child: Image.network('https://1.bp.blogspot.com/-QoKjWWKcnC0/XWVnOba6kbI/AAAAAAAAXn4/fwXfr6wBflcYMrUlRSFxfB9K62_5SONAgCLcBGAs/s1600/Ekjon%2BMayaboti%2Bby%2BHumayun%2BAhmed%2B-%2BBangla%2BRomantic%2BNovel%2BPDF%2BBooks.jpg')),
        ),
      ),
      Positioned(
          top: size*.5,
          right: size*.1,
          child: _bookPriceContainer(size)
      )

    ],
  );

  /// app bar
  CustomAppBar _pageAppBar(double size, PublicController publicController) => CustomAppBar(
    title: "",
    iconData: LineAwesomeIcons.bars,
    action: [
      Icon(
        Icons.search_outlined,
        color: Colors.white,
        size: publicController.size.value * .08,
      ),
      GestureDetector(
        onTap: () {
          Get.to(() => MyCartPage());
        },
        child: Container(
          width: size * .085,
          height: size * .02,
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
      SizedBox(width: size * .04)
    ],
    scaffoldKey: _scaffoldKey,
  );

  /// book amount show widget
  Container _bookPriceContainer(double size) => Container(
    padding: EdgeInsets.symmetric(horizontal: size*.01, vertical: size*.02),
    decoration: BoxDecoration(
      color: CColor.themeColor,
      borderRadius: BorderRadius.circular(size*.04)
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
         Icon(Icons.add_to_home_screen, color: Colors.white, size: size*.05,),
        SizedBox(width: size*.04,),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('ট ৫০ ', style: Style.bodyTextStyle(size*.045, Colors.white, FontWeight.w500)),
            Text('(\$1.00)', style: Style.bodyTextStyle(size*.04, Colors.white, FontWeight.w500)),
          ],
        )
      ],
    ),
  );
}
