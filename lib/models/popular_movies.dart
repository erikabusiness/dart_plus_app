import 'dart:convert';

import 'media.dart';

class PopularMovie extends Media {
  final String originalTitle;
  final bool video;

  PopularMovie({
    required this.originalTitle,
    required this.video,
    super.title = '',
    super.posterPath = '',
    super.adult,
    super.backdropPath,
    super.genreIds,
    super.originalLanguage,
    super.overview,
    super.popularity,
    super.voteAverage,
    super.voteCount,
    super.releaseDate,
    required super.id,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'release_date': releaseDate,
      'original_title': originalTitle,
      'video': video ? 'true' : 'false',
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
    };
  }

  static PopularMovie fromJson(Map<String, dynamic> json) {
    return PopularMovie(
      id: json["id"],
      releaseDate: json['release_date'] ?? '',
      originalTitle: json['original_title'] ?? '',
      video: json['video'] ?? false,
      title: json['title'] ?? '',
      posterPath: json['poster_path'] ?? '',
      adult: json['adult'] ?? false,
      backdropPath: json['backdrop_path'] ?? '',
      genreIds: List<int>.from(json['genre_ids'] ?? []),
      originalLanguage: json['original_language'] ?? '',
      overview: json['overview'] ?? '',
      popularity: json['popularity']?.toDouble() ?? 0.0,
      voteAverage: json['vote_average']?.toDouble() ?? 0.0,
      voteCount: json['vote_count'] ?? 0,
    );
  }
}
