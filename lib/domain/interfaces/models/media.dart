abstract class Media {
  final int id;
  final String title;
  final String posterPath;
  final String backdropPath;
  final List<int> genreIds;
  final String overview;
  final double voteAverage;
  final bool video;
  bool isFavorite;

  Media({
    required this.id,
    required this.title,
    required this.posterPath,
    this.backdropPath = "",
    this.genreIds = const [],
    this.overview = "",
    this.voteAverage = 0.0,
    this.isFavorite = true,
    this.video = false,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'poster_path': posterPath,
      'genre_ids': genreIds,
      'overview': overview,
      'vote_average': voteAverage,
      'is_favorite': isFavorite ? true : false,
      'video': video ? 1 : 0,
    };
  }
}
