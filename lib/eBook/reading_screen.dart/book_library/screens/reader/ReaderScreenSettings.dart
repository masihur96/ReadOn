// ignore: file_names
// ignore_for_file: file_names

import 'package:flutter/material.dart';
// import 'package:auto_scrolling_readon/book_library/components/scroll_speed_widget.dart';
// import 'package:auto_scrolling_readon/book_library/model/menu_button.dart';
// import 'package:auto_scrolling_readon/book_library/screens/reader/reading_settings_texts.dart';
// import 'package:auto_scrolling_readon/book_library/text_selection_controls.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:read_on/eBook/reading_screen.dart/book_library/components/scroll_speed_widget.dart';
import 'package:read_on/eBook/reading_screen.dart/book_library/model/menu_button.dart';
// import 'package:auto_scrolling_readon/book_library/theme/text_theme.dart';
import 'package:read_on/eBook/reading_screen.dart/book_library/screens/reader/reading_settings_texts.dart';
import 'package:read_on/eBook/reading_screen.dart/book_library/text_selection_controls.dart';
import 'package:read_on/eBook/reading_screen.dart/book_library/theme/text_theme.dart';

class ReaderScreenSettings extends StatefulWidget {
  ReaderScreenSettings({Key? key}) : super(key: key);

  static late final ReadingSettingsTexts texts;

  @override
  _ReaderScreenSettingsState createState() => _ReaderScreenSettingsState();
}

class _ReaderScreenSettingsState extends State<ReaderScreenSettings> {
  String sectionName = " ";

  String highlightFileName = "";

  late List<HighlightMenuButton> buttons;

  @override
  void initState() {
    buttons = MyMaterialTextSelectionControls.loadHighlightColorButtons();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconTheme.of(context).copyWith(color: kBookTitleColor),
        backgroundColor: kBookCardBackgroundColor,
        title: FittedBox(
            child: Text(
          ReaderScreenSettings.texts.readingScreenSettingsTitle,
          style: TextStyle(color: kBookTitleColor),
        )),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(0.02.sw),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ...labels(),
              ScrollSpeedWidget(onChanged: (newValue) {
                setState(() {});
              }),
              Card(
                child: ListTile(
                  leading: Icon(Icons.refresh),
                  title: Text(
                      ReaderScreenSettings.texts.resetLabelNamesToColorNames),
                  onTap: () async {
                    for (int i = 0; i < buttons.length; i++) {
                      final butt = MyMaterialTextSelectionControls
                          .defaultColorButtons[i];

                      buttons[i].label = butt.label;
                    }
                    //
                    buttons =
                        MyMaterialTextSelectionControls.defaultColorButtons;

                    // await MyMaterialTextSelectionControls
                    //     .saveHighlightColorButtons(buttons);

                    await MyMaterialTextSelectionControls
                        .deleteHighlightColorButtons();

                    setState(() {});
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  labels() {
    return [
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Text(
          ReaderScreenSettings.texts.labelNames,
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
      ),
      Column(
        children: buildColorTiles(),
      ),
    ];
  }

  List<Widget> buildColorTiles() {
    return buttons.map((HighlightMenuButton button) {
      return Container(
        color: button.color,
        child: ListTile(
          title: Text(button.label),
          onTap: () async {
            final TextEditingController _controller = TextEditingController();
            _controller.text = button.label;

            showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Text(ReaderScreenSettings.texts.changeColorLabel),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextFormField(
                          controller: _controller,
                          autofocus: true,
                        ),
                      ],
                    ),
                    actions: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text(ReaderScreenSettings.texts.cancel),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              button.label = _controller.text;
                              MyMaterialTextSelectionControls
                                  .saveHighlightColorButtons(buttons);
                              Navigator.pop(context);
                              setState(() {});
                            },
                            child: Text(ReaderScreenSettings.texts.ok),
                          )
                        ],
                      ),
                    ],
                  );
                });
          },
          trailing: Icon(Icons.edit),
        ),
      );
    }).toList();
  }
}
