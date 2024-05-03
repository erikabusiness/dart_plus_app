class PopularSeries {
  final String originalName;
  final String posterPath;
  final String firstAirDate;
  final bool adult;
  final String backdropPath;
  final List<int> genreIds;
  final List<String> originCountry;
  final String originalLanguage;
  final String overview;
  final double popularity;
  final String posterPath;
  final double voteAverage;
  final int voteCount;

  PopularSeries({
    required this.originalName = "",
    required this.posterPath = "",
    required this.firstAirDate
    this.adult = false,
    this.backdropPath = "",
    this.genreIds = const [],
    this.originCountry = const [],
    this.originalLanguage = "",
    this.overview = "",
    this.popularity = 0.0,
    this.voteAverage = 0.0,
    this.voteCount = 0,
  });
}
