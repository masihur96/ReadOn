import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:read_on/controller/public_controller.dart';
import '../ebook_screens/book_detail.dart';
import 'package:read_on/eBook/ebook_model_classes/product.dart';
import 'package:read_on/public_variables/style_variable.dart';

class BookPreview extends StatefulWidget {
  double bookImageWidth;
  double bookImageHeight;
  String bookImage;
  String bookName;
  String writerName;
  Product product;

  BookPreview({Key? key,required this.bookImageWidth, required this.bookImageHeight, required this.bookImage, required this.bookName, required this.writerName, required this.product}) : super(key: key);

  @override
  State<BookPreview> createState() => _BookPreviewState();
}

class _BookPreviewState extends State<BookPreview> {
  String _writerName = '';
  String _bookName = '';

  _checkLength(){
    if(widget.writerName.length > 15){
      setState(() => _writerName = widget.writerName.substring(0,12) + '...');
    }else{
      setState(() => _writerName = widget.writerName);
    }
    if(widget.bookName.length > 15) {
      setState(() => _bookName = widget.bookName.substring(0,12) + '...');
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
        print('tapped on book ${widget.product.name}');
        Navigator.push(context, MaterialPageRoute(builder: (context) => BookDetail(product: widget.product,)));
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [

          /// book image
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4.0),
            ),
            margin: EdgeInsets.zero,
            child: Container(
              width: widget.bookImageWidth,
              height: widget.bookImageHeight,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4.0),
                color: Colors.grey.shade50
              ),
              child: ClipRRect(
                  borderRadius:
                  BorderRadius.circular(4.0),
                  child: CachedNetworkImage(
                    fit: BoxFit.cover,
                    imageUrl: widget.bookImage,
                    placeholder: (context, url) => Image.asset('assets/book_art.png', fit: BoxFit.contain,),
                    errorWidget: (context, url, error) => const Icon(Icons.error),
                  ),

              ),
            ),
          ),
          SizedBox(height: publicController.size.value*.01,),

          /// book name
          SizedBox(
            width: publicController.size.value * .26,
            child: Text(
              _bookName,
              textAlign: TextAlign.center,
              style: Style.bodyTextStyle(
                  publicController.size.value * .032, Colors.black, FontWeight.bold),
            ),
          ),

          /// writer name
          SizedBox(
            width: publicController.size.value * .26,
            child: Text(
              _writerName,
              textAlign: TextAlign.center,
              style: Style.bodyTextStyle(
                  publicController.size.value * .032, Colors.black, FontWeight.normal),
            ),
          ),
        ],
      ),
    );
  }
}
