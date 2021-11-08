import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:read_on/controller/public_controller.dart';
import 'package:read_on/public_variables/style_variable.dart';

class CartCard extends StatelessWidget {
  String bookImage;
  String bookName;
  String writerName;
  String amount;
  String bookCopyType;

  CartCard(
      {Key? key,
      required this.bookImage,
      required this.bookName,
      required this.writerName,
      required this.amount,
      required this.bookCopyType})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final PublicController publicController = Get.find();
    double size = publicController.size.value;
    return Card(
      color: Colors.grey.shade100,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(size * .02),
      ),
      child: Container(
        width: size,
        padding: EdgeInsets.fromLTRB(size*.04, size*.01, size*.04, size*.02),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: publicController.size.value * .22,
              height: publicController.size.value * .42,
              decoration: BoxDecoration(
                borderRadius:
                    BorderRadius.circular(publicController.size.value * .05),
              ),
              child: ClipRRect(
                  borderRadius:
                      BorderRadius.circular(publicController.size.value * .05),
                  child: Image.network(bookImage)),
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
                    style: Style.bodyTextStyle(
                        size * .045, Colors.black, FontWeight.bold)),
                Text(
                  writerName,
                  style: Style.bodyTextStyle(
                      size * .045, Colors.black, FontWeight.normal),
                ),
                Text(
                  amount,
                  style: Style.bodyTextStyle(
                      size * .045, Colors.red, FontWeight.normal),
                ),
                Text(
                  bookCopyType,
                  style: Style.bodyTextStyle(
                      size * .045, Colors.black, FontWeight.w500),
                ),
                SizedBox(
                  height: size * .02,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                        alignment: Alignment.center,
                        color: Colors.red,
                        child: Icon(
                          LineAwesomeIcons.alternate_trash,
                          color: Colors.white,
                          size: size * .08,
                        )),
                  ],
                )
              ],
            )),

          ],
        ),
      ),
    );
  }
}
