import 'package:dart_plus_app/classes/media.dart';
import 'package:dart_plus_app/widgets/media_card.dart';
import 'package:flutter/material.dart';

import '../data/routes.dart';

class WidgetGridViewVertical extends StatelessWidget {
  final List<Media> mediaItems;
  final int gridCount;
  final double crossAxisSpacing;
  final double childAspectRatio;

  const WidgetGridViewVertical({
    super.key,
    required this.mediaItems,
    this.gridCount = 3,
    this.crossAxisSpacing = 24,
    this.childAspectRatio = 0.45,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GridView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: mediaItems.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: gridCount,
          crossAxisSpacing: crossAxisSpacing,
          childAspectRatio: childAspectRatio,
        ),
        itemBuilder: (context, index) {
          var media = mediaItems[index];
          return MediaCard(
            media: media,
            onClick: () {
              Navigator.pushNamed(
                context,
                NavRoutes.details,
                arguments: {
                  "mediaDetails": mediaItems[index],
                  "listMedias": mediaItems,
                },
              );
            },
          );
        },
      ),
    );
  }
}
