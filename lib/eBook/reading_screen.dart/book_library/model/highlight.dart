import 'package:hive_flutter/hive_flutter.dart';

import 'highlight_type.dart';

part 'highlight.g.dart';

@HiveType(typeId: 1)
class Highlight implements Comparable {
  @HiveField(0)
  final int baseOffset;

  @HiveField(1)
  final int extendOffset;

  @HiveField(3)
  final int color;

  @HiveField(4)
  final String? text;

  @HiveField(5)
  final highlight_type type;

  Highlight({
    this.type = highlight_type.color,
    this.text,
    required this.color,
    required this.baseOffset,
    required this.extendOffset,
  });

  @override
  int compareTo(other) {
    if (this.baseOffset < other.baseOffset) {
      return -1;
    }
    return 1;
  }
}
