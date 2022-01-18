import 'package:flutter/material.dart';
import 'package:read_on/controller/public_controller.dart';
import 'package:read_on/public_variables/color_variable.dart';
import 'package:read_on/public_variables/style_variable.dart';

void showAnswerSubmitDialog(BuildContext context, PublicController publicController){
  showDialog(context: context, builder: (BuildContext context){
    final double size = publicController.size.value;
    return AlertDialog(
      backgroundColor: Colors.transparent,
      contentPadding: EdgeInsets.zero,
      insetPadding: EdgeInsets.symmetric(horizontal: size*.1),
      elevation: 0,
      content: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: size,
            decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: const Offset(0, 2), // changes position of shadow
                  ),
                ],
                borderRadius: BorderRadius.circular(size * .05)),
            child: Column(
              children: [
                Container(
                  width: size,
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.symmetric(vertical: size*.02, horizontal: size*.06),
                  decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [CColor.themeColor, CColor.themeColorLite],
                      ),
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(size*.05), topRight: Radius.circular(size*.05))
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: size*.12,
                        height: size*.12,
                        alignment: Alignment.center,
                        padding: EdgeInsets.all(size*.01),
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white
                        ),
                        child: Image.asset("assets/read_on_icon.png", fit: BoxFit.contain),
                      ),
                      SizedBox(width: size*.1,),
                      Text(
                        'বাংলা ১ম পত্র',
                        style: Style.atmaTextStyle(size*.07, Colors.white, FontWeight.w500),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(size*.04),
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(horizontal: size*.06, vertical: size*.03),
                    decoration: const BoxDecoration(
                        color: Colors.white
                    ),
                    child: Text(
                      'আপনার ২৫টি প্রশ্ন এখনও বাকি। আপনি কি সত্যিই উত্তরপত্র জমা দিতে চান?',
                      textAlign: TextAlign.center,
                      style: Style.bodyTextStyle(size*.04, Colors.black, FontWeight.w500),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: size*.05, top: size*.02, left: size*.06, right: size*.06),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Image.asset("assets/red_cancel_icon.png", width: size*.12, height: size*.12),
                      Image.asset("assets/green_check_icon.png", width: size*.12, height: size*.12),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  });
}