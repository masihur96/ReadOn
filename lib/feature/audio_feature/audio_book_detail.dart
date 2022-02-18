import 'dart:ui';
import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:read_on/controller/public_controller.dart';
import 'package:read_on/feature/audio_feature/audio_screen.dart';
import 'package:read_on/feature/controller/audio_api_controller.dart';
import 'package:read_on/feature/custom_appbar.dart';

late AudioPlayerHandler audioHandler;

class AudioBookDetail extends StatefulWidget {
  const AudioBookDetail({Key? key}) : super(key: key);

  @override
  _AudioBookDetailState createState() => _AudioBookDetailState();
}

class _AudioBookDetailState extends State<AudioBookDetail> {
  final GlobalKey<ScaffoldState> _scafdKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final PublicController publicController = Get.find();
    final AudioApiController audioApiController = Get.find();
    double size = publicController.size.value;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: PreferredSize(
            preferredSize: AppBar().preferredSize,
            child: _pageAppBar(size, publicController)),
        body: _bodyUI(size, audioApiController),
      ),
    );
  }

  Widget _bodyUI(double size, AudioApiController audioApiController) =>
      ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                itemCount: audioApiController.audioMp3.length,
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => AudioScreen(
                                    audioLink:
                                        audioApiController.audioMp3[index],
                                  )));
                    },
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                  '${audioApiController.audioChapterName[index]}'),
                              Row(
                                children: const [
                                  Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Center(
                                        child: Icon(
                                      Icons.play_circle_fill,
                                      color: Colors.red,
                                    )),
                                  ),
                                  Center(
                                      child: Icon(
                                    Icons.lock_outlined,
                                    color: Colors.grey,
                                  )),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                }),
          ),
        ],
      );

  /// app bar
  CustomAppBar _pageAppBar(double size, PublicController publicController) =>
      CustomAppBar(
        title: "Audio Book Details",
        iconData: LineAwesomeIcons.bars,
        action: [
          Icon(
            Icons.search_outlined,
            color: Colors.white,
            size: publicController.size.value * .08,
          ),
        ],
        scaffoldKey: _scafdKey,
      );

  /// book detail option
  Row _bookDetailOption(double size, String title, String value) => Row(
        children: [
          Text('title : ',
              style: TextStyle(
                  fontSize: size * .045,
                  color: Colors.white,
                  fontWeight: FontWeight.w500)),
          Expanded(
            child: Text(value,
                style: TextStyle(
                    fontSize: size * .045,
                    color: Colors.white,
                    fontWeight: FontWeight.w500)),
          ),
        ],
      );
}
