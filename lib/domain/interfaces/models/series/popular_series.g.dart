// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'popular_series.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PopularSeries _$PopularSeriesFromJson(Map<String, dynamic> json) =>
    PopularSeries(
      title: json['name'] as String,
      posterPath: json['poster_path'] as String? ?? '',
      genreIds: (json['genre_ids'] as List<dynamic>?)
              ?.map((e) => (e as num).toInt())
              .toList() ??
          const [],
      overview: json['overview'] as String? ?? "",
      voteAverage: (json['vote_average'] as num?)?.toDouble() ?? 0.0,
      isFavorite: json['is_favorite'] as bool? ?? true,
      id: (json['id'] as num).toInt(),
    );

Map<String, dynamic> _$PopularSeriesToJson(PopularSeries instance) =>
    <String, dynamic>{
      'id': instance.id,
      'poster_path': instance.posterPath,
      'genre_ids': instance.genreIds,
      'overview': instance.overview,
      'vote_average': instance.voteAverage,
      'is_favorite': instance.isFavorite,
      'name': instance.title,
    };
