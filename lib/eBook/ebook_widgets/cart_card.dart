import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:read_on/controller/public_controller.dart';
import 'package:read_on/public_variables/color_variable.dart';
import 'package:read_on/public_variables/style_variable.dart';

class CartCard extends StatelessWidget {
  String bookImage;
  String bookName;
  String writerName;
  String amount;
  String bookCopyType;
  Widget? child;

  CartCard(
      {Key? key,
      required this.bookImage,
      required this.bookName,
      required this.writerName,
      required this.amount,
      required this.bookCopyType,
      required this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final PublicController publicController = Get.find();
    double size = publicController.size.value;
    return Card(
      color: Colors.grey.shade100,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4.0),
      ),
      child: Container(
        width: size,
        padding: EdgeInsets.all(size*.04),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: publicController.size.value * .24,
              height: publicController.size.value * .35,
              decoration: BoxDecoration(
                borderRadius:
                    BorderRadius.circular(4.0),
              ),
              child: ClipRRect(
                  borderRadius:
                      BorderRadius.circular(4.0),
                  child: Image.network(bookImage, fit: BoxFit.cover,)),
            ),
            SizedBox(
              width: size * .04,
            ),
            Expanded(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: size * .02,
                ),
                Text(bookName,
                    style: Style.buttonTextStyle(
                        size * .045, Colors.black, FontWeight.bold)),
                // Text(
                //   writerName,
                //   style: Style.bodyTextStyle(
                //       size * .04, Colors.black, FontWeight.normal),
                // ),
                Text(
                  bookCopyType,
                  style: Style.bodyTextStyle(
                      size * .04, Colors.black, FontWeight.w500),
                ),
                Text(
                  '৳ $amount/-',
                  style: Style.bodyTextStyle(
                      size * .04, Colors.red, FontWeight.normal),
                ),
                SizedBox(
                  height: size * .02,
                ),
                child!
              ],
            )),

          ],
        ),
      ),
    );
  }
}
