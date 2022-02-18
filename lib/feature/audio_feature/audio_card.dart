import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:miniplayer/miniplayer.dart';
import 'package:read_on/controller/public_controller.dart';
import 'package:read_on/feature/audio_feature/audio_book_detail.dart';
import 'package:read_on/feature/audio_feature/audio_book_list_page.dart';

import 'package:timeago/timeago.dart' as timeago;

class AudioCard extends StatelessWidget {
  final Audio? audio;
  final bool hasPadding;
  final VoidCallback? onTap;

  const AudioCard({
    Key? key,
    required this.audio,
    this.hasPadding = false,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final PublicController publicController = Get.find();
    double size = publicController.size.value;

    return GestureDetector(
      onTap: () {
        context.read(selectedVideoProvider).state = audio;
        context
            .read(miniPlayerControllerProvider)
            .state
            .animateToHeight(state: PanelState.MAX);
        if (onTap != null) onTap!();
        Navigator.push(context,
            MaterialPageRoute(builder: (_) => const AudioBookDetail()));
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          height: size * .4,
          width: size * .3,
          color: Colors.grey,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Center(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey.shade800,
                    shape: BoxShape.circle,
                  ),
                  padding: EdgeInsets.all(size * .02),
                  child:
                      const Icon(Icons.play_arrow_rounded, color: Colors.white),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class Audio {
  final String id;

  final String title;
  final String thumbnailUrl;
  final String duration;
  final DateTime timestamp;
  final String viewCount;
  final String likes;
  final String dislikes;

  const Audio({
    required this.id,
    required this.title,
    required this.thumbnailUrl,
    required this.duration,
    required this.timestamp,
    required this.viewCount,
    required this.likes,
    required this.dislikes,
  });
}
