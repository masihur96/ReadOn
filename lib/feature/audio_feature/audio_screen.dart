import 'dart:ui';
import 'package:audio_service/audio_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:audio_session/audio_session.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:miniplayer/miniplayer.dart';
import 'package:read_on/feature/audio_feature/audio_book_detail.dart';
import 'package:read_on/feature/audio_feature/audio_book_list_page.dart';
import 'package:read_on/feature/audio_feature/common.dart';
import 'package:read_on/feature/controller/audio_api_controller.dart';
import 'package:read_on/main.dart';

import 'package:rxdart/rxdart.dart';

class AudioScreen extends StatefulWidget {
  String? audioLink;

  AudioScreen({Key? key, required this.audioLink}) : super(key: key);
  @override
  _AudioScreenState createState() => _AudioScreenState();
}

class _AudioScreenState extends State<AudioScreen> {
  ScrollController? _scrollController;

  List<String> audioBookUrl = [
    "https://s3.amazonaws.com/scifri-episodes/scifri20181123-episode.mp3",
    "https://www.soundhelix.com/examples/mp3/SoundHelix-Song-1.mp3",
    "https://www.soundhelix.com/examples/mp3/SoundHelix-Song-2.mp3",
    "https://www.soundhelix.com/examples/mp3/SoundHelix-Song-6.mp3",
    "https://www.soundhelix.com/examples/mp3/SoundHelix-Song-3.mp3"
  ];
  static double _playerMinHeight = 100.0;
  // int? index = 0;
  // int? i;
  //
  // Duration? duration;
  // @override
  // void initState() {
  //   super.initState();
  //
  //   //  WidgetsBinding.instance?.addObserver(this);
  //   // SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
  //   //   statusBarColor: Colors.black,
  //   // ));
  //   // i = audioBookUrl.length;
  //   // _init(index!);
  // }
  //
  // int? remainingMunuit;
  // int? remainingSeconds;

  // Future<void> _init(int index) async {
  //   // setState(() {
  //   //   _playerMinHeight = 500;
  //   // });
  //   // Inform the operating system of our app's audio attributes etc.
  //   // We pick a reasonable default for an app that plays speech.
  //   final session = await AudioSession.instance;
  //   await session.configure(const AudioSessionConfiguration.speech());
  //   // Listen to errors during playback.
  //   _player.playbackEventStream.listen((event) {},
  //       onError: (Object e, StackTrace stackTrace) {
  //     print('A stream error occurred: $e');
  //   });
  //   // Try to load audio from a source and catch any errors.
  //   try {
  //     duration = await _player.setUrl(audioBookUrl[index]);
  //     await _player
  //         .setAudioSource(AudioSource.uri(Uri.parse(audioBookUrl[index])));
  //     setState(() async {});
  //   } catch (e) {
  //     print("Error loading audio source: $e");
  //   }
  // }
  //
  // @override
  // void dispose() {
  //   //   WidgetsBinding.instance?.removeObserver(this);
  //
  //   _player.dispose();
  //   super.dispose();
  // }
  //
  // @override
  // void didChangeAppLifecycleState(AppLifecycleState state) {
  //   if (state == AppLifecycleState.paused) {
  //     _player.stop();
  //   }
  // }

  // / Collects the data useful for displaying in a seek bar, using a handy
  // / feature of rx_dart to combine the 3 streams of interest into one.
  // Stream<PositionData> get _positionDataStream =>
  //     Rx.combineLatest3<Duration, Duration, Duration?, PositionData>(
  //         _player.positionStream,
  //         _player.bufferedPositionStream,
  //         _player.durationStream,
  //         (position, bufferedPosition, duration) => PositionData(
  //             position, bufferedPosition, duration ?? Duration.zero));

  final int _selectedIndex = 0;

  final _screens = [
    AudioBookListPage(),
  ];
  int counter = 0;

  customInit(AudioApiController audioApiController) async {
    audioHandler = await AudioService.init(
      builder: () => AudioPlayerHandlerImpl(),
      config: const AudioServiceConfig(
        androidNotificationChannelId: 'com.ryanheise.myapp.channel.audio',
        androidNotificationChannelName: 'Audio playback',
        androidNotificationOngoing: true,
      ),
    );
    setState(() {
      counter++;
    });
  }

