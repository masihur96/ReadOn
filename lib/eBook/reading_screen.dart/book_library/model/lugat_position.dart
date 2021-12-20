import 'dart:convert';

class LugatPosition {
  final int startIndex, endIndex;
  final String meaning, originalText;

  LugatPosition(
      {required this.originalText,
      required this.startIndex,
      required this.endIndex,
      required this.meaning});

  @override
  String toString() {
    return "{\"s\": ${startIndex},\"e\": ${endIndex},\"o\": ${jsonEncode(originalText)},\"m\": ${jsonEncode(meaning)}}";
  }
}
