import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import '../../domain/interfaces/models/media.dart';
import '../../routes/app_router.dart';
import 'media_card.dart';

class WidgetGridViewVertical extends StatelessWidget {
  final List<Media> mediaItems;
  final ScrollController? scrollController;
  final int gridCount;
  final double crossAxisSpacing;
  final double childAspectRatio;

  const WidgetGridViewVertical({
    super.key,
    required this.mediaItems,
    required this.scrollController,
    this.gridCount = 3,
    this.crossAxisSpacing = 24,
    this.childAspectRatio = 0.45,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: GridView.builder(
            controller: scrollController,
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
                  context.pushRoute(DetailsRoute(
                      media: mediaItems[index], moviesList: mediaItems));
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
