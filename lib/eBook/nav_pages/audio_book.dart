import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:read_on/controller/ebook_api_controller.dart';
import 'package:read_on/controller/public_controller.dart';
import 'package:read_on/eBook/ebook_widgets/book_front_preview.dart';

class AudioBookPage extends StatefulWidget {
  const AudioBookPage({Key? key}) : super(key: key);

  @override
  _AudioBookPageState createState() => _AudioBookPageState();
}

class _AudioBookPageState extends State<AudioBookPage> {
  int _count = 0;

  void _customInit(EbookApiController ebookApiController) async {
    _count++;
    await ebookApiController.getAllAudioBooks();
    print('total audio books = ${ebookApiController.audioBookList.length}');
  }

  @override
  Widget build(BuildContext context) {
    final EbookApiController ebookApiController = Get.find();
    final PublicController publicController = Get.find();
    double size = publicController.size.value;
    if (_count == 0) _customInit(ebookApiController);
    return Scaffold(
        backgroundColor: Colors.white,
        body: ListView.builder(
          shrinkWrap: true,
          physics: const BouncingScrollPhysics(),
          itemCount: 5,
          itemBuilder: (context, index) {

            return audioBookCard(size);
          },
        ));
  }

  Widget audioBookCard(double size) => Padding(
        padding: EdgeInsets.all(size * .03),
        child: Card(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(size * .03),
          ),
          child: Container(
            width: size,
            padding: EdgeInsets.all(size * .03),
            decoration: BoxDecoration(
                color: Colors.white10,
                borderRadius: BorderRadius.circular(size * .03)),
            child: Row(
              children: [
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                  margin: EdgeInsets.zero,
                  child: Container(
                    width: size * .26,
                    height: size * .38,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4.0),
                        color: Colors.grey.shade50),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(4.0),
                      child: Image.asset(
                        'assets/book_art.png',
                        fit: BoxFit.contain,
                      ),
                      // child: CachedNetworkImage(
                      //   fit: BoxFit.cover,
                      //   imageUrl: widget.bookImage,
                      //   placeholder: (context, url) => Image.asset('assets/book_art.png', fit: BoxFit.contain,),
                      //   errorWidget: (context, url, error) => const Icon(Icons.error),
                      // ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
}
