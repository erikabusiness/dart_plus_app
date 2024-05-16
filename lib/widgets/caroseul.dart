import 'package:dart_plus_app/models/media.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class WidgetCarousel extends StatelessWidget {
  final List<Media> mediaItems;

  const WidgetCarousel({Key? key, required this.mediaItems}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      items: mediaItems.map((media) {
        return Container(
          width: MediaQuery.of(context).size.width,
          margin: EdgeInsets.symmetric(horizontal: 5.0),
          padding: EdgeInsets.all(8.0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16.0),
            child: Image.network(
              'https://image.tmdb.org/t/p/w500${media.backdropPath}',
              fit: BoxFit.cover,
            ),
          ),
        );
      }).toList(),
      options: CarouselOptions(
        height: 200,
        autoPlay: true,
        autoPlayInterval: Duration(seconds: 5),
      ),
    );
  }
}
