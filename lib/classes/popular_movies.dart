class PopularMovie {
  final String title;
  final String posterPath;
  final String releaseDate;
  final bool adult;
  final String backdropPath;
  final List<int> genreIds;
  final String originalLanguage;
  final String originalTitle;
  final String overview;
  final double popularity;
  final bool video;
  final double voteAverage;
  final int voteCount;

  PopularMovie({
    required this.title,
    required this.posterPath,
    required this.releaseDate,
    this.adult = false,
    this.backdropPath = "",
    this.genreIds = const [],
    this.originalLanguage = "",
    this.originalTitle = "",
    this.overview = "",
    this.popularity = 0.0,
    this.video = false,
    this.voteAverage = 0.0,
    this.voteCount = 0,
  });
}
