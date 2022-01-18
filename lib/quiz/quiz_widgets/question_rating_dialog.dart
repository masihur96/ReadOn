import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:read_on/controller/public_controller.dart';
import 'package:read_on/public_variables/color_variable.dart';
import 'package:read_on/public_variables/style_variable.dart';

void showQuestionRatingDialog(BuildContext context, PublicController publicController){
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
                  padding: EdgeInsets.symmetric(vertical: size*.02),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [CColor.themeColor, CColor.themeColorLite],
                    ),
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(size*.05), topRight: Radius.circular(size*.05))
                  ),
                  child: Container(
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
                ),
                Padding(
                  padding: EdgeInsets.all(size*.04),
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(horizontal: size*.05, vertical: size*.03),
                    decoration: const BoxDecoration(
                      color: Color(0xffF3CA92)
                    ),
                    child: Column(
                      children: [
                        Text(
                          'এই পরীক্ষার প্রশ্নের উপর আপনার রেটিং দিন',
                          textAlign: TextAlign.center,
                          style: Style.bodyTextStyle(size*.04, Colors.black, FontWeight.w500),
                        ),
                        SizedBox(height: size*.04,),
                        RatingBar(
                          ignoreGestures: false,
                          glowColor: CColor.greenColor,
                          unratedColor: Colors.grey,
                          initialRating: 0,
                          direction: Axis.horizontal,
                          allowHalfRating: true,
                          itemCount: 5,
                          itemSize: size * .07,
                          ratingWidget: RatingWidget(
                            full: const Icon(
                              Icons.star,
                              color: CColor.themeColor,
                            ),
                            half: const Icon(
                              Icons.star_half,
                              color: CColor.themeColor,
                            ),
                            empty: const Icon(
                              Icons.star,
                              color: Colors.white,
                            ),
                          ),
                          onRatingUpdate: (double value) {},
                        ),
                        SizedBox(height: size*.03,),
                        Divider(
                          color: Colors.white,
                          thickness: 2,
                          height: size*.01,
                        ),
                        SizedBox(height: size*.03,),
                        TextFormField(
                          keyboardType: TextInputType.multiline,
                          maxLines: 5,
                          cursorColor: Colors.black,
                          style: Style.bodyTextStyle(size*.04, Colors.black, FontWeight.normal),
                          decoration: InputDecoration(
                            hintText: "মতামত দিন",
                            hintStyle: Style.bodyTextStyle(size*.04, Colors.grey, FontWeight.normal),
                            fillColor: Colors.white,
                            isDense: true,
                            contentPadding: EdgeInsets.all(size*.03),
                            filled: true,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(size*.02),
                              borderSide: const BorderSide(color: Colors.white)
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(size*.02),
                                borderSide: const BorderSide(color: Colors.white)
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(size*.02),
                                borderSide: const BorderSide(color: Colors.white)
                            ),
                            disabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(size*.02),
                                borderSide: const BorderSide(color: Colors.white)
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: size*.05, top: size*.02, left: size*.02, right: size*.02),
                  child: Image.asset("assets/green_check_icon.png", width: size*.12, height: size*.12),
                )
              ],
            ),
          ),
        ],
      ),
    );
  });
}