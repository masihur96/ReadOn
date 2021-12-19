import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:read_on/controller/public_controller.dart';
import 'package:read_on/eBook/ebook_widgets/custom_appbar.dart';
import 'package:read_on/public_variables/color_variable.dart';
import 'package:read_on/public_variables/style_variable.dart';

class PointCollectionPage extends StatefulWidget {
  const PointCollectionPage({Key? key}) : super(key: key);

  @override
  State<PointCollectionPage> createState() => _PointCollectionPageState();
}

class _PointCollectionPageState extends State<PointCollectionPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    final PublicController publicController = Get.find();
    double size = publicController.size.value;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: PreferredSize(
            preferredSize: AppBar().preferredSize,
            child: _pageAppBar(size, publicController)),
        body: _bodyUI(size),
      ),
    );
  }

  Widget _bodyUI(double size) => Padding(
    padding:  EdgeInsets.all(size*.04),
    child: SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
          Container(
            width: size,
            padding: EdgeInsets.symmetric(vertical: size*.03),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: const Color(0xffCFE9D6),
              borderRadius: BorderRadius.circular(size*.07),
              border: Border.all(color: Colors.grey.shade300, width: 1),
            ),
            child: Text(
              'পয়েন্ট দিয়ে আমি করব কি?',
              style: Style.bodyTextStyle(size*.05, Colors.black, FontWeight.w500)
            ),
          ),
          SizedBox(height: size*.02,),
          _customContainer(size, 'লাইভ কুইজ', 'প্রতিটি লাইভ কুইজে প্রথম হলে ৫০ পয়েন্ট, দ্বিতীয় হলে ৩০ পয়েন্ট ও তৃতীয় হলে ২০ পয়েন্ট ইউজারের একাউন্টে যোগ হবে।'),
          SizedBox(height: size*.02,),
          _customContainer(size, 'বই', 'প্রিমিয়াম বই কিনে প্রথমবার ওপেন করলে ৩০ পয়েন্ট ও ফ্রি বই প্রথমবার ওপেন করলে ১০ পয়েন্ট ইউজারের একাউন্টে যোগ হবে'),
          SizedBox(height: size*.02,),
          _customContainer(size, 'অডিও বই', 'ইবুক থেকে প্রতিটি অডিও বুক ওপেন করলে ২০ পয়েন্ট ইউজারের একাউন্টে যোগ হবে।'),
          SizedBox(height: size*.02,),
          _customContainer(size, 'বই রিভিও', 'ইবুক থেকে কোন বই রিভিও ১০ পয়েন্ট ইউজারের একাউন্টে যোগ হবে।'),
          SizedBox(height: size*.02,),
          _customContainer(size, 'ফলাফল শেয়ার', 'ফলাফল ফেইসবুকে শেয়ার করলে ১০ পয়েন্ট ইউজারের একাউন্টে যোগ হবে।'),
          SizedBox(height: size*.02,),
          _customContainer(size, 'প্রশ্ন যোগ', 'ইউজার প্রশ্ন যোগ করলে প্রতিটি প্রশ্নের জন্য ৫ পয়েন্ট পাবেন।'),
          SizedBox(height: size*.02,),
          _customContainer(size, 'উত্তর প্রদান', 'প্রতিটি সঠিক উত্তরের জন্য ইউজার ১ পয়েন্ট করে পাবে। তবে ভুল উত্তরের জন্য ১ পয়েন্ট করে কাটা যাবে।'),
        ],
      ),
    ),
  );

  CustomAppBar _pageAppBar(double size, PublicController publicController) =>
      CustomAppBar(
        title: "পয়েন্ট সংগ্রহ",
        iconData: LineAwesomeIcons.arrow_left,
        action: const [],
        scaffoldKey: _scaffoldKey,
      );

  Widget _customContainer(double size, String title, String description) => Container(
    width: size,
    padding: EdgeInsets.symmetric(vertical: size*.03, horizontal: size*.03),
    alignment: Alignment.center,
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(size*.02),
      border: Border.all(color: Colors.grey.shade300, width: 2),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
            title,
            style: Style.bodyTextStyle(size*.04, CColor.themeColor, FontWeight.w500)
        ),
        Text(
            description,
            style: Style.bodyTextStyle(size*.04, Colors.black, FontWeight.normal)
        ),
      ],
    )
  );
}
