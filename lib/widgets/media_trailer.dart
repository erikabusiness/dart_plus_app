import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class WidgetMediaTrailer extends StatefulWidget {
  final String videoKey;

  const WidgetMediaTrailer({super.key, required this.videoKey});

  @override
  State<WidgetMediaTrailer> createState() => _MediaTrailerState();
}

class _MediaTrailerState extends State<WidgetMediaTrailer> {
  late YoutubePlayerController _controller;

  @override
  void initState() {
    _controller = YoutubePlayerController(
      initialVideoId: widget.videoKey,
      flags: const YoutubePlayerFlags(
        autoPlay: false,
      ),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return YoutubePlayer(
      controller: _controller,
      showVideoProgressIndicator: true,
    );
  }
}