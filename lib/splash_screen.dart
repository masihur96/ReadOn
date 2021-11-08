import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:read_on/controller/public_controller.dart';
import 'package:read_on/home_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {


  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 4)).then((value) =>
        Get.offAll(() => const HomePage()));
  }

  @override
  Widget build(BuildContext context) {
    final PublicController publicController = Get.put(PublicController());
    return Scaffold(
      body: _bodyUI(publicController),
    );
  }

  Container _bodyUI(PublicController publicController) => Container(
        height: Get.height,
        width: Get.width,
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: AlignmentDirectional.bottomCenter,
                colors: [Colors.white, Colors.redAccent])),
        child: Center(
            child: Image.asset(
          "assets/logo_with_name.png",
          height: publicController.size.value*.4,
          width: publicController.size.value*.4,
        )),
      );
}
