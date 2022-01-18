import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:read_on/controller/public_controller.dart';
import 'package:read_on/public_variables/color_variable.dart';
import 'package:read_on/public_variables/style_variable.dart';
import 'package:read_on/widgets/custom_appbar.dart';

class OlympiadHomePage extends StatefulWidget {
  const OlympiadHomePage({Key? key}) : super(key: key);

  @override
  State<OlympiadHomePage> createState() => _OlympiadHomePageState();
}

class _OlympiadHomePageState extends State<OlympiadHomePage> {
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

  /// body
  Widget _bodyUI(double size) => Container(
        width: size,
        height: Get.height,
        padding: EdgeInsets.symmetric(horizontal: size * .15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: size * .03),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                    colors: [CColor.greenDark, CColor.greenLight]),
                borderRadius: BorderRadius.circular(size * .1),
              ),
              child: Text(
                'ফিজিক্স অলিম্পিয়াড',
                textAlign: TextAlign.center,
                style: Style.bodyTextStyle(
                    size * .05, Colors.white, FontWeight.bold),
              ),
            ),
            SizedBox(
              height: size * .1,
            ),
            Container(
              width: size * .4,
              padding: EdgeInsets.symmetric(vertical: size * .02),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                    colors: [CColor.themeColor, CColor.themeColorLite]),
                borderRadius: BorderRadius.circular(size * .03),
              ),
              child: Text(
                'নিজেকে যাচাই',
                textAlign: TextAlign.center,
                style: Style.bodyTextStyle(
                    size * .05, Colors.white, FontWeight.bold),
              ),
            ),
            SizedBox(
              height: size * .04,
            ),
            Container(
              width: size * .4,
              padding: EdgeInsets.symmetric(vertical: size * .02),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                    colors: [CColor.themeColor, CColor.themeColorLite]),
                borderRadius: BorderRadius.circular(size * .03),
              ),
              child: Text(
                'মডেল টেস্ট',
                textAlign: TextAlign.center,
                style: Style.bodyTextStyle(
                    size * .05, Colors.white, FontWeight.bold),
              ),
            ),
            SizedBox(
              height: size * .04,
            ),
            Container(
              width: size * .4,
              padding: EdgeInsets.symmetric(vertical: size * .02),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                    colors: [CColor.themeColor, CColor.themeColorLite]),
                borderRadius: BorderRadius.circular(size * .03),
              ),
              child: Text(
                'লাইভ টেস্ট',
                textAlign: TextAlign.center,
                style: Style.bodyTextStyle(
                    size * .05, Colors.white, FontWeight.bold),
              ),
            ),
            SizedBox(
              height: size * .04,
            ),
            Container(
              width: size * .4,
              padding: EdgeInsets.symmetric(vertical: size * .02),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                    colors: [CColor.themeColor, CColor.themeColorLite]),
                borderRadius: BorderRadius.circular(size * .03),
              ),
              child: Text(
                'প্রশ্ন ব্যাংক',
                textAlign: TextAlign.center,
                style: Style.bodyTextStyle(
                    size * .05, Colors.white, FontWeight.bold),
              ),
            ),

          ],
        ),
      );

  /// app bar
  CustomAppBar _pageAppBar(double size, PublicController publicController) =>
      CustomAppBar(
        title: "অলিম্পিয়াড",
        iconData: Icons.arrow_back,
        action: const [],
        scaffoldKey: _scaffoldKey,
      );
}
