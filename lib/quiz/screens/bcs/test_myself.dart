import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:read_on/controller/public_controller.dart';

import 'package:read_on/public_variables/style_variable.dart';
import 'package:read_on/quiz/screens/bcs/content_details_page.dart';
import 'package:read_on/widgets/custom_appbar.dart';

class TestMySelfPage extends StatefulWidget {
  const TestMySelfPage({Key? key}) : super(key: key);

  @override
  _TestMySelfPageState createState() => _TestMySelfPageState();
}

class _TestMySelfPageState extends State<TestMySelfPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    final PublicController publicController = Get.find();
    double size = publicController.size.value;
    return SafeArea(
        child: Scaffold(
            backgroundColor: Colors.white,
            appBar: PreferredSize(
                preferredSize: AppBar().preferredSize,
                child: _pageAppBar(size)),
            body: Center(
              child: ListView(
                physics: BouncingScrollPhysics(),
                children: [
                  whiteButton(size, 'একত্রে'),
                  whiteButton(size, 'বাংলা ভাষা ও সাহিত্য'),
                  whiteButton(size, 'ইংরেজি ভাষা ও সাহিত্য'),
                  whiteButton(size, 'বাংলাদেশ বিষয়াবলী'),
                  whiteButton(size, 'আন্তর্জাতিক বিষয়াবলী'),
                  whiteButton(size, 'সাধারণ বিজ্ঞান'),
                  whiteButton(size, 'গাণিতিক বিষয়াবলী'),
                  whiteButton(size, 'কম্পিউটার ও তথ্য প্রযুক্তি'),
                  whiteButton(size, 'মানুষিক দক্ষতা'),
                  whiteButton(size, 'নৈতিকতা, মূল্যবোধ ও সুশাসন'),
                  whiteButton(size, 'ভূগোল, পরিবেশ ও দুর্যোগ বাবস্থাপনা'),
                ],
              ),
              // ListView.builder(
              //     padding: const EdgeInsets.all(8),
              //     itemCount: entries.length,
              //     itemBuilder: (BuildContext context, int index) {
              //       return Container(
              //         height: 50,
              //         color: Colors.amber[colorCodes[index]],
              //         child: Center(child: Text('Entry ${entries[index]}')),
              //       );
              //     }
              // );
            )));
  }

  Widget whiteButton(double size, String title) {
    return Column(
      children: [
        SizedBox(
          height: size * .04,
        ),
        InkWell(
          onTap: () {
            Get.to(() => ContentDetails(contentTitle: title));
          },
          child: Container(
            height: size * .1,
            width: size * .8,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                color: Colors.white,
                border: Border.all(color: Colors.grey, width: 2)),
            child: Center(
                child: Padding(
              padding: EdgeInsets.all(size * .01),
              child: Text(
                title,
                style: Style.buttonTextStyle(
                    size * .06, Colors.black, FontWeight.normal),
              ),
            )),
          ),
        ),
      ],
    );
  }

  /// app bar
  CustomAppBar _pageAppBar(double size) => CustomAppBar(
        title: 'নিজেকে যাচাই',
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
