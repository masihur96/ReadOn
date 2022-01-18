import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:read_on/controller/public_controller.dart';
import 'package:read_on/public_variables/color_variable.dart';
import 'package:read_on/public_variables/style_variable.dart';
import 'package:read_on/widgets/custom_appbar.dart';

class ExamFinishingPage extends StatefulWidget {
  const ExamFinishingPage({Key? key}) : super(key: key);

  @override
  _ExamFinishingPageState createState() => _ExamFinishingPageState();
}

class _ExamFinishingPageState extends State<ExamFinishingPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final PublicController publicController = Get.find();
    final double size = publicController.size.value;
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: Colors.white,
        appBar: PreferredSize(
            preferredSize: AppBar().preferredSize,
            child: _pageAppBar(size, publicController)),
        body: _bodyUI(size),
      ),
    );
  }

  Widget _bodyUI(double size) => Container(
        width: size,
        height: Get.height,
        padding:
            EdgeInsets.symmetric(horizontal: size * .1, vertical: size * .08),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
                width: size * .3,
                height: size * .3,
                child: Image.asset("assets/read_on_icon.png", fit: BoxFit.contain,)),
            SizedBox(height: size*.02,),
            Text(
              'ধন্যবাদ। আপনি সফলভাবে পরীক্ষাটি শেষ করেছেন।',
              textAlign: TextAlign.center,
              style: Style.bodyTextStyle(
                  size * .05, Colors.black, FontWeight.w500),
            ),
            SizedBox(height: size*.1,),
            Container(
              width: double.infinity,
              color: const Color(0xff049804),
              padding: EdgeInsets.symmetric(vertical: size*.03, horizontal: size*.04),
              child: Text(
                'ফলাফল প্রকাশ',
                textAlign: TextAlign.center,
                style: Style.bodyTextStyle(size*.05, Colors.white, FontWeight.w600),
              ),
            ),
            SizedBox(height: size*.03,),
            Text(
              '১১ নভেম্বর (সকাল ১০টা)',
              textAlign: TextAlign.center,
              style: Style.bodyTextStyle(size*.04, Colors.black, FontWeight.w500),
            ),
            SizedBox(height: size*.1,),
            Row(
              children: [
                Expanded(
                  child: Container(
                    color: const Color(0xff20A3F3),
                    child: Stack(
                      clipBehavior: Clip.none,
                      alignment: Alignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: size*.03, horizontal: size*.04),
                          child: Text(
                            'পরবর্তী পরীক্ষা',
                            textAlign: TextAlign.center,
                            style: Style.bodyTextStyle(size*.045, Colors.white, FontWeight.w600),
                          ),
                        ),
                        Positioned(
                          right: 0,
                          top: -10,
                          child: Container(
                            padding: EdgeInsets.all(size*.01),
                            decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                gradient: LinearGradient(
                                    colors: [CColor.themeColor, CColor.themeColorLite]
                                )
                            ),
                            child: Icon(Icons.notifications, size: size*.05, color: Colors.white,),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: size*.02,),
                Container(
                  color: const Color(0xff20A3F3),
                  padding: EdgeInsets.symmetric(vertical: size*.03, horizontal: size*.05),
                  child: Text(
                    'সিলেবাস',
                    textAlign: TextAlign.center,
                    style: Style.bodyTextStyle(size*.045, Colors.white, FontWeight.w600),
                  ),
                ),
              ],
            ),
            SizedBox(height: size*.03,),
            Text(
              '২০ নভেম্বর ২০২১, শনিবার',
              textAlign: TextAlign.center,
              style: Style.bodyTextStyle(size*.04, Colors.black, FontWeight.w500),
            ),
            SizedBox(height: size*.2,),
            RichText(
              text: TextSpan(
                style: Style.bodyTextStyle(size*.06, Colors.black, FontWeight.w500),
                children: [
                  TextSpan(
                    text: "RATE ",
                    style: Style.bodyTextStyle(size*.06, Colors.black, FontWeight.w500),
                  ),
                  TextSpan(
                    text: "US",
                    style: Style.bodyTextStyle(size*.06, CColor.themeColor, FontWeight.w500),
                  ),
                ]
              ),
            ),
            SizedBox(height: size*.02,),
            RatingBar(
              ignoreGestures: false,
              glowColor: CColor.greenColor,
              unratedColor: Colors.grey,
              initialRating: 0,
              direction: Axis.horizontal,
              allowHalfRating: true,
              itemCount: 5,
              itemSize: size * .07,
              ratingWidget: RatingWidget(
                full: const Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
                half: const Icon(
                  Icons.star_half,
                  color: Colors.amber,
                ),
                empty: const Icon(
                  Icons.star_outline,
                  color: Colors.amber,
                ),
              ),
              onRatingUpdate: (double value) {},
            ),
            SizedBox(height: size*.02,),
            Container(
              width: size*.5,
              padding: EdgeInsets.symmetric(horizontal: size*.05, vertical: size*.02),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(size*.05),
                border: Border.all(color: const Color(0xff98A7C7), width: 1)
              ),
              child: Row(
                children: [
                  Text(
                    'CONTACT US',
                    style: Style.bodyTextStyle(size*.045, const Color(0xff355496), FontWeight.w500),
                  ),
                  SizedBox(width: size*.04,),
                  const Icon(FontAwesomeIcons.facebookSquare, color: Color(0xff355496),)
                ],
              ),
            ),
          ],
        ),
      );

  /// app bar
  CustomAppBar _pageAppBar(double size, PublicController publicController) =>
      CustomAppBar(
        title: "",
        iconData: Icons.arrow_back,
        action: const [],
        scaffoldKey: _scaffoldKey,
      );
}
