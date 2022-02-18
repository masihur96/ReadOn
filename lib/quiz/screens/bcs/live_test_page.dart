import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:read_on/controller/public_controller.dart';

import 'package:read_on/public_variables/color_variable.dart';
import 'package:read_on/public_variables/style_variable.dart';
import 'package:read_on/quiz/quiz_widgets/answer_submit_dialog.dart';
import 'package:read_on/quiz/quiz_widgets/exam_alert_dialog.dart';
import 'package:read_on/quiz/quiz_widgets/question_rating_dialog.dart';
import 'package:read_on/quiz/screens/bcs/exam_finishing_page.dart';
import 'package:read_on/quiz/screens/bcs/exam_screen.dart';
import 'package:read_on/quiz/screens/bcs/result_page.dart';
import 'package:read_on/quiz/screens/olympiad/olympiad_home_page.dart';
import 'package:read_on/widgets/custom_appbar.dart';

class LiveTestPage extends StatefulWidget {
  const LiveTestPage({Key? key}) : super(key: key);

  @override
  _LiveTestPageState createState() => _LiveTestPageState();
}

class _LiveTestPageState extends State<LiveTestPage> {
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
        body: ListView(
          // crossAxisAlignment: CrossAxisAlignment.center,
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: size * .1,
            ),
            Text(
              'পরবর্তী পরীক্ষা \n শুক্রবার , ১০ নভেম্বর ২০২১',
              textAlign: TextAlign.center,
              style: Style.bodyTextStyle(
                  size * .07, Colors.black, FontWeight.bold),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: size * .1),
              child: Divider(
                height: size * .05,
                color: Colors.black,
              ),
            ),
            Text(
              '২৪ ঘণ্টার মধ্যে আপনি যে কোন সময় পরীক্ষাটি দিতে পারবেন। রুটিন,সিলেবাস ও আগের পরীক্ষার প্রশ্ন নিচে দেখুন',
              textAlign: TextAlign.center,
              style: Style.bodyTextStyle(
                  size * .07, Colors.black, FontWeight.normal),
            ),
            SizedBox(
              height: size * .07,
            ),
            Row(
              children: [
                Expanded(
                  child: Container(
                    height: size * .01,
                    color: CColor.themeColor,
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (_) => ExamScreen()));
                  },
                  child: Container(
                    height: size * .12,
                    decoration: BoxDecoration(
                      color: CColor.themeColor,
                      borderRadius:
                          BorderRadius.all(Radius.circular(size * .4)),
                    ),
                    child: Center(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: size * .1),
                        child: Text(
                          'পরীক্ষা দিন',
                          style: Style.bodyTextStyle(
                              size * .07, Colors.white, FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    height: size * .01,
                    color: CColor.themeColor,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: size * .2,
            ),
            Container(
              height: size * .3,
              width: size,
              decoration: const BoxDecoration(
                  gradient: LinearGradient(colors: [
                CColor.cardColor2,
                CColor.cardColor,
              ])),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  imageButton(size, 'assets/result_icon.png', 'ফলাফল',
                      publicController),
                  imageButton(size, 'assets/archive_icon.png', 'আর্কাইভ',
                      publicController),
                  imageButton(size, 'assets/routine_icon.png', 'রুটিন',
                      publicController),
                ],
              ),
            ),
            SizedBox(
              height: size * .1,
            ),
            Container(
              height: size * .3,
              width: size,
              decoration: const BoxDecoration(
                  gradient: LinearGradient(
                      colors: [CColor.cardColor, CColor.cardColor2])),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  imageButton(size, 'assets/syllabus_icon.png', 'সিলেবাস',
                      publicController),
                  imageButton(size, 'assets/merit_list_icon.png', 'মেধা তালিকা',
                      publicController),
                  imageButton(size, 'assets/statistic_icon.png', 'পরিসংখ্যান',
                      publicController),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget imageButton(double size, String imgPath, String title,
      PublicController publicController) {
    return GestureDetector(
      onTap: () {
        if (title == 'ফলাফল') {
          showQuestionRatingDialog(context, publicController);
        }
        if (title == 'আর্কাইভ') {
          showAnswerSubmitDialog(context, publicController);
        }
        if (title == 'রুটিন') {
          showExamAlertDialog(context, publicController);
        }
        if (title == 'সিলেবাস') {
          Get.to(() => const ExamFinishingPage());
        }
        if (title == 'মেধা তালিকা') {
          Get.to(() => const OlympiadHomePage());
        }
        if (title == 'পরিসংখ্যান') {
          Get.to(() => ResultPage());
        }
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            imgPath,
            height: size * .1,
            width: size * .1,
          ),
          SizedBox(
            height: size * .01,
          ),
          Text(
            title,
            style:
                Style.bodyTextStyle(size * .04, Colors.black, FontWeight.bold),
          )
        ],
      ),
    );
  }

  /// app bar
  CustomAppBar _pageAppBar(double size) => CustomAppBar(
        title: 'লাইভ টেস্ট',
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
