abstract class Media {
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

  Media({
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
  });
}