class PopularMovie {
  final int id; 
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
    required this.id,
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

  factory PopularMovie.fromJson(Map<String, dynamic> json) {
  return PopularMovie(
  id: json['id'] ?? 0,
  title: json['title'] ?? '',
  posterPath: json['poster_path'] ?? '',
  releaseDate: json['release_date'] ?? '',
  adult: json['adult'] ?? false,
  backdropPath: json['backdrop_path'] ?? '',
  genreIds: List<int>.from(json['genre_ids'] ?? []),
  originalLanguage: json['original_language'] ?? '',
  originalTitle: json['original_title'] ?? '',
  overview: json['overview'] ?? '',
  popularity: json['popularity']?.toDouble() ?? 0.0,
  video: json['video'] ?? false,
  voteAverage: json['vote_average']?.toDouble() ?? 0.0,
  voteCount: json['vote_count'] ?? 0,
  );
}
}
