import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:read_on/controller/public_controller.dart';
import 'package:read_on/public_variables/style_variable.dart';
import 'book_front_preview.dart';

class AmarBoi extends StatefulWidget {
  String bookImage;
  String bookName;
  String writerName;
  String bookCompletePercentage;

  AmarBoi(
      {Key? key,
      required this.bookImage,
      required this.bookName,
      required this.writerName,
      required this.bookCompletePercentage})
      : super(key: key);

  @override
  _AmarBoiState createState() => _AmarBoiState();
}

class _AmarBoiState extends State<AmarBoi> {
  @override
  Widget build(BuildContext context) {
    final PublicController publicController = Get.find();
    double size = publicController.size.value;
    return SingleChildScrollView(
      child: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/dot_bg.png'), fit: BoxFit.cover)),
        child: Column(
          children: [
            Container(
              width: size,
              decoration:  BoxDecoration(color: const Color(0xffDFCCBB).withOpacity(0.7)),
              padding: EdgeInsets.only(
                  left: size * .05,
                  right: size * .05,
                  top: size * .025,
                  bottom: size * .04),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'সর্বশেষ পড়া বই',
                    style: Style.bodyTextStyle(
                        size * .05, const Color(0xff803D15), FontWeight.w500),
                  ),
                  SizedBox(height: size * .02),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /// last read book image
                      Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4.0),
                        ),
                        margin: EdgeInsets.zero,
                        child: Container(
                          width: publicController.size.value * .26,
                          height: publicController.size.value * .4,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(4),
                              child: Image.network(widget.bookImage, fit: BoxFit.cover,)),
                        ),
                      ),
                      SizedBox(
                        width: size * .03,
                      ),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: size * .02,
                            ),

                            /// last read book name
                            Padding(
                              padding: EdgeInsets.only(left: size * .04),
                              child: Text(widget.bookName,
                                  style: Style.bodyTextStyle(
                                      size * .05, Colors.black, FontWeight.bold)),
                            ),

                            /// last read book writer name
                            Padding(
                              padding: EdgeInsets.only(left: size * .04),
                              child: Text(
                                widget.writerName,
                                style: Style.bodyTextStyle(
                                    size * .05, Colors.black, FontWeight.normal),
                              ),
                            ),
                            SizedBox(
                              height: size * .1,
                            ),

                            /// last book complete percentage
                            Card(
                              color: Colors.green,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(size * .02),
                              ),
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: size * .065, vertical: size * .01),
                                child: Text(
                                  '${widget.bookCompletePercentage}% সম্পূর্ণ',
                                  style: Style.bodyTextStyle(
                                      size * .04, Colors.white, FontWeight.w500),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: size * .04),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: size * .04),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Text(
                      'পড়তে থাকুন',
                      style: Style.bodyTextStyle(
                          size * .05, Colors.black, FontWeight.w700),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(size * .4),
                        border: Border.all(color: Colors.red, width: size * .005)),
                    padding: EdgeInsets.symmetric(
                        vertical: size * .004, horizontal: size * .045),
                    child: Text(
                      'আরও',
                      style: Style.bodyTextStyle(
                          size * .035, Colors.black, FontWeight.w500),
                    ),
                  )
                ],
              ),
            ),
            //SizedBox(height: size * .04),
            Container(
              height: size*.6,
              padding: EdgeInsets.symmetric(horizontal: size*.04),
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                  physics: const ClampingScrollPhysics(),
                  itemCount: 10,
                  itemBuilder: (context, index) => Padding(
                    padding: EdgeInsets.only(right: size*.06),
                    child: BookPreview(
                      bookImageWidth: size*.26,
                      bookImageHeight: size*.4,
                      bookImage: widget.bookImage,
                      bookName: widget.bookName,
                      writerName: widget.writerName),
                  )),
            ),
            SizedBox(height: size * .04),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: size * .04),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Text(
                      'আবার পড়ুন',
                      style: Style.bodyTextStyle(
                          size * .05, Colors.black, FontWeight.w700),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(size * .4),
                        border: Border.all(color: Colors.red, width: size * .005)),
                    padding: EdgeInsets.symmetric(
                        vertical: size * .004, horizontal: size * .045),
                    child: Text(
                      'আরও',
                      style: Style.bodyTextStyle(
                          size * .035, Colors.black, FontWeight.w500),
                    ),
                  )
                ],
              ),
            ),
            Container(
              height: size*.6,
              padding: EdgeInsets.symmetric(horizontal: size*.04),
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  physics: const ClampingScrollPhysics(),
                  itemCount: 10,
                  itemBuilder: (context, index) => Padding(
                    padding: EdgeInsets.only(right: size*.06),
                    child: BookPreview(
                        bookImageWidth: size*.26,
                        bookImageHeight: size*.4,
                        bookImage: widget.bookImage,
                        bookName: widget.bookName,
                        writerName: widget.writerName),
                  )),
            )
          ],
        ),
      ),
    );
  }
}
