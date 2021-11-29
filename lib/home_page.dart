import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:read_on/eBook/audio_book_detail.dart';
import 'package:read_on/eBook/audio_player_page.dart';
import 'package:read_on/eBook/main_page_ebook.dart';
import 'package:read_on/public_variables/color_variable.dart';
import 'package:read_on/public_variables/style_variable.dart';
import 'package:read_on/widgets/solid_button.dart';
import 'controller/public_controller.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final PublicController publicController = Get.find();
    return Scaffold(
        backgroundColor: Colors.white, body: _bodyUI(publicController));
  }

  Container _bodyUI(PublicController publicController) => Container(
        alignment: Alignment.center,
        height: Get.height,
        width: Get.width,
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/home_bg.png'), fit: BoxFit.cover)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              "assets/logo_with_name.png",
              height: publicController.size.value * .35,
              width: publicController.size.value * .35,
            ),
            SizedBox(height: publicController.size.value * .04),

            /// e-book button
            SolidColorButton(
                contentPadding: EdgeInsets.symmetric(
                    vertical: publicController.size.value * .035,
                    horizontal: publicController.size.value * .16),
                borderRadius: publicController.size.value * .025,
                child: Text('ইবুক',
                    style: Style.buttonTextStyle(
                        publicController.size.value * .05,
                        Colors.white,
                        FontWeight.w500)),
                onPressed: () {
                  Get.to(() => const MainPage());
                },
                bgColor: CColor.themeColor),
            SizedBox(height: publicController.size.value * .04),

            /// course button
            SolidColorButton(
                contentPadding: EdgeInsets.symmetric(
                    vertical: publicController.size.value * .035,
                    horizontal: publicController.size.value * .16),
                borderRadius: publicController.size.value * .025,
                child: Text('কোর্স',
                    style: Style.buttonTextStyle(
                        publicController.size.value * .05,
                        Colors.white,
                        FontWeight.w500)),
                onPressed: () {},
                bgColor: CColor.themeColor),
            SizedBox(height: publicController.size.value * .04),

            /// quiz button
            SolidColorButton(
                contentPadding: EdgeInsets.symmetric(
                    vertical: publicController.size.value * .035,
                    horizontal: publicController.size.value * .16),
                borderRadius: publicController.size.value * .025,
                child: Text('কুইজ',
                    style: Style.buttonTextStyle(
                        publicController.size.value * .05,
                        Colors.white,
                        FontWeight.w500)),
                onPressed: () {},
                bgColor: CColor.themeColor),
          ],
        ),
      );
}
