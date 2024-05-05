import 'package:flutter/material.dart';
import 'package:dart_plus_app/classes/popular_movies.dart';
import 'package:dart_plus_app/classes/popular_series.dart';

class WidgetGridViewVertical extends StatelessWidget {
  final List<dynamic> mediaItems;

  const WidgetGridViewVertical({
    super.key,
    required this.mediaItems,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(24),
      itemCount: mediaItems.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 20,
        mainAxisSpacing: 30,
        childAspectRatio: 0.55,
      ),
      itemBuilder: (context, index) {
        var media = mediaItems[index];
        String title = media is PopularMovie
            ? media.title
            : (media as PopularSeries).originalName;
        String posterPath = media.posterPath;
        String releaseDate = media is PopularMovie
            ? media.releaseDate
            : (media as PopularSeries).firstAirDate;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AspectRatio(
              aspectRatio: 1,
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
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 4),
              child: Text(
                releaseDate,
                style: const TextStyle(fontSize: 12, color: Colors.grey),
              ),
            ),
          ],
        );
      },
    );
  }
}
