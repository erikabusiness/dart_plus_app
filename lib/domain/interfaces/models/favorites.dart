import 'media.dart';

class Favorites extends Media {
  Favorites({
    super.originalTitle = '',
    super.video = false,
    super.originalName = '',
    super.originCountry = const [],
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
