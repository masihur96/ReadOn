import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:read_on/controller/ebook_api_controller.dart';
import 'package:read_on/controller/public_controller.dart';
import 'package:read_on/controller/reading_api_controller.dart';
import 'package:read_on/controller/sqlite_reading_helper.dart';

import 'package:read_on/controller/user_controller.dart';
import 'package:read_on/eBook/reading_screen.dart/reading_screen.dart';
import 'package:read_on/feature/controller/audio_api_controller.dart';

import 'package:read_on/home_page.dart';
import 'package:read_on/login_page.dart';

class SplashScreen extends StatefulWidget {
  String? readOnUserId;

  SplashScreen({Key? key, required this.readOnUserId}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3)).then((value) {
      if (widget.readOnUserId == null) {
        Get.offAll(() => const HomePage());
      } else {
        Get.offAll(() => const HomePage());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final PublicController publicController = Get.put(PublicController());

    final EbookApiController ebookApiController = Get.put(EbookApiController());
    final ReadingApiController readingApiController =
        Get.put(ReadingApiController());
    final UserController userController = Get.put(UserController());
//After Marge
    // final ReadingApiController databaseHelper = Get.put(ReadingApiController());
    final AudioApiController audioApiController = Get.put(AudioApiController());
    final ReadingDatabaseHelper readingDatabaseHelper =
        Get.put(ReadingDatabaseHelper());

    return Scaffold(
      body: _bodyUI(publicController, size),
    );
  }

  Container _bodyUI(PublicController publicController, Size size) => Container(
        alignment: Alignment.center,
        height: Get.height,
        width: Get.width,
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: AlignmentDirectional.bottomCenter,
                colors: [Colors.white, Colors.redAccent])),
        child: Image.asset(
          "assets/logo_with_name.png",
          height: size.width * .4,
          width: size.width * .4,
        ),
      );
}
