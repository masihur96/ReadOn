
import 'package:read_on/eBook/reading_screen.dart/book_library/model/section.dart';

class Book {
  final String title, assetFolder;
  final List<Section> sections;

  Book({required this.sections, required this.assetFolder, required this.title});

  isLittleBooks() {
    return assetFolder == 'kucuk_kitaplar';
  }
  getHighlightFileName(int index) {
    try {
      if (isLittleBooks()) {
        return assetFolder + "_section_$index";
      } else {
        final bookNameParts = sections[index].fileName.split("-");

        final sectionNumber = bookNameParts.firstWhere((element) {
          return (int.tryParse(element) ?? -1) > 0;
        });
        return assetFolder + "_" + sectionNumber;
      }
    } catch (e) {
      return "$index";
    }
  }
}
