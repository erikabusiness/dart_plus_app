import 'dart:convert';
import 'package:dart_plus_app/data/database.dart';
import 'package:sqflite/sqflite.dart';

import '../../domain/interfaces/models/favorites/favorites.dart';
import '../../domain/interfaces/models/media.dart';

class FavoriteDao {
  final dbHelper = DatabaseHelper();

  Future<void> toggleFavorite(Media media) async {
    final db = await dbHelper.database;
    if (db == null) {
      throw Exception('O banco de dados não foi inicializado corretamente');
    }

    final count = Sqflite.firstIntValue(await db.rawQuery('SELECT COUNT(*) FROM Favorites WHERE id = ?', [media.id]));

    if (count != null && count > 0) {
      await db.rawDelete('DELETE FROM Favorites WHERE id = ?', [media.id]);
    } else {
      Map<String, dynamic> mediaMap = {
        'id': media.id,
        'video': media.video ? 'true' : 'false', // Convertendo para string
        'title': media.title,
        'poster_path': media.posterPath,
        'genre_ids': jsonEncode(media.genreIds),
        'overview': media.overview,
        'vote_average': media.voteAverage,
        'is_favorite': 1,
      };

      await db.insert(
        'Favorites',
        mediaMap,
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

      return Favorites(
        id: maps[i]['id'],
        video: maps[i]['video'] == 1,
        overview: maps[i]['overview'] ?? '',
        voteAverage: maps[i]['vote_average'] ?? 0.0,
        posterPath: maps[i]['poster_path'] ?? '',
        title: maps[i]['title'] ?? '',
        genreIds: genreIds,
        isFavorite: maps[i]['is_favorite'] == 1,
      );
    });

    return favoriteMedia;
  }
}
