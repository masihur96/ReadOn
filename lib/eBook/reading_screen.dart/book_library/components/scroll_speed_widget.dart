import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:read_on/eBook/reading_screen.dart/book_library/screens/reader/ReaderScreenSettings.dart';


import '../../constants.dart';
import '../../mina_reader.dart';

class ScrollSpeedWidget extends StatelessWidget {
  double value = kScrollSpeedDefaultValue.toDouble();
  final Function onChanged;
  final Function? onTapClose;

  ScrollSpeedWidget({Key? key, required this.onChanged, this.onTapClose})
      : super(key: key);

  static double getScrollSpeed() {
    return double.parse(boxLabels
        .get('scroll_speed', defaultValue: kScrollSpeedDefaultValue)
        .toString());
  }

  @override
  Widget build(BuildContext context) {
    value = getScrollSpeed();
    return Card(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 0.02.sw),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: onTapClose != null
                  ? MainAxisAlignment.spaceBetween
                  : MainAxisAlignment.start,
              children: [
                Text(
                  ReaderScreenSettings.texts.scrollSpeed,
                  textAlign: TextAlign.left,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                if (onTapClose != null)
                  IconButton(
                      icon: Icon(Icons.close), onPressed: () => onTapClose!())
              ],
            ),
            Slider(
              onChanged: (newValue) {
                onChanged(newValue);
                boxLabels.put('scroll_speed', newValue);
              },
              value: value,
              max: 80,
              label: 'Kaydırma Hızı',
            ),
          ],
        ),
      ),
    );
  }
}
