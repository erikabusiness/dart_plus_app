// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favorites.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Favorites _$FavoritesFromJson(Map<String, dynamic> json) => Favorites(
      video: json['video'] as bool? ?? false,
      title: json['title'] as String? ?? '',
      posterPath: json['posterPath'] as String? ?? '',
      genreIds: (json['genreIds'] as List<dynamic>?)
              ?.map((e) => (e as num).toInt())
              .toList() ??
          const [],
      overview: json['overview'] as String? ?? '',
      voteAverage: (json['voteAverage'] as num?)?.toDouble() ?? 0.0,
      isFavorite: json['isFavorite'] as bool? ?? false,
      id: (json['id'] as num).toInt(),
    );

Map<String, dynamic> _$FavoritesToJson(Favorites instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'posterPath': instance.posterPath,
      'genreIds': instance.genreIds,
      'overview': instance.overview,
      'voteAverage': instance.voteAverage,
      'video': instance.video,
      'isFavorite': instance.isFavorite,
    };
