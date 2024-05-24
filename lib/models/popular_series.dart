import 'dart:convert';

import 'media.dart';

class PopularSeries extends Media {
  final String originalName;
  final List<String> originCountry;

  PopularSeries({
    required this.originalName,
    required this.originCountry,
    super.title = '',
    super.posterPath = '',
    super.adult,
    super.backdropPath,
    super.genreIds,
    super.originalLanguage,
    super.overview,
    super.popularity,
    super.voteAverage,
    super.releaseDate,
    super.voteCount,
    super.isFavorite,
    required super.id,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'release_date': releaseDate,
      'original_name': originalName,
      'origin_country': originCountry,
      'title': title,
      'poster_path': posterPath,
      'adult': adult ? 'true' : 'false',
      'backdrop_path': backdropPath,
      'genre_ids': jsonEncode(genreIds),
      'original_language': originalLanguage,
      'overview': overview,
      'popularity': popularity,
      'vote_average': voteAverage,
      'vote_count': voteCount,
      'is_favorite': isFavorite ? 'true' : 'false',
    };
  }

  factory PopularSeries.fromJson(Map<String, dynamic> json) {
    return PopularSeries(
      id: json["id"],
      originalName: json['original_name'] ?? '',
      releaseDate: json['first_air_date'] ?? '',
      originCountry: List<String>.from(json['origin_country'] ?? []),
      title: json['original_name'] ?? '',
      posterPath: json['poster_path'] ?? '',
      adult: json['adult'] ?? false,
      backdropPath: json['backdrop_path'] ?? '',
      genreIds: List<int>.from(json['genre_ids'] ?? []),
      originalLanguage: json['original_language'] ?? '',
      overview: json['overview'] ?? '',
      popularity: json['popularity']?.toDouble() ?? 0.0,
      voteAverage: json['vote_average']?.toDouble() ?? 0.0,
      voteCount: json['vote_count'] ?? 0,
      isFavorite: json['is_favorite'] ?? false,
    );
  }
}
