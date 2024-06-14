import 'package:dart_plus_app/presentation/widgets/title_section.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

import '../../domain/interfaces/models/media.dart';

class WidgetCarousel extends StatelessWidget {
  final List<Media> mediaItems;
  final void Function(Media media) onClick;

  const WidgetCarousel({super.key, required this.mediaItems, required this.onClick});

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      items: mediaItems.map((media) {
        return GestureDetector(
          onTap: () {
            onClick(media);
          },
          child: Container(
            width: MediaQuery
                .of(context)
                .size
                .width,
            margin: const EdgeInsets.symmetric(horizontal: 5.0),
            padding: const EdgeInsets.all(8.0),
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(16.0),
                  child: Image.network(
                    'https://image.tmdb.org/t/p/w500${media.posterPath}',
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: double.infinity,
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    height: 70,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.black.withOpacity(0),
                          Colors.black.withOpacity(0.5),
                          Colors.black.withOpacity(0.7),
                          Colors.black.withOpacity(0.9)
                        ],
                      ),
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(16),
                        bottomRight: Radius.circular(16),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: 8,
                  right: 8,
                  child: WidgetTitleSection(
                    title: media.title,
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
        );
      }).toList(),
      options: CarouselOptions(
        height: 200,
        autoPlay: true,
        autoPlayInterval: const Duration(seconds: 3),
      ),
    );
  }
}
