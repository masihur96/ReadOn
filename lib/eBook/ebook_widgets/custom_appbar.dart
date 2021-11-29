import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:read_on/controller/public_controller.dart';
import 'package:read_on/public_variables/color_variable.dart';
import 'package:read_on/public_variables/style_variable.dart';

// ignore: must_be_immutable
class CustomAppBar extends StatelessWidget {
  String title;
  List<Widget>? action;
  IconData? iconData;
  GlobalKey<ScaffoldState> scaffoldKey;

  CustomAppBar({Key? key, required this.title, this.iconData, this.action, required this.scaffoldKey}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final PublicController publicController = Get.find();
    double size = publicController.size.value;
    return Container(
      width: Get.width,
      height: AppBar().preferredSize.height,
      padding: EdgeInsets.symmetric(horizontal: size*.04),
      decoration:  const BoxDecoration(
        gradient: LinearGradient(
          colors: [CColor.themeColorLite, CColor.themeColor]
        )
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: (){
              if(iconData == LineAwesomeIcons.bars){
                if (scaffoldKey.currentState!.isDrawerOpen == false) {
                  scaffoldKey.currentState!.openDrawer();
                } else {
                  scaffoldKey.currentState!.openEndDrawer();
                }
              }else{
                Get.back();
              }

            },
            child: Icon(
              iconData,
              color: Colors.white70,
            ),
          ),
          Text(
            title,
            textAlign: TextAlign.end,
            style: Style.buttonTextStyle(size*.05, Colors.white, FontWeight.w500),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: action!
          )
        ],
      ),
    );
  }



}
