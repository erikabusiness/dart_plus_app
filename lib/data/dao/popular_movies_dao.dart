import 'package:dart_plus_app/models/popular_movies.dart';
import '../database.dart';
import 'package:sqflite/sqflite.dart';

class PopularMoviesDao {
  final dbHelper = DatabaseHelper();

  Future<int> insertMovie(PopularMovie newMovie) async {
    final db = await dbHelper.database;
    if (db == null) {
      throw Exception("Database is null");
    }

    final res = await db.insert(
      'PopularMovies',
      newMovie.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    return res;
  }

  Future<List<PopularMovie>> getAllMovies() async {
    final db = await dbHelper.database;
    if (db == null) {
      throw Exception("Database is null");
    }
    final res = await db.rawQuery("SELECT * FROM Movies");
    List<PopularMovie> list =
        res.isNotEmpty ? res.map((c) => PopularMovie.fromJson(c)).toList() : [];

    return list;
  }

  Future<int> deleteAllMovies() async {
    final db = await dbHelper.database;
    if (db == null) {
      throw Exception("Database is null");
    }

    final res = await db.rawDelete('DELETE FROM Movies');
    return res;
  }
}
