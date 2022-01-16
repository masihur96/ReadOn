import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:read_on/controller/public_controller.dart';
import 'package:read_on/eBook/ebook_widgets/custom_drawer.dart';
import 'package:read_on/public_variables/color_variable.dart';
import 'package:read_on/quiz/screens/academic/academic_subject_page.dart';

class QuizHomeNav extends StatefulWidget {
  const QuizHomeNav({Key? key}) : super(key: key);

  @override
  State<QuizHomeNav> createState() => _QuizHomeNavState();
}

class _QuizHomeNavState extends State<QuizHomeNav> {


  @override
  Widget build(BuildContext context) {
    final PublicController publicController = Get.find();
    final double size = publicController.size.value;

    return Scaffold(
      body: _bodyUI(size),
    );
  }

  /// body
  Container _bodyUI(double size) => Container(
        width: Get.width,
        height: Get.height,
        padding: EdgeInsets.all(size * .03),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              "assets/logo_with_name.png",
              width: size * .25,
              height: size * .25,
            ),
            SizedBox(
              height: size * .04,
            ),
            Container(
              width: double.infinity,
              padding: EdgeInsets.only(bottom: size * .04),
              decoration: BoxDecoration(
                  color: const Color(0xffEFE0E3),
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(size * .03),
                      bottomRight: Radius.circular(size * .03))),
              child: Column(
                children: [
                  Container(
                      width: double.infinity,
                      height: size * .05,
                      decoration: const BoxDecoration(
                          gradient: LinearGradient(colors: [
                        CColor.themeColor,
                        CColor.themeColorLite
                      ]))),
                  SizedBox(height: size*.03,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _customOption(size, "assets/academic_icon.png", "একাডেমিক"),
                      _customOption(size, "assets/bcs_icon.png", "বিসিএস"),
                      _customOption(size, "assets/admission_icon.png", "ভর্তি প্রস্তুতি"),
                      _customOption(size, "assets/job_search_icon.png", "চাকরি-বাকরি"),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: size * .04,
            ),
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: size * .04),
              decoration: BoxDecoration(
                  color: const Color(0xffEFE0E3),
                  borderRadius: BorderRadius.circular(size * .03),
                border: Border.all(color: CColor.themeColor, width: 1)
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _customOption(size, "assets/daily_quiz_icon.png", "ডেইলি কুইজ"),
                  _customOption(size, "assets/ques_answer_icon.png", "প্রশ্ন-উত্তর"),
                  _customOption(size, "assets/olympiad_icon.png", "অলিম্পিয়াড"),
                  _customOption(size, "assets/read_on_live_quiz_icon.png", "লাইভ কুইজ"),
                ],
              ),
            ),
            SizedBox(
              height: size * .06,
            ),
            Align(
              alignment: Alignment.center,
              child: Container(
                padding: EdgeInsets.symmetric(vertical: size * .01, horizontal: size*.06),
                decoration: BoxDecoration(
                    color: const Color(0xffEFE0E3),
                    borderRadius: BorderRadius.circular(size * .05),
                    border: Border.all(color: CColor.themeColor, width: 1)
                ),
                child: Text(
                  "নোটিশ বোর্ড",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: size * .04,
                      fontWeight: FontWeight.w500),
                ),
              ),
            )
          ],
        ),
      );

  /// option
  Widget _customOption(double size, String image, String title) => GestureDetector(
    onTap: (){
      if(title == "একাডেমিক"){
        Get.to(() => AcademicSubjectPage());
      }
    },
    child: Column(
          children: [
            SizedBox(
                width: size * .14,
                height: size * .14,
                child: Image.asset(
                  image,
                  width: size * .14,
                  height: size * .14,
                  fit: BoxFit.contain,
                )),
            Text(
              title,
              style: TextStyle(
                  color: Colors.black,
                  fontSize: size * .035,
                  fontWeight: FontWeight.w500),
            )
          ],
        ),
  );
}