  Stream<Duration> get _bufferedPositionStream => audioHandler.playbackState
      .map((state) => state.bufferedPosition)
      .distinct();
  Stream<Duration?> get _durationStream =>
      audioHandler.mediaItem.map((item) => item?.duration).distinct();
  Stream<PositionData> get _positionDataStream =>
      Rx.combineLatest3<Duration, Duration, Duration?, PositionData>(
          AudioService.position,
          _bufferedPositionStream,
          _durationStream,
          (position, bufferedPosition, duration) => PositionData(
              position, bufferedPosition, duration ?? Duration.zero));

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final AudioApiController audioApiController = Get.find();
    if (counter == 0) {
      customInit(audioApiController);
    }

    return Consumer(
      builder: (context, watch, _) {
        final selectedVideo = watch(selectedVideoProvider).state;
        final miniPlayerController = watch(miniPlayerControllerProvider).state;
        return Stack(
          children: _screens
              .asMap()
              .map((i, screen) => MapEntry(
                    i,
                    Offstage(
                      offstage: _selectedIndex != i,
                      child: screen,
                    ),
                  ))
              .values
              .toList()
            ..add(
              Offstage(
                offstage: selectedVideo == null,
                child: Miniplayer(
                  controller: miniPlayerController,
                  minHeight: 110,
                  maxHeight: MediaQuery.of(context).size.height,
                  builder: (height, percentage) {
                    if (selectedVideo == null) {
                      return const SizedBox.shrink();
                    }
                    if (height <= _playerMinHeight + 50.0) {
                      return Container(
                        color: Theme.of(context).scaffoldBackgroundColor,
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Flexible(
                                    child: Text(
                                      'একজন মায়াবতী',
                                      overflow: TextOverflow.ellipsis,
                                      style: Theme.of(context)
                                          .textTheme
                                          .caption!
                                          .copyWith(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w500,
                                          ),
                                    ),
                                  ),
                                  Flexible(
                                    child: Text(
                                      'হুমায়ুন আহমেদ',
                                      overflow: TextOverflow.ellipsis,
                                      style: Theme.of(context)
                                          .textTheme
                                          .caption!
                                          .copyWith(
                                              fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Row(
                              children: [
                                // Image.network(
                                //   'https://1.bp.blogspot.com/-QoKjWWKcnC0/XWVnOba6kbI/AAAAAAAAXn4/fwXfr6wBflcYMrUlRSFxfB9K62_5SONAgCLcBGAs/s1600/Ekjon%2BMayaboti%2Bby%2BHumayun%2BAhmed%2B-%2BBangla%2BRomantic%2BNovel%2BPDF%2BBooks.jpg',
                                //   height: _playerMinHeight - 40.0,
                                //   width: 100.0,
                                //   fit: BoxFit.fill,
                                // ),

                                StreamBuilder<bool>(
                                  stream: audioHandler.playbackState
                                      .map((state) => state.playing)
                                      .distinct(),
                                  builder: (context, snapshot) {
                                    final playing = snapshot.data ?? false;
                                    return Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        // _button(Icons.fast_rewind,
                                        //     _audioHandler.rewind),
                                        // if (playing)
                                        ControlButtons(audioHandler),
                                        // else
                                        //   ControlButtons(_audioHandler)
                                        // _button(Icons.stop, _audioHandler.stop),
                                        // _button(Icons.fast_forward,
                                        //     _audioHandler.fastForward),
                                        SizedBox(
                                          width: size.width * .1,
                                        ),
                                        IconButton(
                                          icon: const Icon(Icons.close),
                                          onPressed: () {
                                            context
                                                .read(selectedVideoProvider)
                                                .state = null;
                                          },
                                        ),
                                      ],
                                    );
                                  },
                                ),
                              ],
                            ),
                            // StreamBuilder<MediaState>(
                            //   stream: _mediaStateStream,
                            //   builder: (context, snapshot) {
                            //     final mediaState = snapshot.data;
                            //     return SeekBar(
                            //       duration: mediaState?.mediaItem?.duration ??
                            //           Duration.zero,
                            //       position:
                            //           mediaState?.position ?? Duration.zero,
                            //       onChangeEnd: (newPosition) {
                            //         _audioHandler.seek(newPosition);
                            //       },
                            //     );
                            //   },
                            // ),
                          ],
                        ),
                      );
                    }
                    return GestureDetector(
                      onTap: () {
                        context
                            .read(miniPlayerControllerProvider)
                            .state
                            .animateToHeight(state: PanelState.MAX);
                      },
                      child: Container(
                        color: Colors.white,
                        child: SingleChildScrollView(
                          controller: _scrollController,
                          child: Container(
                            height: size.height * .95,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Stack(
                                  overflow: Overflow.visible,
                                  children: [
                                    ClipPath(
                                      clipper: OvalBottomBorderClipper(),
                                      child: Container(
                                          width: size.width,
                                          height: size.width * .8,
                                          decoration: const BoxDecoration(
                                            shape: BoxShape.rectangle,
                                            // color: Colors.grey,
                                            // border: Border.all(color: Colors.blueGrey, width: 1.5),
                                            image: DecorationImage(
                                                fit: BoxFit.fill,
                                                image: NetworkImage(
                                                    "https://1.bp.blogspot.com/-QoKjWWKcnC0/XWVnOba6kbI/AAAAAAAAXn4/fwXfr6wBflcYMrUlRSFxfB9K62_5SONAgCLcBGAs/s1600/Ekjon%2BMayaboti%2Bby%2BHumayun%2BAhmed%2B-%2BBangla%2BRomantic%2BNovel%2BPDF%2BBooks.jpg")),
                                          ),
                                          child: Container(
                                            color: Colors.grey,
                                          )
                                          // BackdropFilter(
                                          //   filter: ImageFilter.blur(
                                          //       sigmaX: 5.0, sigmaY: 5.0),
                                          //   child: Container(
                                          //     decoration: BoxDecoration(
                                          //         color: Colors.white
                                          //             .withOpacity(0.0)),
                                          //   ),
                                          // ),
                                          ),
                                    ),

                                    /// book image
                                    Positioned(
                                      bottom: -100,
                                      left: size.width / 3.5,
                                      child: Column(
                                        children: [
                                          Card(
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(4.0),
                                            ),
                                            margin: EdgeInsets.zero,
                                            child: Container(
                                              width: size.width * .4,
                                              height: size.width * .6,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(4.0),
                                              ),
                                              child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          4.0),
                                                  child: Image.network(
                                                    "https://1.bp.blogspot.com/-QoKjWWKcnC0/XWVnOba6kbI/AAAAAAAAXn4/fwXfr6wBflcYMrUlRSFxfB9K62_5SONAgCLcBGAs/s1600/Ekjon%2BMayaboti%2Bby%2BHumayun%2BAhmed%2B-%2BBangla%2BRomantic%2BNovel%2BPDF%2BBooks.jpg",
                                                    fit: BoxFit.cover,
                                                  )),
                                            ),
                                          ),
                                          SizedBox(
                                            height: size.width * .03,
                                          ),
                                          InkWell(
                                            onTap: () {
                                              //  play();
                                            },
                                            child: const Text(
                                              'একজন মায়াবতী',
                                              style: TextStyle(
                                                  fontSize: 25,
                                                  color: Colors.grey),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),

                                    Positioned(
                                        left: size.width * .1,
                                        top: size.width * .1,
                                        child: InkWell(
                                            onTap: () {
                                              context
                                                  .read(
                                                      miniPlayerControllerProvider)
                                                  .state
                                                  .animateToHeight(
                                                      state: PanelState.MIN);
                                            },
                                            child: Image.asset(
                                              'assets/down_arrow.png',
                                              height: 30,
                                              width: 30,
                                            ))),
                                  ],
                                ),

                                //with List
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    ControlButtons(audioHandler),
                                    // A seek bar.
                                    StreamBuilder<PositionData>(
                                      stream: _positionDataStream,
                                      builder: (context, snapshot) {
                                        final positionData = snapshot.data ??
                                            PositionData(Duration.zero,
                                                Duration.zero, Duration.zero);
                                        return SeekBar(
                                          duration: positionData.duration,
                                          position: positionData.position,
                                          onChangeEnd: (newPosition) {
                                            audioHandler.seek(newPosition);
                                          },
                                        );
                                      },
                                    ),
                                    InkWell(
                                      onTap: () {
                                        _musicListDialog(context);
                                      },
                                      child: Image.asset(
                                        'assets/audio_content_list_icon.png',
                                        height: size.width * .05,
                                        width: size.width * .05,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
        );
      },
    );
  }

  Future<void> _musicListDialog(BuildContext context) async {
    Size size = MediaQuery.of(context).size;
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Colors.white.withOpacity(.9),
            actions: <Widget>[
              Column(
                children: [
                  Container(
                      width: size.width,
                      color: Colors.grey.shade200,
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          'একজন মায়াবতী',
                          style: TextStyle(fontSize: 25, color: Colors.grey),
                        ),
                      )),

                  // Repeat/shuffle controls
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      StreamBuilder<AudioServiceRepeatMode>(
                        stream: audioHandler.playbackState
                            .map((state) => state.repeatMode)
                            .distinct(),
                        builder: (context, snapshot) {
                          final repeatMode =
                              snapshot.data ?? AudioServiceRepeatMode.none;
                          const icons = [
                            Icon(Icons.repeat, color: Colors.grey),
                            Icon(Icons.repeat, color: Colors.orange),
                            Icon(Icons.repeat_one, color: Colors.orange),
                          ];
                          const cycleModes = [
                            AudioServiceRepeatMode.none,
                            AudioServiceRepeatMode.all,
                            AudioServiceRepeatMode.one,
                          ];
                          final index = cycleModes.indexOf(repeatMode);
                          return IconButton(
                            icon: icons[index],
                            onPressed: () {
                              audioHandler.setRepeatMode(cycleModes[
                                  (cycleModes.indexOf(repeatMode) + 1) %
                                      cycleModes.length]);
                            },
                          );
                        },
                      ),
                      Text(
                        "Playlist",
                        style: Theme.of(context).textTheme.headline6,
                        textAlign: TextAlign.center,
                      ),
                      StreamBuilder<bool>(
                        stream: audioHandler.playbackState
                            .map((state) =>
                                state.shuffleMode ==
                                AudioServiceShuffleMode.all)
                            .distinct(),
                        builder: (context, snapshot) {
                          final shuffleModeEnabled = snapshot.data ?? false;
                          return IconButton(
                            icon: shuffleModeEnabled
                                ? const Icon(Icons.shuffle,
                                    color: Colors.orange)
                                : const Icon(Icons.shuffle, color: Colors.grey),
                            onPressed: () async {
                              final enable = !shuffleModeEnabled;
                              await audioHandler.setShuffleMode(enable
                                  ? AudioServiceShuffleMode.all
                                  : AudioServiceShuffleMode.none);
                            },
                          );
                        },
                      ),
                    ],
                  ),
                  //  Playlist
                  Container(
                    height: size.height * .7,
                    width: size.width * .8,
                    child: StreamBuilder<QueueState>(
                      stream: audioHandler.queueState,
                      builder: (context, snapshot) {
                        final queueState = snapshot.data ?? QueueState.empty;
                        final queue = queueState.queue;
                        return ReorderableListView(
                          shrinkWrap: true,
                          onReorder: (int oldIndex, int newIndex) {
                            if (oldIndex < newIndex) newIndex--;
                            audioHandler.moveQueueItem(oldIndex, newIndex);
                          },
                          children: [
                            for (var i = 0; i < queue.length; i++)
                              Dismissible(
                                key: ValueKey(queue[i].id),
                                background: Container(
                                  color: Colors.redAccent,
                                  alignment: Alignment.centerRight,
                                  child: const Padding(
                                    padding: EdgeInsets.only(right: 8.0),
                                    child:
                                        Icon(Icons.delete, color: Colors.white),
                                  ),
                                ),
                                onDismissed: (dismissDirection) {
                                  audioHandler.removeQueueItemAt(i);
                                },
                                child: Material(
                                  color: i == queueState.queueIndex
                                      ? Colors.grey.shade300
                                      : null,
                                  child: ListTile(
                                      title: Text(queue[i].title),
                                      trailing: i == queueState.queueIndex
                                          ? Image.asset(
                                              'assets/music_icon.gif',
                                              height: size.width * .05,
                                              width: size.width * .05,
                                            )
                                          : Image.asset(
                                              'assets/music_play_icon.png',
                                              height: size.width * .05,
                                              width: size.width * .05,
                                            ),
                                      onTap: () {
                                        audioHandler.skipToQueueItem(i);
                                        Navigator.pop(context);
                                      }),
                                ),
                              ),
                          ],
                        );
                      },
                    ),
                  ),
                ],
              )
            ],
          );
        });
  }
}

class ControlButtons extends StatelessWidget {
  final AudioPlayerHandler _audioHandler;

