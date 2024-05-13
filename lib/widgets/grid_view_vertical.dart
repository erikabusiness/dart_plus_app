import 'package:dart_plus_app/classes/media.dart';
import 'package:dart_plus_app/widgets/media_card.dart';
import 'package:flutter/material.dart';

class WidgetGridViewVertical extends StatelessWidget {
  final List<Media> mediaItems;

  const WidgetGridViewVertical({
    super.key,
    required this.mediaItems,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GridView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: mediaItems.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 24,
          childAspectRatio: 0.45,
        ),
        itemBuilder: (context, index) {
          var media = mediaItems[index];
          return MediaCard(
            media: media,
            title: media.title,
            mediaItems: mediaItems,
          );
        },
      ),
    );
  }
}
