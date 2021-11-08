import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:read_on/public_variables/color_variable.dart';

// ignore: must_be_immutable
class CustomAppBar extends StatelessWidget {
  String title;
  List<Widget>? action;
  IconData? iconData;
  GlobalKey<ScaffoldState> scaffoldKey;

  CustomAppBar({Key? key, required this.title, this.iconData, this.action, required this.scaffoldKey}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: CColor.themeColor,
      leading:  InkWell(
        onTap: (){
          if (scaffoldKey.currentState!.isDrawerOpen == false) {
            scaffoldKey.currentState!.openDrawer();
          } else {
            scaffoldKey.currentState!.openEndDrawer();
          }
        },
        child: Icon(
          iconData,
          color: Colors.white70,
        ),
      ),
      elevation: 0,
      centerTitle: true,
      title:  Text(
        title,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w400
        ),
      ),
      actions: action,
    );
  }
}
