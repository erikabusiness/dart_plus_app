import 'package:dart_plus_app/models/media.dart';

class Favorites extends Media {
  final String originalTitle;
  final bool video;
  final String originalName;
  final List<String> originCountry;

  Favorites({
    this.originalTitle = '',
    this.video = false,
    this.originalName = '',
    this.originCountry = const [],
    super.title = '',
    super.posterPath = '',
    super.adult = false,
    super.backdropPath = '',
    super.genreIds = const [],
    super.originalLanguage = '',
    super.overview = '',
    super.popularity = 0.0,
    super.voteAverage = 0.0,
    super.voteCount = 0,
    super.releaseDate = '',
    super.isFavorite = false,
    required super.id,
  });
}
