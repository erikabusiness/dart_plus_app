import 'package:dart_plus_app/classes/media.dart';
import 'package:flutter/material.dart';
import 'package:dart_plus_app/widgets/media_card.dart';

class WidgetListViewHorizontal extends StatelessWidget {
  final List<Media> mediaItems;

  const WidgetListViewHorizontal({
    super.key,
    required this.mediaItems,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.2,
      child: Container(
        margin: EdgeInsets.zero,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: 6,
          itemBuilder: (BuildContext context, int index) {
            return AspectRatio(
              aspectRatio: 0.8,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12.0,
                ),
                child: MediaCard(
                  media: mediaItems[index],
                  mediaItems: mediaItems,
                  title: null,
                ),
              ),
            );
          },
        ),
      ),
      //),
    );
  }
}
