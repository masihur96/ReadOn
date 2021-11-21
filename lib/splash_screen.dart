import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:read_on/controller/public_controller.dart';
import 'package:read_on/home_page.dart';
import 'package:read_on/login_page.dart';

class SplashScreen extends StatefulWidget {
  String? userAccessToken;

  SplashScreen({Key? key, required this.userAccessToken}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3)).then((value) {
      if (widget.userAccessToken == null) {
        Get.offAll(() => LoginPage());
      } else {
        Get.offAll(() => const HomePage());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final PublicController publicController = Get.put(PublicController());
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
