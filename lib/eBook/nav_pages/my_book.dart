import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:read_on/controller/public_controller.dart';
import 'package:read_on/eBook/ebook_widgets/amar_audio.dart';
import 'package:read_on/eBook/ebook_widgets/amar_boi.dart';
import 'package:read_on/public_variables/color_variable.dart';
import 'package:read_on/public_variables/style_variable.dart';

class MyBookPage extends StatefulWidget {
  const MyBookPage({Key? key}) : super(key: key);

  @override
  _MyBookPageState createState() => _MyBookPageState();
}

class _MyBookPageState extends State<MyBookPage> {
  @override
  Widget build(BuildContext context) {
    final PublicController publicController = Get.find();
    double size = publicController.size.value;
    return Scaffold(backgroundColor: Colors.white, body: _bodyUI(size));
  }

  Widget _bodyUI(double size) => DefaultTabController(
      length: 2,
      child: Column(
        children: [
          TabBar(
              labelColor: CColor.themeColor,
              labelStyle: Style.buttonTextStyle(
                  size * .05, Colors.white, FontWeight.w500),
              unselectedLabelColor: Colors.black,

              tabs: const [
                Tab(child: Text('ইবুক')),
                Tab(child: Text('অডিও')),
              ]),
          Expanded(
            child: TabBarView(children: [
              AmarBoi(
                bookImage:
                    "https://1.bp.blogspot.com/-QoKjWWKcnC0/XWVnOba6kbI/AAAAAAAAXn4/fwXfr6wBflcYMrUlRSFxfB9K62_5SONAgCLcBGAs/s1600/Ekjon%2BMayaboti%2Bby%2BHumayun%2BAhmed%2B-%2BBangla%2BRomantic%2BNovel%2BPDF%2BBooks.jpg",
                bookName: 'একজন মায়াবতী',
                writerName: 'হুমায়ুন আহমেদ',
                bookCompletePercentage: "৩৩",
              ),
              AmarAudio()
            ]),
          )
        ],
      ));
}
