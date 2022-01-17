import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:read_on/controller/sqlite_database_helper.dart';
import 'package:read_on/controller/sqlite_reading_helper.dart';
import 'package:read_on/controller/user_controller.dart';
import 'package:read_on/quiz/screens/academic/academic_home_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'eBook/ebook_screens/audio_book_detail.dart';
import 'eBook/ebook_screens/audio_player_page.dart';
import 'eBook/ebook_screens/main_page_ebook.dart';
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
  int _count = 0;
  String deviceId = '';

  void _customInit(
      UserController userController, PublicController publicController) async {
    _count++;
    SharedPreferences pref = await SharedPreferences.getInstance();
    await publicController.getMacAddress().then((value) {
      setState(() {
        deviceId = publicController.deviceId;
      });
      print('device ID = $deviceId');
    });
    String? readOnUserId = pref.getString('readOnUserId');
    String? readOnUserPassword = pref.getString('readOnUserPassword');
    String? readOnUserEmail = pref.getString('readOnUserEmail');
    String? readOnUserPhone = pref.getString('readOnUserPhone');
    Map loginData = {};
    if (readOnUserId != null) {
      if (readOnUserEmail != null) {
        loginData = {
          'email': readOnUserEmail,
          'password': readOnUserPassword,
          'device1': deviceId
        };
        print('valid email: $loginData');
      } else {
        loginData = {
          'phone': readOnUserPhone,
          'password': readOnUserPassword,
          'device1': deviceId
        };
        print('valid phone: $loginData');
      }
    }
    await userController.login(loginData);
    print(userController.userLoginModel.value.userInfo![0].name);
  }

  @override
  Widget build(BuildContext context) {
    final PublicController publicController = Get.find();
    final UserController userController = Get.find();
    final DatabaseHelper databaseHelper = Get.put(DatabaseHelper());
    final ReadingDatabaseHelper databaseHelper2 =
        Get.put(ReadingDatabaseHelper());
    if (_count == 0) _customInit(userController, publicController);
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
                onPressed: () {
                  Get.to(() => const QuizHomePage());
                },
                bgColor: CColor.themeColor),
          ],
        ),
      );
}
