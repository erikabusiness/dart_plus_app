import 'package:dart_plus_app/models/media.dart';

class Favorites extends Media {
  final String originalTitle;
  final bool video;
  final String originalName;
  final List<String> originCountry;

  Favorites({
    required this.originalTitle,
    required this.video,
    required this.originalName,
    required this.originCountry,
    super.title = '',
    super.posterPath = '',
    super.adult,
    super.backdropPath,
    required super.genreIds,
    super.originalLanguage,
    super.overview,
    super.popularity,
    super.voteAverage,
    super.voteCount,
    super.releaseDate,
    super.isFavorite,
    required super.id,
  });
}
