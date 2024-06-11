
import 'package:json_annotation/json_annotation.dart';

import '../media.dart';

part 'popular_movies.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class PopularMovie extends Media {

  PopularMovie({
    super.video = false,
    super.title = '',
    super.posterPath = '',
    super.genreIds,
    super.overview,
    super.voteAverage,
    super.isFavorite,
    required super.id,
  });

  @override
  Map<String, dynamic> toMap() => _$PopularMovieToJson(this);

  factory PopularMovie.fromJson(Map<String, dynamic> json) => _$PopularMovieFromJson(json);

}
