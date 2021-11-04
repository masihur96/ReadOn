import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
    final PublicController publicController = Get.put(PublicController());
    return Scaffold(
      backgroundColor: Colors.white,
      body:Container(
        alignment: Alignment.center,
        height: Get.height,
        width: Get.width,
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/home_bg.png'),
                fit: BoxFit.cover
            )
        ),
        child: publicController.homeLoading.value==true
            ?const Center(child: CircularProgressIndicator())
            : Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SolidColorButton(
                child: Text('Quiz',style: Style.buttonTextStyle(publicController.size.value)),
                onPressed:(){},
                bgColor: CColor.themeColor)
          ],
        ),
      ),
    );
}
}

