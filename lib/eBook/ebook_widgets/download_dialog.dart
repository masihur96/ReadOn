import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:read_on/controller/public_controller.dart';
import 'package:read_on/public_variables/color_variable.dart';
import 'package:read_on/public_variables/style_variable.dart';

void showDownloadDialog(BuildContext context, PublicController publicController,
    Function download) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      final double size = publicController.size.value;
      return AlertDialog(
          backgroundColor: Colors.transparent,
          contentPadding: EdgeInsets.zero,
          elevation: 0.0,
          content: Column(
            mainAxisAlignment: MainAxisAlignment.end,
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
                      width: size * .12,
                      height: size * .12,
                    ),
                    SizedBox(
                      height: size * .025,
                    ),
                    Image.asset(
                      "assets/icons8-literature.gif",
                      width: size * .12,
                      height: size * .12,
                    ),
                    SizedBox(
                      height: size * .04,
                    ),
                    Text(
                      'ডাউনলোড',
                      style: Style.bodyTextStyle(
                          size * .05, Colors.black, FontWeight.w500),
                    ),
                    SizedBox(
                      height: size * .04,
                    ),
                    Text(
                      'ইবুক ডাউনলোড করুন এবং অফলাইনে বই পড়ুন',
                      textAlign: TextAlign.center,
                      style: Style.bodyTextStyle(
                          size * .04, Colors.black, FontWeight.normal),
                    ),
                    SizedBox(
                      height: size * .04,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Material(
                            color: Colors.white,
                            child: InkWell(
                              onTap: () async {
                                Navigator.pop(context);
                              },
                              child: Container(
                                padding:
                                    EdgeInsets.symmetric(vertical: size * .02),
                                decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.circular(size * .01),
                                    border: Border.all(
                                        color: Colors.grey.shade300)),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Icon(
                                      LineAwesomeIcons.times,
                                      color: CColor.themeColor,
                                    ),
                                    SizedBox(
                                      width: size * .02,
                                    ),
                                    Text(
                                      'বাতিল',
                                      style: Style.buttonTextStyle(size * .04,
                                          CColor.themeColor, FontWeight.w500),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: size * .05,
                        ),
                        Expanded(
                          child: Material(
                            color: Colors.white,
                            child: InkWell(
                              onTap: () {
                                download();
                              },
                              child: Container(
                                padding:
                                    EdgeInsets.symmetric(vertical: size * .02),
                                decoration: BoxDecoration(
                                    gradient: const LinearGradient(colors: [
                                      CColor.themeColor,
                                      CColor.themeColorLite
                                    ]),
                                    borderRadius:
                                        BorderRadius.circular(size * .01)),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Icon(
                                      LineAwesomeIcons.alternate_cloud_download,
                                      color: Colors.white,
                                    ),
                                    SizedBox(
                                      width: size * .01,
                                    ),
                                    Text(
                                      'ডাউনলোড',
                                      style: Style.buttonTextStyle(size * .04,
                                          Colors.white, FontWeight.w500),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        )
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
