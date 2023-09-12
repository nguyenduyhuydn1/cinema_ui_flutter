import 'package:cinema_ui_flutter/config/constants/size_config.dart';
import 'package:cinema_ui_flutter/domain/entities/video.dart';
import 'package:cinema_ui_flutter/presentation/providers/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideosYoutube extends ConsumerStatefulWidget {
  final int movieId;
  const VideosYoutube({super.key, required this.movieId});

  @override
  VideosYoutubeState createState() => VideosYoutubeState();
}

class VideosYoutubeState extends ConsumerState<VideosYoutube> {
  @override
  void initState() {
    super.initState();
    ref
        .read(videosYoutubeProvider.notifier)
        .getVideoYoutubeByMovieId(widget.movieId);
  }

  @override
  Widget build(BuildContext context) {
    final videos = ref.watch(videosYoutubeProvider);
    if (videos.isEmpty) {
      return const SizedBox(
        child: Center(
          child: Text("data is not found"),
        ),
      );
    }

    return

        // OrientationBuilder(
        //   builder: (context, orientation) {
        //     switch (orientation) {
        //       case Orientation.portrait:
        //         return SizedBox(
        //           height: 200,
        //           child: ListView.builder(
        //             itemCount: videos.length,
        //             scrollDirection: Axis.horizontal,
        //             itemBuilder: (context, index) {
        //               final video = videos[index];
        //               return Padding(
        //                 padding: index == 0
        //                     ? const EdgeInsets.only(left: 10)
        //                     : index == videos.length - 1
        //                         ? const EdgeInsets.only(right: 10)
        //                         : const EdgeInsets.all(0),
        //                 child: _VideoYoutube(video: video),
        //               );
        //             },
        //           ),
        //         );
        //       case Orientation.landscape:
        //         return Scaffold(
        //           resizeToAvoidBottomInset: true,
        //           backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        //           body: const Text("asdasd"),
        //         );
        //     }
        //   },
        // );

        Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 10),
        const Padding(
          padding: EdgeInsets.only(left: 10, bottom: 10),
          child: Text(
            "Trailers",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(
          height: 200,
          child: ListView.builder(
            itemCount: videos.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              final video = videos[index];
              return Padding(
                padding: index == 0
                    ? const EdgeInsets.only(left: 10, right: 10)
                    : const EdgeInsets.only(right: 10),
                child: _VideoYoutube(video: video),
              );
            },
          ),
        ),
      ],
    );
  }
}

class _VideoYoutube extends ConsumerStatefulWidget {
  final Video video;
  const _VideoYoutube({required this.video});

  @override
  _VideoYoutubeState createState() => _VideoYoutubeState();
}

class _VideoYoutubeState extends ConsumerState<_VideoYoutube> {
  late YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: widget.video.youtubeKey,
      flags: const YoutubePlayerFlags(
        autoPlay: false,
        mute: true,
        isLive: false,
        disableDragSeek: true,
        hideThumbnail: true,
        showLiveFullscreenButton: false,
        loop: false,
        forceHD: false,
        enableCaption: false,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: SizeConfig.screenWidth,
      child: YoutubePlayerBuilder(
        onEnterFullScreen: () {
          // SystemChrome.setPreferredOrientations(DeviceOrientation.values);
          // SystemChrome.setPreferredOrientations([
          //   // DeviceOrientation.landscapeRight,
          //   DeviceOrientation.landscapeLeft
          // ]);
        },
        onExitFullScreen: () {
          // SystemChrome.setPreferredOrientations([DeviceOrientation.values]);
        },
        player: YoutubePlayer(
          controller: _controller,
        ),
        builder: (context, player) {
          return player;
        },
      ),
    );
  }
}
