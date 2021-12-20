library mina_reader;
import 'package:hive_flutter/hive_flutter.dart';
import 'book_library/model/highlight.dart';
import 'book_library/model/highlight_type.dart';
import 'book_library/model/menu_button.dart';
import 'book_library/screens/reader/ReaderScreenSettings.dart';
import 'book_library/screens/reader/reading_settings_texts.dart';
import 'book_library/theme/text_theme.dart';


dynamic box;
dynamic boxLastLocation;
dynamic boxLabels;
dynamic boxLastReadedSectionId;
dynamic boxSettings;

class MinaReader {
  static initReader({
    String? bookListTitleFontFamily,
    String? readerBodyFontFamily,
    ReadingSettingsTexts? readingSettingsTexts,
  }) async {
    ReaderScreenSettings.texts = readingSettingsTexts ?? ReadingSettingsTexts();

    if (bookListTitleFontFamily != null) {
      bookNameTextStyle =
          bookNameTextStyle.copyWith(fontFamily: bookListTitleFontFamily);
    }
    if (readerBodyFontFamily != null) {
      readerBaseTextStyle =
          readerBaseTextStyle.copyWith(fontFamily: readerBodyFontFamily);
    }

    await initHive();
  }

  static Future initHive() async {
    Hive.registerAdapter(MenuButtonAdapter());
    Hive.registerAdapter(highlighttypeAdapter());
    Hive.registerAdapter(HighlightAdapter());

    await Hive.initFlutter();
    box = await Hive.openBox('library');
    boxLastLocation = await Hive.openBox('library_last_location');
    boxLastReadedSectionId =
        await Hive.openBox('library_last_readed_section_id');
    boxLabels = await Hive.openBox('labels');
    boxSettings = await Hive.openBox('settings');
  }
}
