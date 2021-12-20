import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:read_on/eBook/reading_screen.dart/book_library/theme/text_theme.dart';
// import 'package:auto_scrolling_readon/book_library/theme/text_theme.dart';

class NextSectionWidget extends StatelessWidget {
  final String nextSectionTitle;
  final Function onTapNextSection;
  NextSectionWidget(
      {Key? key,
      required this.nextSectionTitle,
      required this.onTapNextSection})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 0.06.sw),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.r),
          color: kBookCardBackgroundColor,
        ),
        child: TextButton(
            onPressed: () async {
              Navigator.pop(context);
              onTapNextSection();
            },
            child: Text(
              nextSectionTitle,
              semanticsLabel: nextSectionTitle,
              style: TextStyle(color: kBookTitleColor),
            )),
      ),
    );
  }
}
