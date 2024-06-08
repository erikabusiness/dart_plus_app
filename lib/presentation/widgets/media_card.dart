import 'package:dart_plus_app/domain/interfaces/models/media.dart';
import 'package:flutter/material.dart';

class MediaCard extends StatelessWidget {
  final Media media;
  final bool viewTitle;
  final void Function() onClick;

  const MediaCard({
    Key? key,
    required this.media,
    this.viewTitle = true,
    required this.onClick,
  }) : super(key: key);

  String voteStar(double vote) {
    var voteStar = vote / 2;
    return voteStar.toStringAsFixed(1);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onClick();
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          AspectRatio(
            aspectRatio: 0.7,
            child: Stack(
              children: [
                Image.network(
                  'https://image.tmdb.org/t/p/w500${media.posterPath}',
                  fit: BoxFit.fill,
                  errorBuilder: (context, error, stackTrace) {
                    return Image.asset(
                      'assets/placeholder.png',
                      fit: BoxFit.fill,
                    );
                  },
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.7),
                      borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(8),
                        bottomLeft: Radius.circular(8),
                      ),
                    ),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.star,
                          color: Colors.yellow,
                          size: 16,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          voteStar(media.voteAverage),
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.normal,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          if (viewTitle != false)
            Padding(
              padding: const EdgeInsets.only(top: 0),
              child: Text(
                media.title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.normal,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              ),
            ),
        ],
      ),
    );
  }
}
