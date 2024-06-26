import 'package:auto_route/auto_route.dart';
import 'package:dart_plus_app/routes/app_router.dart';
import 'package:flutter/material.dart';

import '../../domain/interfaces/models/media.dart';
import 'media_card.dart';

class WidgetListViewHorizontal extends StatelessWidget {
  final List<Media> mediaItems;
  final int itemCount;
  final double aspectRatio;
  final double heightPercentage;

  const WidgetListViewHorizontal({
    super.key,
    required this.mediaItems,
    this.itemCount = 6,
    this.aspectRatio = 0.6,
    this.heightPercentage = 0.25,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * heightPercentage,
      child: Container(
        margin: EdgeInsets.zero,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: mediaItems.length > itemCount ? itemCount : mediaItems.length,
          itemBuilder: (BuildContext context, int index) {
            return AspectRatio(
              aspectRatio: aspectRatio,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8.0,
                ),
                child: MediaCard(
                  media: mediaItems[index],
                  viewTitle: true,
                  onClick: () {
                    context.pushRoute(
                      DetailsRoute(media: mediaItems[index], moviesList: mediaItems)
                    );
                  },
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
