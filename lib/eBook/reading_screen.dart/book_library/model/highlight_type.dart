import 'package:hive_flutter/hive_flutter.dart';

part 'highlight_type.g.dart';

@HiveType(typeId: 2)
enum highlight_type {
  @HiveField(0)
  color,
  @HiveField(1)
  bold,
  @HiveField(2)
  underline,
  @HiveField(3)
  italic
}
