import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:read_on/controller/public_controller.dart';
import 'package:read_on/eBook/ebook_widgets/custom_appbar.dart';
import 'package:read_on/public_variables/color_variable.dart';
import 'package:read_on/public_variables/style_variable.dart';

class CoinCollectionPage extends StatefulWidget {
  const CoinCollectionPage({Key? key}) : super(key: key);

  @override
  _CoinCollectionPageState createState() => _CoinCollectionPageState();
}

class _CoinCollectionPageState extends State<CoinCollectionPage> {
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
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
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
                'কয়েন দিয়ে আমি করব কি?',
                style: Style.bodyTextStyle(size*.05, Colors.black, FontWeight.w500)
            ),
          ),
          SizedBox(height: size*.02,),
          _customContainer(size, 'নিবন্ধন', 'প্রথমবার নিবন্ধন করে ১০০ কয়েন গ্রহণ করুন'),
          SizedBox(height: size*.02,),
          _customContainer(size, 'রেফার', 'বন্ধুকে অ্যাপটি রেফার করে ১০০ কয়েন পেতে পারেন। তবে অ্যাপটি যাকে রেফার করবেন সে নিবন্ধন করলেই কেবল আপনার একাউন্টে ১০০ কয়েন যোগ হবে। যতবার রেফার হবে ততবার ১০০ কয়েন করে যোগ হবে।'),
          SizedBox(height: size*.02,),
          _customContainer(size, '১০০+ টাকার বই', '১০০ টাকার বেশি যত টাকার বই কিনবেন তার অর্ধেক আপনার ওয়ালেটে জমা হবে।'),
          SizedBox(height: size*.02,),
          _customContainer(size, 'বুক রিভিও', 'ইবুক থেকে প্রতিটি বইয়ের গঠনমূলক রিভিউ করে ১০ কয়েন অর্জন করুন। তবে রিভিউটি রিডঅন এর পক্ষ থেকে গ্রহণযোগ্য হতে হবে।'),
          SizedBox(height: size*.02,),
          _customContainer(size, 'লাইভ কুইজে অংশগ্রহণ', 'প্রতিবার লাইভ কুইজে অংশগ্রহণ করলে ৫ কয়েন করে পাবেন।'),
          SizedBox(height: size*.02,),
          _customContainer(size, 'প্রিমিয়াম বই', 'প্রতিটি প্রিমিয়াম বই কিনে ২০ কয়েন অর্জন করুন।'),
          SizedBox(height: size*.02,),
          _customContainer(size, 'লগইন', 'প্রতিদিন একবার প্রবেশ করলে ৫ কয়েন করে পাবেন।'),
        ],
      ),
    ),
  );

  CustomAppBar _pageAppBar(double size, PublicController publicController) =>
      CustomAppBar(
        title: "কয়েন সংগ্রহ",
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
              textAlign: TextAlign.justify,
              style: Style.bodyTextStyle(size*.04, CColor.themeColor, FontWeight.w500)
          ),
          Text(
              description,
              textAlign: TextAlign.justify,
              style: Style.bodyTextStyle(size*.04, Colors.black, FontWeight.normal)
          ),
        ],
      )
  );
}
