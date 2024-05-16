import 'package:dart_plus_app/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:dart_plus_app/widgets/media_card.dart';

import '../models/media.dart';

class WidgetListViewHorizontal extends StatelessWidget {
  final List<Media> mediaItems;
  final int itemCount;
  final double aspectRatio;
  final double heightPercentage;

  const WidgetListViewHorizontal({
    super.key,
    required this.mediaItems,
    this.itemCount = 6,
    this.aspectRatio = 0.8,
    this.heightPercentage = 0.2,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * heightPercentage,
      child: Container(
        margin: EdgeInsets.zero,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: itemCount,
          itemBuilder: (BuildContext context, int index) {
            return AspectRatio(
              aspectRatio: aspectRatio,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12.0,
                ),
                child: MediaCard(
                  media: mediaItems[index],
                  viewTitle: false,
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
