import 'dart:convert';

abstract class Media {
  final int id;
  final String title;
  final String posterPath;
  final bool adult;
  final String backdropPath;
  final List<int> genreIds;
  final String originalLanguage;
  final String overview;
  final double popularity;
  final double voteAverage;
  final int voteCount;
  final String releaseDate;
  final String originalTitle;
  final String originalName;
  final List<String> originCountry;
  final bool video;
  bool isFavorite;

  Media({
    required this.id,
    required this.title,
    required this.posterPath,
    this.adult = false,
    this.backdropPath = "",
    this.genreIds = const [],
    this.originalLanguage = "",
    this.overview = "",
    this.popularity = 0.0,
    this.voteAverage = 0.0,
    this.voteCount = 0,
    this.releaseDate = "",
    this.isFavorite = false,
    this.originalTitle = "",
    this.originalName = "",
    this.originCountry = const [],
    this.video = false,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'poster_path': posterPath,
      'adult': adult ? 1 : 0,
      'backdrop_path': backdropPath,
      'genre_ids': jsonEncode(genreIds),
      'original_language': originalLanguage,
      'overview': overview,
      'popularity': popularity,
      'vote_average': voteAverage,
      'vote_count': voteCount,
      'release_date': releaseDate,
      'is_favorite': isFavorite ? 1 : 0,
      'original_title': originalTitle,
      'original_name': originalName,
      'origin_country': jsonEncode(originCountry),
      'video': video ? 1 : 0,
    };
  }
}
