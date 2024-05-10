class PopularSeries {
  final int id;
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
    required this.id,
    required this.originalName,
    required this.posterPath,
    required this.firstAirDate,
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

  factory PopularSeries.fromJson(Map<String, dynamic> json) {
  return PopularSeries(
  id: json['id'] ?? 0,
  originalName: json['original_name'] ?? '',
  posterPath: json['poster_path'] ?? '',
  firstAirDate: json['first_air_date'] ?? '',
  adult: json['adult'] ?? false,
  backdropPath: json['backdrop_path'] ?? '',
  genreIds: List<int>.from(json['genre_ids'] ?? []),
  originCountry: List<String>.from(json['origin_country'] ?? []),
  originalLanguage: json['original_language'] ?? '',
  overview: json['overview'] ?? '',
  popularity: json['popularity']?.toDouble() ?? 0.0,
  voteAverage: json['vote_average']?.toDouble() ?? 0.0,
  voteCount: json['vote_count'] ?? 0,
  );
  }
}
