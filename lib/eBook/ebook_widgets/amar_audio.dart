import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:read_on/controller/public_controller.dart';
import 'package:read_on/public_variables/style_variable.dart';


class AmarAudio extends StatefulWidget {
  @override
  State<AmarAudio> createState() => _AmarAudioState();
}

class _AmarAudioState extends State<AmarAudio> {
  @override
  Widget build(BuildContext context) {
    final PublicController publicController = Get.find();
    double size = publicController.size.value;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(FontAwesomeIcons.headphones, color: Colors.grey,size: size*.16,),
        SizedBox(height: size*.04,),
        Text(
          'কোন অডিও বুক পাওয়া যায় নি!',
          style: Style.bodyTextStyle(size*.045, Colors.black, FontWeight.normal),
        ),
      ],
    );;
  }
}