  const ControlButtons(this._audioHandler, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          icon: const Icon(Icons.volume_up),
          onPressed: () {
            showSliderDialog(
              context: context,
              title: "Adjust volume",
              divisions: 10,
              min: 0.0,
              max: 1.0,
              value: _audioHandler.volume.value,
              stream: _audioHandler.volume,
              onChanged: _audioHandler.setVolume,
            );
          },
        ),

        SizedBox(
          width: size.width * .05,
        ),
        // StreamBuilder<QueueState>(
        //   stream: audioHandler.queueState,
        //   builder: (context, snapshot) {
        //     final queueState = snapshot.data ?? QueueState.empty;
        //     return IconButton(
        //       icon: const Icon(Icons.skip_previous),
        //       onPressed:
        //           queueState.hasPrevious ? audioHandler.skipToPrevious : null,
        //     );
        //   },
        // ),
        buttonWidget('assets/five_second_prev_icon.png', _audioHandler.rewind),
        SizedBox(
          width: size.width * .05,
        ),
        StreamBuilder<PlaybackState>(
          stream: _audioHandler.playbackState,
          builder: (context, snapshot) {
            final playbackState = snapshot.data;
            final processingState = playbackState?.processingState;
            final playing = playbackState?.playing;
            if (processingState == AudioProcessingState.loading ||
                processingState == AudioProcessingState.buffering) {
              return Container(
                margin: const EdgeInsets.all(8.0),
                width: 64.0,
                height: 64.0,
                child: const CircularProgressIndicator(),
              );
            } else if (playing != true) {
              return buttonWidget('assets/play_icon.png', _audioHandler.play);
            } else {
              return IconButton(
                icon: const Icon(
                  Icons.pause_circle_filled_outlined,
                  color: Colors.grey,
                ),
                iconSize: 48.0,
                onPressed: _audioHandler.pause,
              );
            }
          },
        ),
        SizedBox(
          width: size.width * .05,
        ),
        buttonWidget(
            'assets/five_secon_next_icon.png', _audioHandler.fastForward),
        SizedBox(
          width: size.width * .05,
        ),
        // StreamBuilder<QueueState>(
        //   stream: audioHandler.queueState,
        //   builder: (context, snapshot) {
        //     final queueState = snapshot.data ?? QueueState.empty;
        //     return IconButton(
        //       icon: const Icon(Icons.skip_next),
        //       onPressed: queueState.hasNext ? audioHandler.skipToNext : null,
        //     );
        //   },
        // ),
        StreamBuilder<double>(
          stream: _audioHandler.speed,
          builder: (context, snapshot) => IconButton(
            icon: Text("${snapshot.data?.toStringAsFixed(1)}x",
                style: const TextStyle(fontWeight: FontWeight.bold)),
            onPressed: () {
              showSliderDialog(
                context: context,
                title: "Adjust speed",
                divisions: 10,
                min: 0.5,
                max: 1.5,
                value: _audioHandler.speed.value,
                stream: _audioHandler.speed,
                onChanged: _audioHandler.setSpeed,
              );
            },
          ),
        ),
      ],
    );
  }

  Widget buttonWidget(String iconData, VoidCallback onPressed) {
    return InkWell(
        onTap: onPressed,
        child: Image.asset(
          iconData,
          height: 40,
          width: 40,
        ));
  }
}

