import 'package:flutter/material.dart';

class ParagraphWidget extends StatelessWidget {
  const ParagraphWidget({
    Key? key,
    required this.paragraph,
    required this.index,
  }) : super(key: key);

  final String paragraph;
  final int index;

  @override
  Widget build(BuildContext context) {
    return isProbablyArabic(paragraph)
        ? SelectableText(
            paragraph,
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.red),
            onSelectionChanged: (selection, cause) {
              print('index: ${index}');
              print(selection);
              print(cause);
            },
          )
        : SelectableText(
            paragraph,
            onSelectionChanged: (selection, cause) {
              print('index: ${index}');
              print(selection);
              print(cause);
            },
            // selectionControls: MyTextSelectionControls(),
          );
  }

  static bool isProbablyArabic(String s) {
    if (s.length == 0) return false;
    s = s.trim();
    for (int i = 0; i < 2; i++) {
      int c = s.codeUnitAt(i);
      if (c >= 0x0600 && c <= 0x06E0) return true;
      // i += s.characters.length;
    }
    return false;
  }

  static bool isProbablyArabicInLine(String s) {
    if (s.length == 0) return false;
    // print("string:" + s);
    List<String> words = s.trim().split(' ');
    List<ArabicIndex> arabicIndex = [];
    int firstIndex = -1;
    int lastIndex = -1;

    words.forEach((word) {
      for (int i = 0; i < word.length; i++) {
        // print(i);
        // print(word);
        int c = word.codeUnitAt(i);
        if (c >= 0x0600 && c <= 0x06E0) {
          if (firstIndex == -1) {
            firstIndex = i;
          } else {
            lastIndex = i;
          }
          // arabicIndex.add(i);
        } else {
          // not arabic.
          if (firstIndex != -1 && lastIndex != -1)
            arabicIndex.add(ArabicIndex(firstIndex, lastIndex,
                words.sublist(firstIndex, lastIndex).join(' ')));
          firstIndex = -1;
          lastIndex = -1;
        }
        // i += s.characters.length;
      }
    });

    if (arabicIndex.length > 0) {
      print(arabicIndex);
    }

    return false;
  }
}

class ArabicIndex {
  final int start, end;
  final String text;

  ArabicIndex(this.start, this.end, this.text);

  @override
  String toString() {
    print("String: " + text);
    return "start: " + start.toString() + ", end: " + end.toString();
  }
}
