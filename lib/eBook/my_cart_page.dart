import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:read_on/controller/public_controller.dart';
import 'package:read_on/public_variables/color_variable.dart';
import 'package:read_on/public_variables/style_variable.dart';
import 'ebook_widgets/cart_card.dart';
import 'ebook_widgets/custom_appbar.dart';
import 'package:read_on/widgets/solid_button.dart';

class MyCartPage extends StatefulWidget {
  @override
  _MyCartPageState createState() => _MyCartPageState();
}

class _MyCartPageState extends State<MyCartPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final PublicController publicController = Get.find();
    double size = publicController.size.value;
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
            preferredSize: AppBar().preferredSize,
            child: _pageAppBar(publicController)),
        body: _bodyUI(size),
      ),
    );
  }

  /// page body
  Container _bodyUI(double size) => Container(
        width: Get.width,
        height: Get.height,
        decoration: const BoxDecoration(color: Colors.white),
        child: Stack(
          children: [
            SizedBox(
              height: size*1.05,
              child: ListView(
                children: [
                  SizedBox(
                    height: size * .04,
                  ),

                  /// my cart list
                  ListView.builder(
                      itemCount: 2,
                      shrinkWrap: true,
                      physics: const ClampingScrollPhysics(),
                      itemBuilder: (context, index) => CartCard(
                          bookImage:
                              "https://1.bp.blogspot.com/-QoKjWWKcnC0/XWVnOba6kbI/AAAAAAAAXn4/fwXfr6wBflcYMrUlRSFxfB9K62_5SONAgCLcBGAs/s1600/Ekjon%2BMayaboti%2Bby%2BHumayun%2BAhmed%2B-%2BBangla%2BRomantic%2BNovel%2BPDF%2BBooks.jpg",
                          bookName: 'একজন মায়াবতী',
                          writerName: 'হুমায়ুন আহমেদ',
                          amount: '১২০ টাকা',
                          bookCopyType: 'ইবুক')),
                ],
              ),
            ),
            Positioned(
              bottom: size * .15,
              child: Stack(
                clipBehavior: Clip.none,
                alignment: Alignment.center,
                children: [
                  Column(
                    children: [
                      Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(size * .02),
                            side: const BorderSide(color: Colors.red)),
                        child: SizedBox(
                          width: size * .98,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Expanded(
                                  child: TextFormField(
                                textAlign: TextAlign.center,
                                style: Style.bodyTextStyle(size * .045, Colors.black, FontWeight.w400),
                                cursorColor: Colors.black,
                                autofocus: false,
                                decoration: InputDecoration(
                                  enabledBorder: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                  border: InputBorder.none,
                                  disabledBorder: InputBorder.none,
                                  hintText: 'প্রমো কোড',
                                  hintStyle: Style.bodyTextStyle(size * .045, Colors.grey.shade600, FontWeight.w400),
                                ),
                              )),
                              Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: size * .06, vertical: size * .03),
                                decoration: BoxDecoration(
                                    color: CColor.themeColor,
                                    border: Border.all(
                                      color: CColor.themeColor,
                                    ),
                                    borderRadius:
                                        BorderRadius.circular(size * .02)),
                                child: Text(
                                  'প্রয়োগ',
                                  style: Style.bodyTextStyle(
                                      size * .045, Colors.white, FontWeight.w400),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      Card(
                        color: Colors.pink.shade50,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(size*.08),
                                topRight: Radius.circular(size*.08),
                              bottomRight: Radius.circular(size*.06),
                              bottomLeft: Radius.circular(size*.05)
                            ),
                            side: const BorderSide(color: Colors.red)),
                        child: Container(
                          width: size*.98,
                           padding: EdgeInsets.symmetric(vertical: size*.04),
                          child: Column(
                            children: [

                              /// cart cost details
                              _costDetailPreview(size, 'মোট :', '২০০'),
                              _costDetailPreview(size, 'চার্জ :', '০০'),
                              _costDetailPreview(size, 'ওয়ালেট :', '-০০'),
                              Divider(
                                thickness: size*.003,
                                color: Colors.red,
                              ),
                              _costDetailPreview(size, 'সর্বমোট :', '২০০'),
                            ],
                          ),
                        ),

                      ),
                    ],
                  ),
                  Positioned(
                    bottom: -size*.08,
                    child: SolidColorButton(
                        contentPadding: EdgeInsets.symmetric(
                            vertical: size * .03,
                            horizontal: size * .16),
                        borderRadius: size * .025,
                        child: Text('কিনুন',
                            style: Style.buttonTextStyle(size*.05, Colors.white, FontWeight.w500)),
                        onPressed: () {
                        },
                        bgColor: CColor.themeColor),
                  ),
                ],
              ),
            )
          ],
        ),
      );

  /// app bar
  CustomAppBar _pageAppBar(PublicController publicController) => CustomAppBar(
        title: "আমার কার্ট",
        iconData: LineAwesomeIcons.bars,
        action: [
          Icon(
            Icons.search_outlined,
            color: Colors.white,
            size: publicController.size.value * .08,
          ),
        ],
    scaffoldKey: _scaffoldKey,
      );

  Widget _costDetailPreview(double size, String title, String value) => Padding(
    padding:  EdgeInsets.symmetric(vertical: size*.01),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Container(
            padding: EdgeInsets.only(left: size*.2),
            child: Text(
              title,
              style: Style.bodyTextStyle(size * .04, Colors.black, FontWeight.w500),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.only(left: size*.1),
            child: Row(
              children: [
                Text(
                  value,
                  style: Style.bodyTextStyle(size * .04, Colors.black, FontWeight.w500),
                ),
                SizedBox(width: size*.04,),
                Text(
                  'টাকা',
                  style: Style.bodyTextStyle(size * .04, Colors.black, FontWeight.w500),
                ),
              ],
            ),
          ),
        )
      ],
    ),
  );
}
