import 'package:dart_plus_app/models/media.dart';
import 'package:dart_plus_app/widgets/title_section.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class WidgetCarousel extends StatelessWidget {
  final List<Media> mediaItems;

  const WidgetCarousel({super.key, required this.mediaItems});

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      items: mediaItems.map((media) {
        return Container(
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.symmetric(horizontal: 5.0),
            padding: const EdgeInsets.all(8.0),

            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(16.0),
                  child: Image.network(
                    'https://image.tmdb.org/t/p/w500${media.backdropPath}',
                    fit: BoxFit.cover,
                  ),
                ),
                Container(
                  height: 70,
                  margin: const EdgeInsets.only(top: 92),
                  decoration: BoxDecoration(
                    // color: Colors.black.withOpacity(0.5),
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.black.withOpacity(0), 
                        Colors.black.withOpacity(0.9)]                    ),
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(16),
                      bottomRight: Radius.circular(16)
                    ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(left: 5, bottom: 15),
                      alignment: Alignment.center,
                      child: WidgetTitleSection(
                        title: media.title,
                        textAlign: TextAlign.center,
                      )
                    ),
                  ],
                ),
              ],
            )
        );
      }).toList(),
      options: CarouselOptions(
        height: 200,
        autoPlay: true,
        autoPlayInterval: const Duration(seconds: 5),
      ),
    );
  }
}
