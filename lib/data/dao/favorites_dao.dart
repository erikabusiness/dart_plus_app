import 'dart:convert';
import 'package:dart_plus_app/data/database.dart';
import 'package:dart_plus_app/models/media.dart';
import 'package:sqflite/sqflite.dart';
import 'package:dart_plus_app/models/favorites.dart';

class FavoriteDao {
  final dbHelper = DatabaseHelper();

  Future<void> toggleFavorite(Media media) async {
    final db = await dbHelper.database;
    if (db == null) {
      throw Exception('O banco de dados não foi inicializado corretamente');
    }

    final count = Sqflite.firstIntValue(await db
        .rawQuery('SELECT COUNT(*) FROM Favorites WHERE id = ?', [media.id]));

    if (count != null && count > 0) {
      await db.rawDelete('DELETE FROM Favorites WHERE id = ?', [media.id]);
    } else {
      await db.insert(
        'Favorites',
        media.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
  }

  Future<bool> isFavorite(Media media) async {
    final db = await dbHelper.database;
    if (db == null) {
      throw Exception('O banco de dados não foi inicializado corretamente');
    }

    final List<Map<String, dynamic>> result = await db.query(
      'Favorites',
      columns: ['id'],
      where: 'id = ?',
      whereArgs: [media.id],
    );
    return result.isNotEmpty;
  }

  Future<List<Favorites>> getFavorites() async {
    final db = await dbHelper.database;
    if (db == null) {
      throw Exception('O banco de dados não foi inicializado corretamente');
    }

    List<Map<String, dynamic>> maps = await db.query(
      'Favorites',
    );

    List<Favorites> favoriteMedia = List.generate(maps.length, (i) {
      List<int> genreIds = jsonDecode(maps[i]['genre_ids']).cast<int>();
      List<String> originCountry = [];
      if (maps[i]['origin_country'].isNotEmpty) {
        originCountry = [
          maps[i]['origin_country'].split('[').last.split(']').first
        ];
      }

      return Favorites(
        id: maps[i]['id'],
        originalTitle: maps[i]['original_title'] ?? '',
        video: maps[i]['video'] == 1,
        originalName: maps[i]['original_name'] ?? '',
        originCountry: originCountry,
        releaseDate: maps[i]['release_date'] ?? '',
        originalLanguage: maps[i]['original_language'] ?? '',
        overview: maps[i]['overview'] ?? '',
        popularity: maps[i]['popularity'] ?? 0.0,
        voteAverage: maps[i]['vote_average'] ?? 0.0,
        voteCount: maps[i]['vote_count'] ?? 0,
        posterPath: maps[i]['poster_path'] ?? '',
        backdropPath: maps[i]['backdrop_path'] ?? '',
        adult: maps[i]['adult'] == 1,
        title: maps[i]['title'] ?? '',
        genreIds: genreIds,
        isFavorite: maps[i]['is_favorite'] == 1,
      );
    });

    return favoriteMedia;
  }
}