class QueueState {
  static const QueueState empty =
      QueueState([], 0, [], AudioServiceRepeatMode.none);

  final List<MediaItem> queue;
  final int? queueIndex;
  final List<int>? shuffleIndices;
  final AudioServiceRepeatMode repeatMode;

  const QueueState(
      this.queue, this.queueIndex, this.shuffleIndices, this.repeatMode);

  bool get hasPrevious =>
      repeatMode != AudioServiceRepeatMode.none || (queueIndex ?? 0) > 0;
  bool get hasNext =>
      repeatMode != AudioServiceRepeatMode.none ||
      (queueIndex ?? 0) + 1 < queue.length;

  List<int> get indices =>
      shuffleIndices ?? List.generate(queue.length, (i) => i);
}

/// An [AudioHandler] for playing a list of podcast episodes.
///
/// This class exposes the interface and not the implementation.
abstract class AudioPlayerHandler implements AudioHandler {
  Stream<QueueState> get queueState;
  Future<void> moveQueueItem(int currentIndex, int newIndex);
  ValueStream<double> get volume;
  Future<void> setVolume(double volume);
  ValueStream<double> get speed;
}

/// The implementation of [AudioPlayerHandler].
///
/// This handler is backed by a just_audio player. The player's effective
/// sequence is mapped onto the handler's queue, and the player's state is
/// mapped onto the handler's state.
class AudioPlayerHandlerImpl extends BaseAudioHandler
    with SeekHandler
    implements AudioPlayerHandler {
  // ignore: close_sinks
  final BehaviorSubject<List<MediaItem>> _recentSubject =
      BehaviorSubject.seeded(<MediaItem>[]);
  final _mediaLibrary = MediaLibrary();
  final _player = AudioPlayer();
  final _playlist = ConcatenatingAudioSource(children: []);
  @override
  final BehaviorSubject<double> volume = BehaviorSubject.seeded(1.0);
  @override
  final BehaviorSubject<double> speed = BehaviorSubject.seeded(1.0);
  final _mediaItemExpando = Expando<MediaItem>();

  /// A stream of the current effective sequence from just_audio.
  Stream<List<IndexedAudioSource>> get _effectiveSequence => Rx.combineLatest3<
              List<IndexedAudioSource>?,
              List<int>?,
              bool,
              List<IndexedAudioSource>?>(_player.sequenceStream,
          _player.shuffleIndicesStream, _player.shuffleModeEnabledStream,
          (sequence, shuffleIndices, shuffleModeEnabled) {
        if (sequence == null) return [];
        if (!shuffleModeEnabled) return sequence;
        if (shuffleIndices == null) return null;
        if (shuffleIndices.length != sequence.length) return null;
        return shuffleIndices.map((i) => sequence[i]).toList();
      }).whereType<List<IndexedAudioSource>>();

  /// Computes the effective queue index taking shuffle mode into account.
  int? getQueueIndex(
      int? currentIndex, bool shuffleModeEnabled, List<int>? shuffleIndices) {
    final effectiveIndices = _player.effectiveIndices ?? [];
    final shuffleIndicesInv = List.filled(effectiveIndices.length, 0);
    for (var i = 0; i < effectiveIndices.length; i++) {
      shuffleIndicesInv[effectiveIndices[i]] = i;
    }
    return (shuffleModeEnabled &&
            ((currentIndex ?? 0) < shuffleIndicesInv.length))
        ? shuffleIndicesInv[currentIndex ?? 0]
        : currentIndex;
  }

  /// A stream reporting the combined state of the current queue and the current
  /// media item within that queue.
  @override
  Stream<QueueState> get queueState =>
      Rx.combineLatest3<List<MediaItem>, PlaybackState, List<int>, QueueState>(
          queue,
          playbackState,
          _player.shuffleIndicesStream.whereType<List<int>>(),
          (queue, playbackState, shuffleIndices) => QueueState(
                queue,
                playbackState.queueIndex,
                playbackState.shuffleMode == AudioServiceShuffleMode.all
                    ? shuffleIndices
                    : null,
                playbackState.repeatMode,
              )).where((state) =>
          state.shuffleIndices == null ||
          state.queue.length == state.shuffleIndices!.length);

  @override
  Future<void> setShuffleMode(AudioServiceShuffleMode shuffleMode) async {
    final enabled = shuffleMode == AudioServiceShuffleMode.all;
    if (enabled) {
      await _player.shuffle();
    }
    playbackState.add(playbackState.value.copyWith(shuffleMode: shuffleMode));
    await _player.setShuffleModeEnabled(enabled);
  }

  @override
  Future<void> setRepeatMode(AudioServiceRepeatMode repeatMode) async {
    playbackState.add(playbackState.value.copyWith(repeatMode: repeatMode));
    await _player.setLoopMode(LoopMode.values[repeatMode.index]);
  }

  @override
  Future<void> setSpeed(double speed) async {
    this.speed.add(speed);
    await _player.setSpeed(speed);
  }

  @override
  Future<void> setVolume(double volume) async {
    this.volume.add(volume);
    await _player.setVolume(volume);
  }

  AudioPlayerHandlerImpl() {
    _init();
  }

  Future<void> _init() async {
    final session = await AudioSession.instance;
    await session.configure(const AudioSessionConfiguration.speech());
    // Broadcast speed changes. Debounce so that we don't flood the notification
    // with updates.
    speed.debounceTime(const Duration(milliseconds: 250)).listen((speed) {
      playbackState.add(playbackState.value.copyWith(speed: speed));
    });
    // Load and broadcast the initial queue
    await updateQueue(_mediaLibrary.items[MediaLibrary.albumsRootId]!);
    // For Android 11, record the most recent item so it can be resumed.
    mediaItem
        .whereType<MediaItem>()
        .listen((item) => _recentSubject.add([item]));
    // Broadcast media item changes.
    Rx.combineLatest4<int?, List<MediaItem>, bool, List<int>?, MediaItem?>(
        _player.currentIndexStream,
        queue,
        _player.shuffleModeEnabledStream,
        _player.shuffleIndicesStream,
        (index, queue, shuffleModeEnabled, shuffleIndices) {
      final queueIndex =
          getQueueIndex(index, shuffleModeEnabled, shuffleIndices);
      return (queueIndex != null && queueIndex < queue.length)
          ? queue[queueIndex]
          : null;
    }).whereType<MediaItem>().distinct().listen(mediaItem.add);
    // Propagate all events from the audio player to AudioService clients.
    _player.playbackEventStream.listen(_broadcastState);
    _player.shuffleModeEnabledStream
        .listen((enabled) => _broadcastState(_player.playbackEvent));
    // In this example, the service stops when reaching the end.
    _player.processingStateStream.listen((state) {
      if (state == ProcessingState.completed) {
        stop();
        _player.seek(Duration.zero, index: 0);
      }
    });
    // Broadcast the current queue.
    _effectiveSequence
        .map((sequence) =>
            sequence.map((source) => _mediaItemExpando[source]!).toList())
        .pipe(queue);
    // Load the playlist.
    _playlist.addAll(queue.value.map(_itemToSource).toList());
    await _player.setAudioSource(_playlist);
  }

  AudioSource _itemToSource(MediaItem mediaItem) {
    final audioSource = AudioSource.uri(Uri.parse(mediaItem.id));
    _mediaItemExpando[audioSource] = mediaItem;
    return audioSource;
  }

  List<AudioSource> _itemsToSources(List<MediaItem> mediaItems) =>
      mediaItems.map(_itemToSource).toList();

  @override
  Future<List<MediaItem>> getChildren(String parentMediaId,
      [Map<String, dynamic>? options]) async {
    switch (parentMediaId) {
      case AudioService.recentRootId:
        // When the user resumes a media session, tell the system what the most
        // recently played item was.
        return _recentSubject.value;
      default:
        // Allow client to browse the media library.
        return _mediaLibrary.items[parentMediaId]!;
    }
  }

  @override
  ValueStream<Map<String, dynamic>> subscribeToChildren(String parentMediaId) {
    switch (parentMediaId) {
      case AudioService.recentRootId:
        final stream = _recentSubject.map((_) => <String, dynamic>{});
        return _recentSubject.hasValue
            ? stream.shareValueSeeded(<String, dynamic>{})
            : stream.shareValue();
      default:
        return Stream.value(_mediaLibrary.items[parentMediaId])
            .map((_) => <String, dynamic>{})
            .shareValue();
    }
  }

  @override
  Future<void> addQueueItem(MediaItem mediaItem) async {
    await _playlist.add(_itemToSource(mediaItem));
  }

  @override
  Future<void> addQueueItems(List<MediaItem> mediaItems) async {
    await _playlist.addAll(_itemsToSources(mediaItems));
  }

  @override
  Future<void> insertQueueItem(int index, MediaItem mediaItem) async {
    await _playlist.insert(index, _itemToSource(mediaItem));
  }

  @override
  Future<void> updateQueue(List<MediaItem> queue) async {
    await _playlist.clear();
    await _playlist.addAll(_itemsToSources(queue));
  }

  @override
  Future<void> updateMediaItem(MediaItem mediaItem) async {
    final index = queue.value.indexWhere((item) => item.id == mediaItem.id);
    _mediaItemExpando[_player.sequence![index]] = mediaItem;
  }

  @override
  Future<void> removeQueueItem(MediaItem mediaItem) async {
    final index = queue.value.indexOf(mediaItem);
    await _playlist.removeAt(index);
  }

  @override
  Future<void> moveQueueItem(int currentIndex, int newIndex) async {
    await _playlist.move(currentIndex, newIndex);
  }

  @override
  Future<void> skipToNext() => _player.seekToNext();

  @override
  Future<void> skipToPrevious() => _player.seekToPrevious();

  @override
  Future<void> skipToQueueItem(int index) async {
    if (index < 0 || index >= _playlist.children.length) return;
    // This jumps to the beginning of the queue item at [index].
    _player.seek(Duration.zero,
        index: _player.shuffleModeEnabled
            ? _player.shuffleIndices![index]
            : index);
  }

  @override
  Future<void> play() => _player.play();

  @override
  Future<void> pause() => _player.pause();

  @override
  Future<void> seek(Duration position) => _player.seek(position);

  @override
  Future<void> stop() async {
    await _player.stop();
    await playbackState.firstWhere(
        (state) => state.processingState == AudioProcessingState.idle);
  }

  /// Broadcasts the current state to all clients.
  void _broadcastState(PlaybackEvent event) {
    final playing = _player.playing;
    final queueIndex = getQueueIndex(
        event.currentIndex, _player.shuffleModeEnabled, _player.shuffleIndices);
    playbackState.add(playbackState.value.copyWith(
      controls: [
        MediaControl.skipToPrevious,
        if (playing) MediaControl.pause else MediaControl.play,
        MediaControl.stop,
        MediaControl.skipToNext,
      ],
      systemActions: const {
        MediaAction.seek,
        MediaAction.seekForward,
        MediaAction.seekBackward,
      },
      androidCompactActionIndices: const [0, 1, 3],
      processingState: const {
        ProcessingState.idle: AudioProcessingState.idle,
        ProcessingState.loading: AudioProcessingState.loading,
        ProcessingState.buffering: AudioProcessingState.buffering,
        ProcessingState.ready: AudioProcessingState.ready,
        ProcessingState.completed: AudioProcessingState.completed,
      }[_player.processingState]!,
      playing: playing,
      updatePosition: _player.position,
      bufferedPosition: _player.bufferedPosition,
      speed: _player.speed,
      queueIndex: queueIndex,
    ));
  }
}

