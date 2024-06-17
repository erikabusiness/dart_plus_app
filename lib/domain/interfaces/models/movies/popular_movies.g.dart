// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'popular_movies.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PopularMovie _$PopularMovieFromJson(Map<String, dynamic> json) => PopularMovie(
      video: json['video'] as bool? ?? false,
      title: json['title'] as String? ?? '',
      posterPath: json['poster_path'] as String? ?? '',
      backdropPath: json['backdrop_path'] as String? ?? '',
      genreIds: (json['genre_ids'] as List<dynamic>?)
              ?.map((e) => (e as num).toInt())
              .toList() ??
          const [],
      overview: json['overview'] as String? ?? "",
      voteAverage: (json['vote_average'] as num?)?.toDouble() ?? 0.0,
      isFavorite: json['is_favorite'] as bool? ?? true,
      id: (json['id'] as num).toInt(),
    );

Map<String, dynamic> _$PopularMovieToJson(PopularMovie instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'poster_path': instance.posterPath,
      'backdrop_path': instance.backdropPath,
      'genre_ids': instance.genreIds,
      'overview': instance.overview,
      'vote_average': instance.voteAverage,
      'video': instance.video,
      'is_favorite': instance.isFavorite,
    };
