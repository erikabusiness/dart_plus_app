import 'package:dart_plus_app/models/popular_Series.dart';
import '../database.dart';
import 'package:sqflite/sqflite.dart';

class PopularSeriesDao {
  final dbHelper = DatabaseHelper();

  Future<int> insertSeries(PopularSeries newSeries) async {
    final db = await dbHelper.database;
    if (db == null) {
      throw Exception("Database is null");
    }

    final res = await db.insert(
      'PopularSeries',
      newSeries.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    return res;
  }

  Future<List<PopularSeries>> getAllSeries() async {
    final db = await dbHelper.database;
    if (db == null) {
      throw Exception("Database is null");
    }
    final res = await db.rawQuery("SELECT * FROM Series");
    List<PopularSeries> list = res.isNotEmpty
        ? res.map((c) => PopularSeries.fromJson(c)).toList()
        : [];

    return list;
  }

  Future<int> deleteAllSeries() async {
    final db = await dbHelper.database;
    if (db == null) {
      throw Exception("Database is null");
    }

    final res = await db.rawDelete('DELETE FROM Series');
    return res;
  }
}
