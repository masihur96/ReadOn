import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:read_on/controller/public_controller.dart';

class BookPreview extends StatefulWidget {
  double bookImageWidth;
  double bookImageHeight;
  String bookImage;
  String bookName;
  String writerName;

  BookPreview(
      {Key? key,
      required this.bookImageWidth,
      required this.bookImageHeight,
      required this.bookImage,
      required this.bookName,
      required this.writerName})
      : super(key: key);

  @override
  State<BookPreview> createState() => _BookPreviewState();
}

class _BookPreviewState extends State<BookPreview> {
  String _writerName = '';
  String _bookName = '';

  _checkLength() {
    if (widget.writerName.length > 13) {
      setState(() => _writerName = widget.writerName.substring(0, 12) + '...');
    } else {
      setState(() => _writerName = widget.writerName);
    }
    if (widget.bookName.length > 13) {
      setState(() => _bookName = widget.bookName.substring(0, 12) + '...');
    } else {
      setState(() => _bookName = widget.bookName);
    }
  }

  @override
  Widget build(BuildContext context) {
    final PublicController publicController = Get.find();
    _checkLength();
    return GestureDetector(
      onTap: () {},
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          /// book image
          Card(
            color: Colors.blue,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4.0),
            ),
            margin: EdgeInsets.zero,
            child: Container(
              width: widget.bookImageWidth,
              height: widget.bookImageHeight,
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(4.0),
              ),
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(4.0),
                  child: Image.asset(
                    'assets/book.jpg',
                    fit: BoxFit.cover,
                    color: Colors.red,
                  )),
            ),
          ),
          SizedBox(
            height: publicController.size.value * .01,
          ),

          /// book name
          SizedBox(
            width: publicController.size.value * .26,
            child: Text(
              _bookName,
              style: TextStyle(color: Colors.black),
              textAlign: TextAlign.center,
            ),
          ),

          /// writer name
          SizedBox(
            width: publicController.size.value * .26,
            child: Text(
              _writerName,
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
