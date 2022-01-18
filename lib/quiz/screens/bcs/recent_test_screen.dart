import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:read_on/controller/public_controller.dart';
import 'package:read_on/public_variables/color_variable.dart';
import 'package:read_on/public_variables/style_variable.dart';
import 'package:read_on/widgets/custom_appbar.dart';

class RecentTest extends StatefulWidget {
  const RecentTest({Key? key}) : super(key: key);

  @override
  _RecentTestState createState() => _RecentTestState();
}

class _RecentTestState extends State<RecentTest> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    final PublicController publicController = Get.find();
    double size = publicController.size.value;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: PreferredSize(
            preferredSize: AppBar().preferredSize, child: _pageAppBar(size)),
        body: Padding(
          padding: EdgeInsets.all(size * .05),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: size * .01,
                ),
                ListView.builder(
                    padding: const EdgeInsets.all(8),
                    itemCount: 10,
                    shrinkWrap: true,
                    itemBuilder: (BuildContext context, int index) {
                      return noticeListTile(size);
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget noticeListTile(double size) {
    return Column(
      children: [
        SizedBox(
          height: size * .05,
        ),
        Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(20),
              ),
              border: Border.all(color: CColor.themeColor, width: 4)),
          child: Padding(
            padding: EdgeInsets.all(size * .02),
            child: Column(
              children: [
                Container(child: Image.asset('assets/pin_board_icon.png')),
                Container(
                  width: size * .8,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          bottomRight: Radius.circular(30)),
                      color: Color(0xffFBDDDD)),
                  child: Center(
                    child: Padding(
                      padding: EdgeInsets.all(size * .03),
                      child: Text(
                        '০১ জুলাই ২০২২',
                        style: Style.bodyTextStyle(
                            size * .07, Colors.black, FontWeight.bold),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: size * .05,
                ),
                Text(
                  'সোনালি ব্যাংক এর কম্পিউটার অপারেটর নিয়োগ পরীক্ষার প্রশ্ন এবং উত্তর',
                  textAlign: TextAlign.center,
                  style: Style.bodyTextStyle(
                      size * .06, Colors.black87, FontWeight.normal),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }

  /// app bar
  CustomAppBar _pageAppBar(double size) => CustomAppBar(
        title: 'সাম্প্রতিক পরীক্ষা',
        iconData: LineAwesomeIcons.arrow_left,
        action: [
          Icon(
            Icons.menu_outlined,
            color: Colors.white,
            size: size * .08,
          ),
        ],
        scaffoldKey: _scaffoldKey,
      );
}
