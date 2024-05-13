import 'package:dart_plus_app/classes/media.dart';
import 'package:dart_plus_app/widgets/media_trailer.dart';
import 'package:dart_plus_app/widgets/story_line.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class DetailsPage extends StatelessWidget {
  final Media media;

  const DetailsPage({super.key, required this.media});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: [
                WidgetMediaTrailer(),
                WidgetStoryLine(
                  synopsisTitle: 'Sinopse',
                  synopsisText: media.overview,
                  width: MediaQuery.of(context).size.width,
                  padding: 16,
                ),
              ],
            ),
          ),
        )
      ],
    ));
  }
}
