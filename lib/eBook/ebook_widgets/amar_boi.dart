import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(FontAwesomeIcons.book, color: Colors.grey,size: size*.15,),
        SizedBox(height: size*.04,),
        Text(
          'কোন ইবুক পাওয়া যায় নি!',
          style: Style.bodyTextStyle(size*.045, Colors.black, FontWeight.normal),
        ),
      ],
    );
  }
}
