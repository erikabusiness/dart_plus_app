import 'package:flutter/material.dart';

class WidgetGridViewVertical extends StatelessWidget {
  final List<dynamic> mediaItems;

  const WidgetGridViewVertical({
    super.key,
    required this.mediaItems,
  });

  @override
  Widget build(BuildContext context) {
    int crossAxisCount = 3;
    double childAspectRatio = 0.55;

    return Expanded(
      child: GridView.builder(
        padding: const EdgeInsets.all(10),
        itemCount: mediaItems.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: crossAxisCount,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: childAspectRatio,
        ),
        itemBuilder: (context, index) {
          var media = mediaItems[index];
          String posterPath = media.posterPath;

          return Container(
            padding: const EdgeInsets.only(bottom: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                AspectRatio(
                  aspectRatio: 0.7,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      image: DecorationImage(
                        image: NetworkImage(
                            'https://image.tmdb.org/t/p/w500$posterPath'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
