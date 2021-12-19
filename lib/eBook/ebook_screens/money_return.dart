import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:read_on/controller/public_controller.dart';
import 'package:read_on/eBook/ebook_widgets/custom_appbar.dart';
import 'package:read_on/public_variables/color_variable.dart';
import 'package:read_on/public_variables/style_variable.dart';
import 'package:read_on/widgets/gradient_button.dart';

class MoneyReturnPage extends StatefulWidget {
  const MoneyReturnPage({Key? key}) : super(key: key);

  @override
  _MoneyReturnPageState createState() => _MoneyReturnPageState();
}

class _MoneyReturnPageState extends State<MoneyReturnPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  final TextEditingController _customerComplainController = TextEditingController();
  final String _commitmentText = 'প্রিয় গ্রাহক, রিডঅন অ্যাপে রেজিস্টার করার জন্য আপনাকে ধন্যবাদ। '
  'রিডঅন থেকে কোনো প্রিমিয়াম প্যাক কিনতে বা ডাউনলোড করতে সমস্যা হলে আমাদের সাথে ফোন, ফেইসবুক বা ইমেইলের মাধ্যমে '
  'যোগাযোগ করুন। আমাদের সাথে যোগাযোগ করার পরও যদি আপনার সমস্যার সমাধান না হয় তাহলে আপনার সম্পূর্ণ টাকা ফেরত দেওয়া হবে।';

  @override
  Widget build(BuildContext context) {
    final PublicController publicController = Get.find();
    final double size = publicController.size.value;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: PreferredSize(
            preferredSize: AppBar().preferredSize,
            child: _pageAppBar()),
        body: _bodyUI(size),
      ),
    );
  }

  Widget _bodyUI(double size) => SizedBox(
    width: Get.width,
    height: Get.height,
    child: ListView(
      children: [
        SizedBox(
          width: size,
          height: size * .42,
          child: Stack(
            children: [
              Positioned(
                top: -size * .62,
                left: -size * .2,
                child: Container(
                  width: size,
                  height: size,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xffEAEAEA),
                  ),
                ),
              ),

            ],
          ),
        ),
        SizedBox(height: size*.1,),
        Container(
          width: Get.width,
          padding: EdgeInsets.symmetric(horizontal: size*.15),
          child: Text(_commitmentText,
            textAlign: TextAlign.justify,
            style: Style.bodyTextStyle(size*.04, Colors.black, FontWeight.w500),
          ),
        ),
        SizedBox(height: size*.05,),

        /// phone, g-mail, messenger icons
        Container(
          width: Get.width,
          height: size*.14,
          padding: EdgeInsets.symmetric(horizontal: size*.25, vertical: size*.02),
          color: const Color(0xffF3F3F3),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Image.asset('assets/phone.png'),
              Image.asset('assets/gmail.png'),
              Image.asset('assets/messenger.png'),
            ],
          ),
        ),
        SizedBox(height: size*.05,),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: size*.1),
          child: _customTextFormField(size, _customerComplainController, 'আপনার মতামত বা অভিযোগ লিখুন...', true, null),
        ),
        SizedBox(height: size*.02,),

        /// 'জমা দিন' button
        Container(
          alignment: Alignment.center,
          child: GradientButton(
              child: Text(
                'জমা দিন',
                style: Style.buttonTextStyle(size*.04, Colors.white, FontWeight.w500),
              ),
              onPressed: (){},
              borderRadius: size*.01,
              height: size*.1,
              width: size*.3,
              gradientColors: const [CColor.themeColor, CColor.themeColorLite]),
        ),
        SizedBox(height: size*.04,),
      ],
    ),
  );


  TextFormField _customTextFormField(double size, TextEditingController controller, String hintText, bool enabled, Widget? suffixIcon) => TextFormField(
    controller: controller,
    autofocus: false,
    enabled: enabled,
    maxLines: 7,
    style: Style.bodyTextStyle(size*.045, Colors.black, FontWeight.normal),
    decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(vertical: size*.02, horizontal: size*.04),
        hintText: hintText,
        hintStyle: Style.bodyTextStyle(size*.04, const Color(0xff7F7F7F), FontWeight.normal),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(size*.02),
            borderSide: const BorderSide(color: Colors.black)
        ),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(size*.02),
            borderSide: const BorderSide(color: Colors.black)
        ),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(size*.02),
            borderSide: const BorderSide(color: Colors.black)
        ),
        disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(size*.02),
            borderSide: const BorderSide(color: Colors.black)
        ),
        suffixIcon: suffixIcon
    ),
  );

  CustomAppBar _pageAppBar() => CustomAppBar(
    title: "টাকা ফেরত",
    iconData: LineAwesomeIcons.arrow_left,
    action: const [
      SizedBox()
    ],
    scaffoldKey: _scaffoldKey,
  );
}

