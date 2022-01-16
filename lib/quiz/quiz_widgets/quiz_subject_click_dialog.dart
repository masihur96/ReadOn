import 'package:flutter/material.dart';
import 'package:read_on/controller/public_controller.dart';
import 'package:read_on/public_variables/color_variable.dart';
import 'package:read_on/public_variables/style_variable.dart';
void showQuizSubjectClickDialog(
    BuildContext context, PublicController publicController, String bookName) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      final double size = publicController.size.value;
      return AlertDialog(
          backgroundColor: Colors.transparent,
          contentPadding: EdgeInsets.zero,
          insetPadding: EdgeInsets.all(size*.04),
          elevation: 0.0,
          content: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                width: size,
                padding: EdgeInsets.symmetric(
                    horizontal: size * .04, vertical: size * .04),
                decoration:   BoxDecoration(
                  borderRadius: BorderRadius.circular(size*.04),
                    gradient: const LinearGradient(
                        colors: [CColor.cardColor, CColor.cardColor2])),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: size*.04, vertical: size*.01),
                         decoration: BoxDecoration(
                           color: CColor.themeColor,
                           borderRadius: BorderRadius.circular(size*.04),
                           boxShadow: [
                             BoxShadow(
                               color: Colors.grey.withOpacity(0.5),
                               spreadRadius: 2,
                               blurRadius: 3,
                               offset: const Offset(0, 2), // changes position of shadow
                             ),
                           ],
                         ),
                          child: Text(
                            'লাইভ টেস্ট',
                            style: Style.buttonTextStyle(size*.04, Colors.white, FontWeight.w500),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: size*.04, vertical: size*.01),
                          decoration: BoxDecoration(
                            color: CColor.themeColor,
                            borderRadius: BorderRadius.circular(size*.04),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 2,
                                blurRadius: 3,
                                offset: const Offset(0, 2), // changes position of shadow
                              ),
                            ],
                          ),
                          child: Text(
                            'মডেল টেস্ট',
                            style: Style.buttonTextStyle(size*.04, Colors.white, FontWeight.w500),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: size*.04, vertical: size*.01),
                          decoration: BoxDecoration(
                            color: CColor.themeColor,
                            borderRadius: BorderRadius.circular(size*.04),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 2,
                                blurRadius: 3,
                                offset: const Offset(0, 2), // changes position of shadow
                              ),
                            ],
                          ),
                          child: Text(
                            'নিজেকে যাচাই',
                            style: Style.buttonTextStyle(size*.04, Colors.white, FontWeight.w500),
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: size*.04,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: size*.04, vertical: size*.01),
                          decoration: BoxDecoration(
                            color: CColor.themeColor,
                            borderRadius: BorderRadius.circular(size*.04),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 2,
                                blurRadius: 3,
                                offset: const Offset(0, 2), // changes position of shadow
                              ),
                            ],
                          ),
                          child: Text(
                            'বিভিন্ন প্রশ্ন',
                            style: Style.buttonTextStyle(size*.04, Colors.white, FontWeight.w500),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ));
    },
  );
}