/// Provides access to a library of media items. In your app, this could come
/// from a database or web service.
class MediaLibrary {
  static const albumsRootId = 'albums';

  final items = <String, List<MediaItem>>{
    AudioService.browsableRootId: const [
      MediaItem(
        id: albumsRootId,
        title: "Albums",
        playable: false,
      ),
    ],
    albumsRootId: [
      MediaItem(
        id: 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-1.mp3',
        album: "Science Friday",
        title: "From Cat Rheology To Operatic Incompetence",
        artist: "Science Friday and WNYC Studios",
        duration: const Duration(milliseconds: 2856950),
        artUri: Uri.parse(
            'https://media.wnyc.org/i/1400/1400/l/80/1/ScienceFriday_WNYCStudios_1400.jpg'),
      ),
      MediaItem(
        id: 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-2.mp3',
        album: "Science Friday",
        title: "Laugh Along At Home With The Ig Nobel Awards",
        artist: "Science Friday and WNYC Studios",
        duration: const Duration(milliseconds: 1791883),
        artUri: Uri.parse(
            'https://media.wnyc.org/i/1400/1400/l/80/1/ScienceFriday_WNYCStudios_1400.jpg'),
      ),
      MediaItem(
        id: 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-3.mp3',
        album: "Science Friday",
        title: "Laugh Along At Home With The Ig Nobel Awards",
        artist: "Science Friday and WNYC Studios",
        duration: const Duration(milliseconds: 1791883),
        artUri: Uri.parse(
            'https://media.wnyc.org/i/1400/1400/l/80/1/ScienceFriday_WNYCStudios_1400.jpg'),
      ),
      MediaItem(
        id: 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-6.mp3',
        album: "Science Friday",
        title: "Laugh Along At Home With The Ig Nobel Awards",
        artist: "Science Friday and WNYC Studios",
        duration: const Duration(milliseconds: 1791883),
        artUri: Uri.parse(
            'https://media.wnyc.org/i/1400/1400/l/80/1/ScienceFriday_WNYCStudios_1400.jpg'),
      ),
      MediaItem(
        id: 'https://file-examples-com.github.io/uploads/2017/11/file_example_MP3_1MG.mp3',
        album: "Science Friday",
        title: "Laugh Along At Home With The Ig Nobel Awards",
        artist: "Science Friday and WNYC Studios",
        duration: const Duration(milliseconds: 1791883),
        artUri: Uri.parse(
            'https://media.wnyc.org/i/1400/1400/l/80/1/ScienceFriday_WNYCStudios_1400.jpg'),
      ),
    ],
  };
}
