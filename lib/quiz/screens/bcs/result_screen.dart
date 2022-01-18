import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:read_on/controller/public_controller.dart';
import 'package:read_on/public_variables/color_variable.dart';
import 'package:read_on/public_variables/style_variable.dart';
import 'package:read_on/widgets/custom_appbar.dart';

class ResultScreen extends StatefulWidget {
  const ResultScreen({Key? key}) : super(key: key);

  @override
  _ResultScreenState createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    final PublicController publicController = Get.find();
    double size = publicController.size.value;
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
            preferredSize: AppBar().preferredSize, child: _pageAppBar(size)),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(size * .04),
            child: Column(
              children: [
                SizedBox(
                  height: size * .03,
                ),
                IntrinsicHeight(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '১০ ডিসেম্বর ২০২১, শনিবার',
                        style: Style.bodyTextStyle(
                            size * .04, Colors.black, FontWeight.bold),
                      ),
                      VerticalDivider(
                        color: Colors.black,
                        thickness: 2,
                      ),
                      Text(
                        'বাংলা ১ম পত্র',
                        style: Style.bodyTextStyle(
                            size * .04, Colors.black, FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: size * .03,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      height: size * .2,
                      width: size * .4,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        border: Border.all(color: Colors.grey, width: 2),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'মোট পরীক্ষার্থী',
                            style: Style.bodyTextStyle(
                                size * .05, Colors.black54, FontWeight.normal),
                          ),
                          Divider(
                            thickness: 2,
                            color: Colors.grey,
                          ),
                          Text(
                            '২৫০',
                            style: Style.bodyTextStyle(
                                size * .05, Colors.black54, FontWeight.normal),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: size * .2,
                      width: size * .4,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        border: Border.all(color: Colors.grey, width: 2),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'উত্তীর্ণ পরীক্ষার্থী',
                            style: Style.bodyTextStyle(
                                size * .05, Colors.black54, FontWeight.normal),
                          ),
                          Divider(
                            thickness: 2,
                            color: Colors.grey,
                          ),
                          Text(
                            '১৫০',
                            style: Style.bodyTextStyle(
                                size * .05, Colors.black54, FontWeight.normal),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: size * .04,
                ),
                Container(
                  height: size * .3,
                  width: size * .3,
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                          colors: [CColor.greenLight, CColor.greenDark])),
                  child: Container(
                    margin: EdgeInsets.all(size * .03),
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle, color: Colors.white),
                    child: Center(
                      child: Text(
                        '২০',
                        style: Style.bodyTextStyle(
                            size * .1, Colors.black, FontWeight.normal),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: size * .03,
                ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: size * .02),
                  width: size * .8,
                  height: size * .1,
                  decoration: const BoxDecoration(
                      gradient: LinearGradient(
                          colors: [CColor.greenLight, CColor.greenDark]),
                      borderRadius: BorderRadius.all(Radius.circular(5))),
                  child: Center(
                    child: Text(
                      'আপনি উত্তীর্ণ হয়েছেন',
                      style: Style.bodyTextStyle(
                          size * .06, Colors.white, FontWeight.bold),
                    ),
                  ),
                ),
                SizedBox(
                  height: size * .03,
                ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: size * .02),
                  width: size * .8,
                  height: size * .1,
                  decoration: const BoxDecoration(
                      gradient: LinearGradient(
                          colors: [CColor.themeColor, CColor.themeColorLite]),
                      borderRadius: BorderRadius.all(Radius.circular(5))),
                  child: Center(
                    child: Text(
                      'আপনি অনুত্তীর্ণ হয়েছেন',
                      style: Style.bodyTextStyle(
                          size * .06, Colors.white, FontWeight.bold),
                    ),
                  ),
                ),
                SizedBox(
                  height: size * .03,
                ),
                Container(
                  height: size * .2,
                  width: size * .5,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    border: Border.all(color: Colors.grey, width: 2),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'আপনার অবস্থান',
                        style: Style.bodyTextStyle(
                            size * .05, Colors.black54, FontWeight.normal),
                      ),
                      Divider(
                        thickness: 2,
                        color: Colors.grey,
                      ),
                      Text(
                        '৪০ তম',
                        style: Style.bodyTextStyle(
                            size * .05, Colors.black54, FontWeight.normal),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: size * .03,
                ),
                SizedBox(
                  width: size,
                  child: Column(
                    children: [
                      IntrinsicHeight(
                        child: Container(
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.black),
                              color: const Color(0xffD0E9D6),
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(size * .04),
                                  topRight: Radius.circular(size * .04))),
                          child: Row(
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: size * .03),
                                  child: Text(
                                    'বিষয়',
                                    textAlign: TextAlign.center,
                                    style: Style.bodyTextStyle(size * .04,
                                        Colors.black, FontWeight.w500),
                                  ),
                                ),
                              ),
                              const VerticalDivider(
                                width: 1,
                                thickness: 1,
                                color: Colors.black,
                              ),
                              Expanded(
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: size * .03),
                                  child: Text(
                                    'সঠিক',
                                    textAlign: TextAlign.center,
                                    style: Style.bodyTextStyle(size * .04,
                                        Colors.black, FontWeight.w500),
                                  ),
                                ),
                              ),
                              const VerticalDivider(
                                width: 1,
                                thickness: 1,
                                color: Colors.black,
                              ),
                              Expanded(
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: size * .03),
                                  child: Text(
                                    'ভুল',
                                    textAlign: TextAlign.center,
                                    style: Style.bodyTextStyle(size * .04,
                                        Colors.black, FontWeight.w500),
                                  ),
                                ),
                              ),
                              const VerticalDivider(
                                width: 1,
                                thickness: 1,
                                color: Colors.black,
                              ),
                              Expanded(
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: size * .03),
                                  child: Text(
                                    'অসম্পূর্ণ',
                                    textAlign: TextAlign.center,
                                    style: Style.bodyTextStyle(size * .04,
                                        Colors.black, FontWeight.w500),
                                  ),
                                ),
                              ),
                              const VerticalDivider(
                                width: 1,
                                thickness: 1,
                                color: Colors.black,
                              ),
                              Expanded(
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: size * .03),
                                  child: Text(
                                    'প্রাপ্ত নম্বর',
                                    textAlign: TextAlign.center,
                                    style: Style.bodyTextStyle(size * .04,
                                        Colors.black, FontWeight.w500),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      IntrinsicHeight(
                        child: Container(
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.black),
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(size * .04),
                                  bottomRight: Radius.circular(size * .04))),
                          child: Row(
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: size * .03),
                                  child: Text(
                                    'মোট',
                                    textAlign: TextAlign.center,
                                    style: Style.bodyTextStyle(size * .04,
                                        Colors.black, FontWeight.w500),
                                  ),
                                ),
                              ),
                              const VerticalDivider(
                                width: 1,
                                thickness: 1,
                                color: Colors.black,
                              ),
                              Expanded(
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: size * .03),
                                  child: Text(
                                    '২০',
                                    textAlign: TextAlign.center,
                                    style: Style.bodyTextStyle(size * .04,
                                        Colors.black, FontWeight.w500),
                                  ),
                                ),
                              ),
                              const VerticalDivider(
                                width: 1,
                                thickness: 1,
                                color: Colors.black,
                              ),
                              Expanded(
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: size * .03),
                                  child: Text(
                                    '৭',
                                    textAlign: TextAlign.center,
                                    style: Style.bodyTextStyle(size * .04,
                                        Colors.black, FontWeight.w500),
                                  ),
                                ),
                              ),
                              const VerticalDivider(
                                width: 1,
                                thickness: 1,
                                color: Colors.black,
                              ),
                              Expanded(
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: size * .03),
                                  child: Text(
                                    '৩',
                                    textAlign: TextAlign.center,
                                    style: Style.bodyTextStyle(size * .04,
                                        Colors.black, FontWeight.w500),
                                  ),
                                ),
                              ),
                              const VerticalDivider(
                                width: 1,
                                thickness: 1,
                                color: Colors.black,
                              ),
                              Expanded(
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: size * .03),
                                  child: Text(
                                    '২০',
                                    textAlign: TextAlign.center,
                                    style: Style.bodyTextStyle(size * .04,
                                        Colors.black, FontWeight.w500),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: size * .06,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: size * .05),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        width: size * .35,
                        decoration: BoxDecoration(
                            color: const Color(0xff6B6B6B),
                            borderRadius: BorderRadius.circular(size * .02)),
                        padding: EdgeInsets.symmetric(vertical: size * .03),
                        child: Text(
                          'উত্তরপত্র',
                          textAlign: TextAlign.center,
                          style: Style.bodyTextStyle(
                              size * .045, Colors.white, FontWeight.w600),
                        ),
                      ),
                      Container(
                        width: size * .35,
                        decoration: BoxDecoration(
                            color: const Color(0xff6B6B6B),
                            borderRadius: BorderRadius.circular(size * .02)),
                        padding: EdgeInsets.symmetric(vertical: size * .03),
                        child: Text(
                          'মেধা তালিকা',
                          textAlign: TextAlign.center,
                          style: Style.bodyTextStyle(
                              size * .045, Colors.white, FontWeight.w600),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: size * .06,
                ),
                Container(
                  width: size * .6,
                  padding: EdgeInsets.symmetric(vertical: size * .02),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(size * .05),
                      border:
                          Border.all(color: const Color(0xff6B6B6B), width: 1)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'ফলাফল শেয়ার করুন',
                        style: Style.bodyTextStyle(size * .045,
                            const Color(0xff6B6B6B), FontWeight.w500),
                      ),
                      SizedBox(
                        width: size * .04,
                      ),
                      const Icon(
                        Icons.share,
                        color: Color(0xff6B6B6B),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// app bar
  CustomAppBar _pageAppBar(double size) => CustomAppBar(
        title: 'ফলাফল',
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
