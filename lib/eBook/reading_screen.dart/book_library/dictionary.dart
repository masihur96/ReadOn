class Dictionary {
  static List<Meaning> meanings = [
    Meaning(
        originalText: "mütevazi", meaning: "aaa", baseOffset: 0, endOffset: 10),
  ];
}

class Meaning {
  final String originalText;
  final String meaning;
  final int baseOffset, endOffset;

  Meaning(
      {required this.baseOffset,
      required this.endOffset,
      required this.originalText,
      required this.meaning});
}
