import 'package:flutter/material.dart';
import 'package:dart_plus_app/classes/popular_movies.dart';
import 'package:dart_plus_app/classes/popular_series.dart';
import 'package:google_fonts/google_fonts.dart';

class WidgetGridViewVertical extends StatelessWidget {
  final List<dynamic> mediaItems;

  const WidgetGridViewVertical({
    super.key,
    required this.mediaItems,
  });

  @override
  Widget build(BuildContext context) {
    int crossAxisCount = 3; // Set three items per row consistently
    double childAspectRatio =
        0.55; // Increase aspect ratio for more vertical space

    return Expanded(
      child: GridView.builder(
        padding: const EdgeInsets.all(10), // Reduce padding
        itemCount: mediaItems.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: crossAxisCount,
          crossAxisSpacing: 10, // Reduced spacing
          mainAxisSpacing: 10,
          childAspectRatio: childAspectRatio, // Adjusted aspect ratio
        ),
        itemBuilder: (context, index) {
          var media = mediaItems[index];
          String posterPath = media.posterPath;

          return Container(
            padding: const EdgeInsets.only(
                bottom: 10), // Added padding to avoid overflow
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
