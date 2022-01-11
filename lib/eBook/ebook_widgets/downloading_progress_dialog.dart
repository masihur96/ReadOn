import 'package:flutter/material.dart';
import 'package:read_on/controller/public_controller.dart';
import 'package:read_on/public_variables/style_variable.dart';

void showDownloadingProgressDialog(
    BuildContext context, PublicController publicController, String bookName) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      final double size = publicController.size.value;
      return AlertDialog(
          backgroundColor: Colors.transparent,
          contentPadding: EdgeInsets.zero,
          elevation: 0.0,
          content: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: size,
                padding: EdgeInsets.symmetric(
                    horizontal: size * .04, vertical: size * .04),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(size * .01)),
                child: Column(
                  children: [
                    Image.asset(
                      "assets/icons8-download-from-cloud.gif",
                      width: size * .15,
                      height: size * .15,
                    ),
                    SizedBox(
                      height: size * .03,
                    ),
                    Image.asset(
                      "assets/icons8-literature.gif",
                      width: size * .15,
                      height: size * .15,
                    ),
                    SizedBox(
                      height: size * .06,
                    ),
                    Text(
                      'অপেক্ষা করুন। ডাউনলোড হচ্ছে...',
                      style: Style.bodyTextStyle(
                          size * .04, Colors.black, FontWeight.normal),
                    ),
                    SizedBox(
                      height: size * .06,
                    ),
                    Text(
                      bookName,
                      textAlign: TextAlign.center,
                      style: Style.bodyTextStyle(
                          size * .06, Colors.black, FontWeight.w500),
                    ),
                    SizedBox(
                      height: size * .04,
                    ),
                  ],
                ),
              ),
            ],
          ));
    },
  );
}
