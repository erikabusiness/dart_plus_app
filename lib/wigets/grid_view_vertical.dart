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
    int crossAxisCount = MediaQuery.of(context).size.width > 800
        ? 4
        : MediaQuery.of(context).size.width > 600
            ? 3
            : 2;
    double childAspectRatio = MediaQuery.of(context).size.width > 800
        ? 0.9
        : MediaQuery.of(context).size.width > 600
            ? 0.7
            : 0.5;

    return Expanded(
      child: GridView.builder(
        padding: const EdgeInsets.all(24),
        itemCount: mediaItems.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: crossAxisCount,
          crossAxisSpacing: 24,
          mainAxisSpacing: 16,
          childAspectRatio: childAspectRatio,
        ),
        itemBuilder: (context, index) {
          var media = mediaItems[index];
          String title = media is PopularMovie
              ? media.title
              : (media as PopularSeries).originalName;
          String posterPath = media.posterPath;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              AspectRatio(
                aspectRatio: 0.7,
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    image: DecorationImage(
                      image: NetworkImage(
                          'https://image.tmdb.org/t/p/w500$posterPath'),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 4),
                child: Text(
                  title,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
