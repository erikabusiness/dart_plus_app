import 'package:dart_plus_app/data/database.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class FavoriteDao {
  final dbHelper = DatabaseHelper();

  Future<void> toggleFavorite(int mediaId, bool isFavorite) async {
    final db = await dbHelper.database;
    if (db == null) {
      throw Exception('O banco de dados não foi inicializado corretamente');
    }

    final count = Sqflite.firstIntValue(await db
        .rawQuery('SELECT COUNT(*) FROM Favorites WHERE id = ?', [mediaId]));

    if (count != null && count > 0) {
      await db.rawDelete('DELETE FROM Favorites WHERE id = ?', [mediaId]);
    } else {
      await db.rawInsert(
          'INSERT INTO Favorites (id, is_favorite) VALUES (?, ?)',
          [mediaId, 1]);
    }
  }

  Future<bool> isFavorite(int mediaId) async {
    final db = await dbHelper.database;
    if (db == null) {
      throw Exception('O banco de dados não foi inicializado corretamente');
    }

    final List<Map<String, dynamic>> result = await db.query(
      'Favorites',
      columns: ['id'],
      where: 'id = ?',
      whereArgs: [mediaId],
    );
    if (result.isNotEmpty) {
      return true;
    }
    return false;
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
