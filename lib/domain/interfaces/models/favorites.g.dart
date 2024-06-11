// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favorites.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Favorites _$FavoritesFromJson(Map<String, dynamic> json) => Favorites(
      video: json['video'] as bool,
      title: json['title'] as String,
      posterPath: json['posterPath'] as String,
      genreIds: Favorites._genreIdsFromJson(json['genreIds']),
      overview: json['overview'] as String,
      voteAverage: (json['voteAverage'] as num).toDouble(),
      isFavorite: json['isFavorite'] as bool ? true : false,
      id: (json['id'] as num).toInt(),
    );

Map<String, dynamic> _$FavoritesToJson(Favorites instance) => <String, dynamic>{
      'video': instance.video,
      'title': instance.title,
      'posterPath': instance.posterPath,
      'genreIds': Favorites._genreIdsToJson(instance.genreIds),
      'overview': instance.overview,
      'voteAverage': instance.voteAverage,
      'isFavorite': instance.isFavorite,
      'id': instance.id,
    };
