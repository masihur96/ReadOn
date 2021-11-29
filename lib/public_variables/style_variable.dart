import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class Style {
  static TextStyle buttonTextStyle(
          double fontSize, Color color, FontWeight fontWeight) =>
      TextStyle(color: color, fontSize: fontSize, fontWeight: fontWeight, fontFamily: 'HindSiliguri-Medium');

  static TextStyle bodyTextStyle(
          double size, Color color, FontWeight fontWeight) =>
      TextStyle(
        color: color,
        fontSize: size,
        fontWeight: fontWeight,
      );

  static TextStyle headerTextStyle(
          double fontSize, Color color, FontWeight fontWeight) =>
      TextStyle(
          color: color,
          fontSize: fontSize,
          fontWeight: fontWeight,
          fontFamily: 'NotoSansBengali');

  static TextStyle atmaTextStyle(
      double fontSize, Color color, FontWeight fontWeight) =>
      TextStyle(
          color: color,
          fontSize: fontSize,
          fontWeight: fontWeight,
          fontFamily: 'Atma');
}
