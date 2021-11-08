import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:read_on/controller/public_controller.dart';
import 'package:read_on/eBook/book_detail.dart';
import 'package:read_on/public_variables/style_variable.dart';

class BookPreview extends StatefulWidget {
  String bookImage;
  String bookName;
  String writerName;

  BookPreview({Key? key, required this.bookImage, required this.bookName, required this.writerName}) : super(key: key);

  @override
  State<BookPreview> createState() => _BookPreviewState();
}

class _BookPreviewState extends State<BookPreview> {
  String _writerName = '';
  String _bookName = '';

  _checkLength(){
    if(widget.writerName.length > 10){
      setState(() => _writerName = widget.writerName.substring(0,10) + '...');
    }else{
      setState(() => _writerName = widget.writerName);
    }
    if(widget.bookName.length > 10) {
      setState(() => _bookName = widget.bookName.substring(0,10) + '...');
    }else{
      setState(() => _bookName = widget.bookName);
    }
  }

  @override
  Widget build(BuildContext context) {
    final PublicController publicController = Get.find();
    _checkLength();
    return GestureDetector(
      onTap: () {
        Get.to(() => const BookDetail());
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [

          /// book image
          Container(
            width: publicController.size.value * .25,
            height: publicController.size.value * .45,
            decoration: BoxDecoration(
              borderRadius:
              BorderRadius.circular(publicController.size.value * .05),
            ),
            child: ClipRRect(
                borderRadius:
                BorderRadius.circular(publicController.size.value * .05),
                child: Image.network(widget.bookImage)),
          ),
          SizedBox(height: publicController.size.value*.02),

          /// book name
          SizedBox(
            width: publicController.size.value * .25,
            child: Text(
              _bookName,
              style: Style.bodyTextStyle(
                  publicController.size.value * .035, Colors.black, FontWeight.bold),
            ),
          ),

          /// writer name
          SizedBox(
            width: publicController.size.value * .25,
            child: Text(
              _writerName,
              style: Style.bodyTextStyle(
                  publicController.size.value * .035, Colors.black, FontWeight.normal),
            ),
          ),
        ],
      ),
    );
  }
}
