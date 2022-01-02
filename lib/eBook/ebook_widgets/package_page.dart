import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:read_on/controller/ebook_api_controller.dart';
import 'package:read_on/controller/public_controller.dart';
import 'package:read_on/eBook/ebook_model_classes/package_model.dart';
import 'package:read_on/public_variables/color_variable.dart';
import 'package:read_on/public_variables/style_variable.dart';

class PackagePage extends StatefulWidget {
  @override
  _PackagePageState createState() => _PackagePageState();
}

class _PackagePageState extends State<PackagePage> {

  int _count = 0;
  bool _loading = false;

  Future <void> _customInit(EbookApiController ebookApiController) async {
    _count++;
    setState(() => _loading = true);
    await ebookApiController.getPackageList();
    setState(() => _loading = false);
    print('package list = ${ebookApiController.packageList.length}');
  }

  @override
  Widget build(BuildContext context) {
    final EbookApiController ebookApiController = Get.find();
    final PublicController publicController = Get.find();
    double size = publicController.size.value;
    if(_count == 0) _customInit(ebookApiController);
    return _loading
        ? SizedBox() : ebookApiController.packageList.isNotEmpty?  ListView.builder(
      shrinkWrap: true,
      physics: const BouncingScrollPhysics(),
      itemCount: ebookApiController.packageList.length,
      itemBuilder: (context, index){
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: size*.04),
          child: _packageCard(size, ebookApiController, ebookApiController.packageList[index]),
        );
      },
    ) : const Center(child: Text('কোন প্যাকেজ নেই!'));
  }

  /// package card
  Card _packageCard(double size, EbookApiController ebookApiController, PackageModel packageModel) =>
      Card(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(size * .03),
        ),
        child: Container(
          width: size,
          decoration: BoxDecoration(
              color: Colors.white10,
              borderRadius: BorderRadius.circular(size * .03)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.only(topLeft: Radius.circular(size * .03), topRight: Radius.circular(size * .03)),
                child: CachedNetworkImage(
                  height: size*.4,
                  width: size,
                  fit: BoxFit.cover,
                  imageUrl: "${ebookApiController.domainName}/public//frontend/images/package_thumbnail/${packageModel.thumbnail!}",
                  placeholder: (context, url) => const CupertinoActivityIndicator(),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
              SizedBox(height: size*.02,),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: size*.04),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            packageModel.packageName!,
                            textAlign: TextAlign.center,
                            style: Style.headerTextStyle(size*.04, Colors.black, FontWeight.w500),
                          ),
                          Text(
                            packageModel.bookDescription!,
                            textAlign: TextAlign.center,
                            style: Style.headerTextStyle(size*.035, Colors.black, FontWeight.w500),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      '৳ ১১৫/-',
                      style: Style.bodyTextStyle(size*.07, CColor.themeColor, FontWeight.w500),
                    )
                  ],
                ),
              ),


              SizedBox(height: size*.02,)
            ],
          ),
        ),
      );
}
