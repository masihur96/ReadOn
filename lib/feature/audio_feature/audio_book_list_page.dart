import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:miniplayer/miniplayer.dart';
import 'package:read_on/controller/public_controller.dart';
import 'package:read_on/feature/audio_feature/audio_book_detail.dart';
import 'package:read_on/feature/audio_feature/audio_card.dart';

import 'package:read_on/feature/custom_appbar.dart';

final selectedVideoProvider = StateProvider<Audio?>((ref) => null);

final miniPlayerControllerProvider =
    StateProvider.autoDispose<MiniplayerController>(
  (ref) => MiniplayerController(),
);

class AudioBookListPage extends StatefulWidget {
  const AudioBookListPage({Key? key}) : super(key: key);

  @override
  _AudioBookListPageState createState() => _AudioBookListPageState();
}

class _AudioBookListPageState extends State<AudioBookListPage> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final PublicController publicController = Get.find();
    double size = publicController.size.value;
    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.white,
      key: scaffoldKey,
      appBar: PreferredSize(
          preferredSize: AppBar().preferredSize,
          child: _pageAppBar(size, publicController)),
      body: GridView.builder(
        itemCount: 3,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 0.0,
            childAspectRatio: 3 / 5,
            mainAxisSpacing: 0.0),
        itemBuilder: (BuildContext context, int index) {
          final audioInfo = audios[index];
          return AudioCard(audio: audioInfo);
        },
      ),
    ));
  }

  CustomAppBar _pageAppBar(double size, PublicController publicController) =>
      CustomAppBar(
        title: "Audio Book List",
        iconData: LineAwesomeIcons.bars,
        action: [
          Icon(
            Icons.search_outlined,
            color: Colors.white,
            size: publicController.size.value * .08,
          ),
          SizedBox(width: size * .04),
          GestureDetector(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (_) => const AudioBookDetail()));
            },
            child: Container(
              width: size * .085,
              height: size * .085,
              alignment: Alignment.center,
              child: Stack(
                children: [
                  Icon(
                    LineAwesomeIcons.shopping_cart,
                    color: Colors.white,
                    size: size * .085,
                  ),
                  Positioned(
                    top: 0,
                    right: 0,
                    child: Container(
                      width: size * .035,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                      ),

                      /// notification count
                      child: Center(
                        child: Text(
                          '2',
                          style: TextStyle(
                              color: Colors.red,
                              fontSize: size * .03,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
        scaffoldKey: _scaffoldKey,
      );
}

final List<Audio> audios = [
  Audio(
    id: 'x606y4QWrxo',
    title: 'Flutter Clubhouse Clone UI Tutorial | Apps From Scratch',
    thumbnailUrl: 'https://i.ytimg.com/vi/x606y4QWrxo/0.jpg',
    duration: '8:20',
    timestamp: DateTime(2021, 3, 20),
    viewCount: '10K',
    likes: '958',
    dislikes: '4',
  ),
  Audio(
    id: 'x606y4QWrxo',
    title: 'Flutter Clubhouse Clone UI Tutorial | Apps From Scratch',
    thumbnailUrl: 'https://i.ytimg.com/vi/x606y4QWrxo/0.jpg',
    duration: '8:20',
    timestamp: DateTime(2021, 3, 20),
    viewCount: '10K',
    likes: '958',
    dislikes: '4',
  ),
  Audio(
    id: 'vrPk6LB9bjo',
    title:
        'Build Flutter Apps Fast with Riverpod, Firebase, Hooks, and Freezed Architecture',
    thumbnailUrl: 'https://i.ytimg.com/vi/vrPk6LB9bjo/0.jpg',
    duration: '22:06',
    timestamp: DateTime(2021, 2, 26),
    viewCount: '8K',
    likes: '485',
    dislikes: '8',
  ),
];
