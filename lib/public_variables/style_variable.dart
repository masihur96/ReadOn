import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
class Style{

  static TextStyle buttonTextStyle(double size)=>TextStyle(
    color: Colors.white,
    fontSize: size*.05,
    fontWeight: FontWeight.w500
  );

  static TextStyle bodyTextStyle(double size, Color color, FontWeight fontWeight)=>TextStyle(
      color: color,
      fontSize: size,
      fontWeight: fontWeight,
  );
}