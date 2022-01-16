import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:read_on/controller/public_controller.dart';
import 'package:read_on/public_variables/color_variable.dart';
import 'package:read_on/public_variables/style_variable.dart';
import 'package:read_on/quiz/quiz_widgets/quiz_subject_click_dialog.dart';
import 'package:read_on/widgets/custom_appbar.dart';
import 'package:read_on/widgets/gradient_button.dart';

class AcademicSubjectPage extends StatefulWidget {
  @override
  _AcademicSubjectPageState createState() => _AcademicSubjectPageState();
}

class _AcademicSubjectPageState extends State<AcademicSubjectPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  final _divisionList = ['আবশ্যিক', 'বিজ্ঞান', 'ব্যবসায় শিক্ষা', 'মানবিক'];

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
        body: _bodyUI(size, publicController),
      ),
    );
  }

  /// body
  Widget _bodyUI(double size, PublicController publicController) => Padding(
        padding:
            EdgeInsets.symmetric(horizontal: size * .03, vertical: size * .05),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  alignment: Alignment.center,
                  child: GradientButton(
                      child: Text(
                        '৫ম শ্রেণি',
                        style: Style.buttonTextStyle(
                            size * .04, Colors.white, FontWeight.w500),
                      ),
                      onPressed: () {},
                      borderRadius: size * .02,
                      height: size * .1,
                      width: size * .3,
                      gradientColors: const [
                        CColor.themeColor,
                        CColor.themeColorLite
                      ]),
                ),
                Container(
                  alignment: Alignment.center,
                  child: GradientButton(
                      child: Text(
                        '৬ষ্ঠ শ্রেণি',
                        style: Style.buttonTextStyle(
                            size * .04, Colors.white, FontWeight.w500),
                      ),
                      onPressed: () {},
                      borderRadius: size * .02,
                      height: size * .1,
                      width: size * .3,
                      gradientColors: const [
                        CColor.themeColor,
                        CColor.themeColorLite
                      ]),
                ),
                Container(
                  alignment: Alignment.center,
                  child: GradientButton(
                      child: Text(
                        '৭ম শ্রেণি',
                        style: Style.buttonTextStyle(
                            size * .04, Colors.white, FontWeight.w500),
                      ),
                      onPressed: () {},
                      borderRadius: size * .02,
                      height: size * .1,
                      width: size * .3,
                      gradientColors: const [
                        CColor.themeColor,
                        CColor.themeColorLite
                      ]),
                ),
              ],
            ),
            SizedBox(
              height: size * .01,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  alignment: Alignment.center,
                  height: size * .1,
                  width: size * .3,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(size * .02),
                    gradient: const LinearGradient(colors: [CColor.themeColor, CColor.themeColorLite]),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 2,
                        offset: const Offset(0, 1), // changes position of shadow
                      ),
                    ],
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton2(
                      isExpanded: true,
                      onChanged: (value) {},
                      hint: const Text(
                        'জেএসসি',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      items: _divisionList
                          .map((item) => DropdownMenuItem<String>(
                        value: item,
                        child: Container(
                          color: Colors.grey.shade300,
                          margin: EdgeInsets.only(bottom: size*.01),
                          width: double.infinity,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Padding(
                                padding:EdgeInsets.all(size*.02,),
                                child: Text(
                                  item,
                                  style: TextStyle(
                                    fontSize: size * .04,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                              const Divider(
                                thickness: 2,
                                color: CColor.themeColor,
                                height: 1,
                              )
                            ],
                          ),
                        ),
                      ))
                          .toList(),
                      iconSize: 24,
                      iconEnabledColor: Colors.white,
                      iconDisabledColor: Colors.white,
                      buttonPadding: const EdgeInsets.only(left: 12, right: 12),
                      buttonElevation: 2,
                      dropdownMaxHeight: 400,
                      dropdownPadding: EdgeInsets.zero,
                      dropdownDecoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(2),
                        color: Colors.white,
                      ),
                      dropdownElevation: 8,
                      scrollbarRadius: const Radius.circular(40),
                      scrollbarThickness: 6,
                      scrollbarAlwaysShow: true,
                      offset: const Offset(0, -8),
                      itemPadding: EdgeInsets.zero,
                    ),
                  )
                ),
                Container(
                    alignment: Alignment.center,
                    height: size * .1,
                    width: size * .3,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(size * .02),
                      gradient: const LinearGradient(
                          colors: [CColor.themeColor, CColor.themeColorLite]),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 2,
                          offset:
                              const Offset(0, 1), // changes position of shadow
                        ),
                      ],
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton2(
                        isExpanded: true,
                        onChanged: (value) {},
                        hint: const Text(
                          'এসএসসি',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                        items: _divisionList
                            .map((item) => DropdownMenuItem<String>(
                                  value: item,
                                  child: Container(
                                    color: Colors.grey.shade300,
                                    margin: EdgeInsets.only(bottom: size*.01),
                                    width: double.infinity,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Padding(
                                          padding:EdgeInsets.all(size*.02,),
                                          child: Text(
                                            item,
                                            style: TextStyle(
                                              fontSize: size * .04,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ),
                                        const Divider(
                                          thickness: 2,
                                          color: CColor.themeColor,
                                          height: 1,
                                        )
                                      ],
                                    ),
                                  ),
                                ))
                            .toList(),
                        iconSize: 24,
                        iconEnabledColor: Colors.white,
                        iconDisabledColor: Colors.white,
                        buttonPadding: const EdgeInsets.only(left: 12, right: 12),
                        buttonElevation: 2,
                        dropdownMaxHeight: 400,
                        dropdownPadding: EdgeInsets.zero,
                        dropdownDecoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(2),
                          color: Colors.white,
                        ),
                        dropdownElevation: 8,
                        scrollbarRadius: const Radius.circular(40),
                        scrollbarThickness: 6,
                        scrollbarAlwaysShow: true,
                        offset: const Offset(0, -8),
                        itemPadding: EdgeInsets.zero,
                      ),
                    )),
                Container(
                  alignment: Alignment.center,
                  height: size * .1,
                  width: size * .3,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(size * .02),
                    gradient: const LinearGradient(
                        colors: [CColor.themeColor, CColor.themeColorLite]),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 2,
                        offset:
                            const Offset(0, 1), // changes position of shadow
                      ),
                    ],
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton2(
                      isExpanded: true,
                      onChanged: (value) {},
                      hint: const Text(
                        'এইচএসসি',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      items: _divisionList
                          .map((item) => DropdownMenuItem<String>(
                        value: item,
                        child: Container(
                          color: Colors.grey.shade300,
                          margin: EdgeInsets.only(bottom: size*.01),
                          width: double.infinity,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Padding(
                                padding:EdgeInsets.all(size*.02,),
                                child: Text(
                                  item,
                                  style: TextStyle(
                                    fontSize: size * .04,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                              const Divider(
                                thickness: 2,
                                color: CColor.themeColor,
                                height: 1,
                              )
                            ],
                          ),
                        ),
                      ))
                          .toList(),
                      iconSize: 24,
                      iconEnabledColor: Colors.white,
                      iconDisabledColor: Colors.white,
                      buttonPadding: const EdgeInsets.only(left: 10, right: 10),
                      buttonElevation: 2,
                      dropdownMaxHeight: 400,
                      dropdownPadding: EdgeInsets.zero,
                      dropdownDecoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(2),
                        color: Colors.white,
                      ),
                      dropdownElevation: 8,
                      scrollbarRadius: const Radius.circular(40),
                      scrollbarThickness: 6,
                      scrollbarAlwaysShow: true,
                      offset: const Offset(0, -8),
                      itemPadding: EdgeInsets.zero,
                    ),
                  )
                ),
              ],
            ),
            SizedBox(
              height: size * .1,
            ),
            Expanded(
              child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 3,
                      mainAxisSpacing: size * .04,
                      crossAxisSpacing: size * .04),
                  itemCount: 7,
                  itemBuilder: (context, index) {
                    return _customSubjectOption(
                        size, "বাংলা ১ম পত্র", publicController);
                  }),
            )
          ],
        ),
      );

  /// app bar
  CustomAppBar _pageAppBar(double size, PublicController publicController) =>
      CustomAppBar(
        title: "একাডেমিক",
        iconData: Icons.arrow_back,
        action: const [],
        scaffoldKey: _scaffoldKey,
      );

  /// subject option
  Widget _customSubjectOption(
          double size, String title, PublicController publicController) =>
      InkWell(
        onTap: () {
          showQuizSubjectClickDialog(context, publicController, "ok");
        },
        child: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(
              horizontal: size * .04, vertical: size * .02),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(size * .03),
            border: Border.all(color: Colors.grey, width: 2),
          ),
          child: Text(
            title,
            textAlign: TextAlign.center,
            maxLines: 2,
            style:
                Style.bodyTextStyle(size * .04, Colors.black, FontWeight.w500),
          ),
        ),
      );
}
