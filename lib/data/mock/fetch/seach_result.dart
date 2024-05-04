import 'dart:convert';

import 'package:dart_plus_app/classes/popular_films.dart';

void main() {
  String jsonString = '''
  {
    "popularMovies": [
      {
        "popularity": 2157.099,
        "title": "Nome do filme",
        "overview": "Descrição do filme",
        "poster_path": "/caminho/do/poster.jpg"
      }
    ],
    "popularTvSeries": [
      {
        "popularity": 2157.099,
        "title": "Nome da Série",
        "overview": "Descrição da série",
        "poster_path": "/caminho/do/poster.jpg"
      }
    ],
    "trending": [
      {
        "popularity": 2157.099,
        "title": "Título do Item Trending",
        "overview": "Descrição do item trending",
        "poster_path": "/caminho/do/poster.jpg"
      }
    ]
  }
  ''';

  Map<String, dynamic> data = jsonDecode(jsonString);

  List<dynamic> items = [];

  items.addAll((data['popularMovies'] as List)
      .map((item) => PopularMovie.fromJson(item))
      .toList());

  items.addAll((data['popularTvSeries'] as List)
      .map((item) => PopularSeries.fromJson(item))
      .toList());

  items.addAll((data['trending'] as List)
      .map((item) => PopularMovie.fromJson(item))
      .toList());

  processMetadata(items);
}

void processMetadata(List<dynamic> items) {
  for (var item in items) {
    if (item is PopularMovie) {
      print('Tipo: Filme');
      print('Título: ${item.title}');
      print('Descrição: ${item.overview}');
      print('Poster URL: https://image.tmdb.org/t/p/w500/${item.posterPath}');
      print('');
    } else if (item is PopularSeries) {
      print('Tipo: Série');
      print('Título: ${item.originalName}');
      print('Descrição: ${item.overview}');
      print('Poster URL: https://image.tmdb.org/t/p/w500/${item.posterPath}');
      print('');
    } else {
      print('Tipo desconhecido');
    }
  }
}
