import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

import 'package:read_on/public_variables/color_variable.dart';
import 'package:read_on/public_variables/style_variable.dart';
import 'package:read_on/quiz/screens/bcs/live_test_page.dart';
import 'package:read_on/quiz/screens/bcs/test_myself.dart';
import 'package:read_on/widgets/custom_appbar.dart';

class BCSHomePage extends StatefulWidget {
  const BCSHomePage({Key? key}) : super(key: key);

  @override
  _BCSHomePageState createState() => _BCSHomePageState();
}

class _BCSHomePageState extends State<BCSHomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: PreferredSize(
            preferredSize: AppBar().preferredSize, child: _pageAppBar(size)),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: buttonWidget(size, 'লাইভ টেস্ট'),
            ),
            SizedBox(
              height: size.width * .05,
            ),
            Center(
              child: buttonWidget(size, 'নিজেকে যাচাই'),
            ),
            SizedBox(
              height: size.width * .05,
            ),
            Center(
              child: buttonWidget(size, 'মডেল টেস্ট'),
            ),
            SizedBox(
              height: size.width * .05,
            ),
            Center(
              child: buttonWidget(size, 'প্রশ্ন ব্যাংক'),
            ),
          ],
        ),
      ),
    );
  }

  Widget buttonWidget(
    Size size,
    String title,
  ) {
    return InkWell(
      onTap: () {
        if (title == 'লাইভ টেস্ট') {
          Get.to(() => const LiveTestPage());
          print('লাইভ টেস্ট');
        } else if (title == 'নিজেকে যাচাই') {
          Get.to(() => const TestMySelfPage());
          print('নিজেকে যাচাই');
        } else if (title == 'মডেল টেস্ট') {
          print('মডেল টেস্ট');
        } else if (title == 'প্রশ্ন ব্যাংক') {
          print('প্রশ্ন ব্যাংক');
        }
      },
      child: Container(
        height: size.width * .15,
        width: size.width * .9,
        padding: EdgeInsets.symmetric(
            horizontal: size.width * .2, vertical: size.width * .02),
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            color: CColor.themeColor),
        child: Center(
            child: Text(title,
                style: Style.buttonTextStyle(
                    size.width * .07, Colors.white, FontWeight.w500))),
      ),
    );
  }

  /// app bar
  CustomAppBar _pageAppBar(Size size) => CustomAppBar(
        title: 'বিসিএস',
        iconData: LineAwesomeIcons.arrow_left,
        action: [
          Icon(
            Icons.menu_outlined,
            color: Colors.white,
            size: size.width * .08,
          ),
        ],
        scaffoldKey: _scaffoldKey,
      );
}
