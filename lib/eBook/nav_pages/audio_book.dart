import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:read_on/controller/ebook_api_controller.dart';
import 'package:read_on/controller/public_controller.dart';
import 'package:read_on/eBook/ebook_model_classes/product.dart';
import 'package:read_on/public_variables/color_variable.dart';
import 'package:read_on/public_variables/style_variable.dart';
import 'package:shimmer/shimmer.dart';

class AudioBookPage extends StatefulWidget {
  const AudioBookPage({Key? key}) : super(key: key);

  @override
  _AudioBookPageState createState() => _AudioBookPageState();
}

class _AudioBookPageState extends State<AudioBookPage> {
  int _count = 0;
  bool _loading = false;

  void _customInit(EbookApiController ebookApiController) async {
    _count++;
    setState(() => _loading = true);
    await ebookApiController.getAllAudioBooks();
    setState(() => _loading = false);
    // ignore: avoid_print
    print(
        'total audio books = ${ebookApiController.audioBookModel.value.product!
            .length}');
  }

  @override
  Widget build(BuildContext context) {
    final EbookApiController ebookApiController = Get.find();
    final PublicController publicController = Get.find();
    double size = publicController.size.value;
    if (_count == 0) _customInit(ebookApiController);
    return Scaffold(
        backgroundColor: Colors.grey.shade50,
        body: _loading? Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 16.0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Expanded(
                child: Shimmer.fromColors(
                  baseColor: Colors.grey.shade300,
                  highlightColor: Colors.grey.shade100,
                  enabled: true,
                  child: ListView.builder(
                    itemBuilder: (_, __) => Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: size*.01),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            width: size*.26,
                            height: size*.36,
                            color: Colors.white,
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8.0),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                  width: size*.4,
                                  height: size*.06,
                                  color: Colors.white,
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(vertical: size*.01),
                                ),
                                Container(
                                  width: size*.3,
                                  height: size*.05,
                                  color: Colors.white,
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(vertical: size*.02),
                                ),
                                Container(
                                  width: double.infinity,
                                  height: size*.03,
                                  color: Colors.white,
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(vertical: size*.005),
                                ),
                                Container(
                                  width: double.infinity,
                                  height: size*.03,
                                  color: Colors.white,
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(vertical: size*.005),
                                ),
                                Container(
                                  width: size*.5,
                                  height: size*.03,
                                  color: Colors.white,
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    itemCount: 6,
                  ),
                ),
              ),
            ],
          ),
        ):
        ListView.builder(
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            itemCount: 3,
            itemBuilder: (context, index) {
              return audioBookCard(
                  size,
                  ebookApiController.audioBookModel.value.product![0],
                  ebookApiController);
            }));
  }

  Widget audioBookCard(double size, Product product,
      EbookApiController ebookApiController) =>
      Padding(
        padding: EdgeInsets.symmetric(
            horizontal: size * .03, vertical: size * .005),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(size * .03),
          ),
          child: Material(
            color: Colors.white10,
            child: InkWell(
              onTap: (){
              },
              child: Container(
                width: size,
                padding: EdgeInsets.all(size * .03),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(size * .03)),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4.0),
                          ),
                          margin: EdgeInsets.zero,
                          child: Container(
                            width: size * .26,
                            height: size * .36,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4.0),
                                color: Colors.grey.shade50),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(4.0),
                              child: CachedNetworkImage(
                                fit: BoxFit.cover,
                                imageUrl:
                                "${ebookApiController
                                    .domainName}/public//frontend/images/book_thumbnail/${product
                                    .bookThumbnail!}",
                                placeholder: (context, url) =>
                                    Image.asset(
                                      'assets/book_art.png',
                                      fit: BoxFit.contain,
                                    ),
                                errorWidget: (context, url, error) =>
                                const Icon(Icons.error),
                              ),
                            ),
                          ),
                        ),
                        Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: CColor.themeColor.withOpacity(0.8),
                            ),
                            padding: EdgeInsets.all(size * .025),
                            alignment: Alignment.center,
                            child: Icon(
                              FontAwesomeIcons.play,
                              size: size * .04,
                              color: Colors.white.withOpacity(0.7),
                            ))
                      ],
                    ),
                    SizedBox(width: size * .04),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "প্রিয়তমেষু"
                                          .length > 40
                                          ? "প্রিয়তমেষু"
                                          .substring(0, 40) + " ..." : "প্রিয়তমেষু",
                                      maxLines: 2,
                                      style: Style.headerTextStyle(
                                          size * .045, Colors.black,
                                          FontWeight.bold),
                                    ),
                                    Text(
                                      "হুমায়ুন আহমেদ",
                                      style: Style.bodyTextStyle(
                                          size * .035, Colors.black,
                                          FontWeight.normal),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: size*.01),
                                child: Icon(FontAwesomeIcons.headphones, color: Colors.grey,
                                  size: size * .06,),
                              )
                            ],
                          ),

                          SizedBox(height: size * .03),
                          Text(
                            product.bookDescription!.length > 90
                                ? product.bookDescription!.substring(0, 90) + " ..."
                                : product.bookDescription!,
                            textAlign: TextAlign.justify,
                            maxLines: 3,
                            style: Style.bodyTextStyle(
                                size * .035, Colors.black, FontWeight.normal),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      );
}
