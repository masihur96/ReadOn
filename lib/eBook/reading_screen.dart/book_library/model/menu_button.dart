import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'highlight_type.dart';

part 'menu_button.g.dart';

@HiveType(typeId: 4)
class HighlightMenuButton {
  @HiveField(0)
  int colorIntValue;

  Color get color {
    if (colorIntValue == -1) return Colors.yellowAccent;
    return Color(colorIntValue);
  }

  set color(Color c) {
    colorIntValue = c.value;
  }

  @HiveField(1)
  final highlight_type type;
  @HiveField(2)
  String label;

  HighlightMenuButton(
      {this.type = highlight_type.color,
      this.label = "",
      this.colorIntValue = -1});
}
