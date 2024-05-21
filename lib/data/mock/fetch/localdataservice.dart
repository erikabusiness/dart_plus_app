import 'dart:convert';
import 'package:flutter/services.dart';


import '../../../models/media.dart';
import '../../../models/popular_movies.dart';
import '../../../models/popular_series.dart';

class LocalDataService {
  Future<List<Media>> fetchData() async {
    try {
      final String moviesResponse =
          await rootBundle.loadString('lib/data/mock/popularMovies.json');
      final String seriesResponse =
          await rootBundle.loadString('lib/data/mock/popularTvSeries.json');
      print("Movies Data: $moviesResponse");
      print("Series Data: $seriesResponse");

      final moviesData = jsonDecode(moviesResponse);
      final seriesData = jsonDecode(seriesResponse);
      print("Parsed Movies Data: $moviesData");
      print("Parsed Series Data: $seriesData");

      List<Media> items = [];
      if (moviesData != null && moviesData['results'] is List) {
        items.addAll((moviesData['results'] as List)
            .map((item) => PopularMovie.fromJson(item))
            .toList());
      }
      if (seriesData != null && seriesData['results'] is List) {
        items.addAll((seriesData['results'] as List)
            .map((item) => PopularSeries.fromJson(item))
            .toList());
      }

      print("Loaded items: $items");
      return items;
    } catch (e) {
      print('Erro ao carregar dados: $e');
      return [];
    }
  }
}
