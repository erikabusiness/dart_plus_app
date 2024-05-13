import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class WidgetMediaTrailer extends StatefulWidget {
  const WidgetMediaTrailer({super.key});

  @override
  State<WidgetMediaTrailer> createState() => _MediaTrailerState();
}

class _MediaTrailerState extends State<WidgetMediaTrailer> {
  String videoURL = "https://youtu.be/uQZMz5G1T-Y?si=vbMcGuyOM8vs20Vq";

  YoutubePlayerController? _controller;

  @override
  void initState() {
    final videoID = YoutubePlayer.convertUrlToId(videoURL);
    _controller = YoutubePlayerController(
      initialVideoId: videoID!,
      flags: const YoutubePlayerFlags(
        autoPlay: false,
      ),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: YoutubePlayer(
        controller: _controller!,
        showVideoProgressIndicator: true,
      ),
    );
  }
}
