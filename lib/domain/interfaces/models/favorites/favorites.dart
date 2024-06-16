import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

import '../media.dart';

part 'favorites.g.dart';

@JsonSerializable()
class Favorites extends Media {
  Favorites({
    super.video = false,
    super.title = '',
    super.posterPath = '',
    super.genreIds = const [],
    super.overview = '',
    super.voteAverage = 0.0,
    super.isFavorite = false,
    required super.id,
  });


  factory Favorites.fromJson(Map<String, dynamic> json) => _$FavoritesFromJson(json);
  Map<String, dynamic> toJson() => _$FavoritesToJson(this);

  static List<int> _genreIdsFromJson(dynamic json) {
    if (json is List<dynamic>) {
      return json.cast<int>();
    } else if (json is String) {
      // Se os dados vierem do banco de dados como uma string
      return jsonDecode(json).cast<int>();
    } else {
      return [];
    }
  }

  static dynamic _genreIdsToJson(List<int> list) {
    // Convertendo a lista de IDs de gênero para uma string JSON
    return jsonEncode(list);
  }


}
