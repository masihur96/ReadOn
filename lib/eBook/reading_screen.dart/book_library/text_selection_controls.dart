import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:read_on/controller/reading_api_controller.dart';
import 'package:read_on/eBook/reading_screen.dart/book_library/screens/reader/book_reader_screen.dart';

import '../mina_reader.dart';
import 'model/highlight_type.dart';
import 'model/menu_button.dart';

class MyMaterialTextSelectionControls extends MaterialTextSelectionControls {
  // Padding between the toolbar and the anchor.
  static const double kToolbarContentDistanceBelow = 20.0;
  static const double kToolbarContentDistance = 8.0;
  final Function onTapped;
  TextSelection currentTextSelection;

  double iconSize = 100.0;
  // ReadingApiController readingApiController = ReadingApiController();

  static final List<Color> colors = [
    const Color(0xCCDF7270),
    const Color(0xCCDCD56D),
    const Color(0xCCC59462),
    const Color(0xCC5DB963),
    const Color(0xCC757CEA),
  ];

  static var defaultColorButtons = [
    HighlightMenuButton(colorIntValue: colors[0].value, label: ""),
    HighlightMenuButton(colorIntValue: colors[1].value, label: ""),
    HighlightMenuButton(colorIntValue: colors[2].value, label: ""),
    HighlightMenuButton(colorIntValue: colors[3].value, label: ""),
    HighlightMenuButton(colorIntValue: colors[4].value, label: ""),
  ];
  MyMaterialTextSelectionControls({
    required this.onTapped,
    required this.currentTextSelection,
  });

  /// Builder for material-style copy/paste text selection toolbar.

  @override
  Widget buildToolbar(
    BuildContext context,
    Rect globalEditableRegion,
    double textLineHeight,
    Offset selectionMidpoint,
    List<TextSelectionPoint> endpoints,
    TextSelectionDelegate delegate,
    ClipboardStatusNotifier clipboardStatus,
    Offset? lastSecondaryTapDownPosition,
  ) {
    print("menu");
    print('endpoints');

    if (endpoints.length == 1) return const SizedBox.shrink();

    final TextSelectionPoint startTextSelectionPoint = endpoints[0];
    final TextSelectionPoint endTextSelectionPoint =
        endpoints.length > 1 ? endpoints[1] : endpoints[0];
    final Offset anchorAbove = Offset(
        globalEditableRegion.left + selectionMidpoint.dx,
        globalEditableRegion.top +
            startTextSelectionPoint.point.dy -
            textLineHeight -
            kToolbarContentDistance);
    final Offset anchorBelow = Offset(
      globalEditableRegion.left + selectionMidpoint.dx,
      globalEditableRegion.top +
          endTextSelectionPoint.point.dy +
          kToolbarContentDistanceBelow,
    );

    print("building again");
    return buildTextSelectionToolbar(anchorAbove, anchorBelow, 'note');

    // return MyTextSelectionToolbar(
    //   anchorAbove: anchorAbove,
    //   anchorBelow: anchorBelow,
    //   clipboardStatus: clipboardStatus,
    //   handleCopy: canCopy(delegate) && handleCopy != null
    //       ? () => handleCopy(delegate, clipboardStatus)
    //       : null,
    //   handleCustomButton: () {
    //     delegate.textEditingValue = delegate.textEditingValue.copyWith(
    //       selection: TextSelection.collapsed(
    //         offset: delegate.textEditingValue.selection.baseOffset,
    //       ),
    //     );
    //     delegate.hideToolbar();
    //   },
    //   handleCut: canCut(delegate) && handleCut != null
    //       ? () => handleCut(delegate)
    //       : null,
    //   handlePaste: canPaste(delegate) && handlePaste != null
    //       ? () => handlePaste(delegate)
    //       : null,
    //   handleSelectAll: canSelectAll(delegate) && handleSelectAll != null
    //       ? () => handleSelectAll(delegate)
    //       : null,
    // );
  }

  buildMenuItems(String note) {
    return highlightButtons.map((c) {
      if (c.type == highlight_type.color) {
        return Padding(
          padding: const EdgeInsets.all(4.0),
          child: InkWell(
            onTap: () {
              this.onTapped(c);

              // Get.back();
            },
            child: Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: c.color,
                shape: BoxShape.circle,
              ),
              child: FittedBox(child: Text(c.label == "" ? "" : c.label)),
            ),
          ),
        );
      } else {
        if (c.type == highlight_type.bold) {
          return InkWell(
            onTap: () {
              this.onTapped(c);
            },
            child: Icon(
              Icons.format_bold,
              size: iconSize,
            ),
          );
        }
        if (c.type == highlight_type.italic) {
          return Row(
            children: [
              InkWell(
                  onTap: () {
                    onTapped(c);
                    ReadingApiController readingApiController =
                        ReadingApiController();
                    readingApiController.updateSaveValue('save');
                  },
                  child: Icon(
                    Icons.save,
                    size: iconSize * .7,
                  )),
              InkWell(
                  onTap: () {
                    onTapped(c);
                    ReadingApiController readingApiController =
                        ReadingApiController();

                    readingApiController.updateSaveValue('note');
                  },
                  child: Icon(
                    Icons.note_add_outlined,
                    size: iconSize * .7,
                  )),
            ],
          );
        } else {
          return InkWell(
              onTap: () {
                this.onTapped(c);
              },
              child: Icon(
                Icons.format_underline,
                size: iconSize,
              ));
        }
      }
    });
  }

  List<HighlightMenuButton> highlightButtons = [
    ...loadHighlightColorButtons(),
    HighlightMenuButton(type: highlight_type.bold),
    HighlightMenuButton(type: highlight_type.underline),
    HighlightMenuButton(type: highlight_type.italic),
  ];

  Widget buildTextSelectionToolbar(
      Offset anchorAbove, Offset anchorBelow, String note) {
    return TextSelectionToolbar(
        anchorAbove: anchorAbove,
        anchorBelow: anchorBelow,
        children: [
          FittedBox(
            // widthFactor: 0.6,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ...buildMenuItems(note),
                    ],
                  ),
                  // Row(
                  //   children: [
                  //     Text("test"),
                  //     Text("test"),
                  //   ],
                  // ),
                ],
              ),
            ),
          )
        ]);
  }

  static List<HighlightMenuButton> loadHighlightColorButtons() {
    final buttons = boxLabels.get('labels', defaultValue: defaultColorButtons);

    return List<HighlightMenuButton>.from(buttons);
  }

  static saveHighlightColorButtons(List<HighlightMenuButton> buttons) async {
    await boxLabels.put('labels', buttons);
  }

  static deleteHighlightColorButtons() async {
    await boxLabels.delete('labels');
  }
}
