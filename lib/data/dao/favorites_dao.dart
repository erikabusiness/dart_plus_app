import 'package:dart_plus_app/data/database.dart';
import 'package:dart_plus_app/models/media.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

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
        media.toJson(),
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

  Future<List<int>> getFavorites() async {
    final db = await dbHelper.database;
    if (db == null) {
      throw Exception('O banco de dados não foi inicializado corretamente');
    }

    final result =
        await db.rawQuery('SELECT id FROM Favorites WHERE is_favorite = 1');
    return result.isNotEmpty
        ? result.map<int>((e) => e['id'] as int).toList()
        : [];
  }
}
