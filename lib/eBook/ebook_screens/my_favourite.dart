import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:read_on/controller/public_controller.dart';
import 'package:read_on/eBook/ebook_widgets/favourite_audio.dart';
import 'package:read_on/eBook/ebook_widgets/favourite_book.dart';
import 'package:read_on/public_variables/color_variable.dart';
import 'package:read_on/public_variables/style_variable.dart';
import '../../widgets/custom_appbar.dart';

class MyFavourite extends StatefulWidget {
  @override
  _MyFavouriteState createState() => _MyFavouriteState();
}

class _MyFavouriteState extends State<MyFavourite> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    final PublicController publicController = Get.find();
    double size = publicController.size.value;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: PreferredSize(
            preferredSize: AppBar().preferredSize,
            child: _pageAppBar(publicController)),
        body: _bodyUI(size),
      ),
    );
  }


  /// page body
  Widget _bodyUI(double size) => DefaultTabController(
      length: 2,
      child: Column(
        children: [
          Container(
            color: Colors.yellow.shade100,
            child: TabBar(
                labelColor: Colors.white,
                labelStyle: Style.bodyTextStyle(
                    size * .05, Colors.white, FontWeight.w500),
                unselectedLabelColor: CColor.themeColor,
                indicator: BoxDecoration(
                    color: const Color(0xff2AAA8A),
                  borderRadius: BorderRadius.circular(size*.03)
                ),
                tabs: const [
                  Tab(child: Text('আমার বই')),
                  Tab(child: Text('আমার অডিও')),
                ]),
          ),
          Expanded(
            child: TabBarView(
                children: [
                  FavouriteBook(),
                  FavouriteAudio()
            ]),
          )
        ],
      )
  );

  /// app bar
  CustomAppBar _pageAppBar(PublicController publicController) => CustomAppBar(
    title: "আমার পছন্দ",
    iconData: LineAwesomeIcons.bars,
    action: [
      Icon(
        Icons.search_outlined,
        color: Colors.white,
        size: publicController.size.value * .08,
      ),
    ],
    scaffoldKey: _scaffoldKey,
  );
}
