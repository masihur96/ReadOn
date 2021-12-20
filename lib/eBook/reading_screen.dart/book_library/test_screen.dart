import 'package:flutter/material.dart';

class TestScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.info))],
      ),
      body: SafeArea(
        child: SelectableText.rich(
          TextSpan(
              text: List.generate(
                      1000,
                      (index) =>
                          "${index} This is test. This is test. This is test. This is test. \n")
                  .join(' ')),
          onSelectionChanged: (selection, cause) {
            print('changed selection');
            print(selection);
            if (cause == SelectionChangedCause.longPress) {
              print(cause);
            }
          },
          scrollPhysics: AlwaysScrollableScrollPhysics(),
        ),
      ),
    );
  }
}
