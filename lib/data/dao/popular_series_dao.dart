import 'package:sqflite/sqflite.dart';

import '../../domain/interfaces/dao/popular_serie_dao.dart';
import '../../domain/interfaces/models/series/popular_series.dart';
import '../database.dart';

class PopularSeriesDaoImpl implements PopularSeriesDaoInterface {
  final dbHelper = DatabaseHelper();

  @override
  Future<int> insertPopularSeries(PopularSeries newSerie) async {
    final db = await dbHelper.database;
    if (db == null) {
      throw Exception('O banco de dados não foi inicializado corretamente');
    }

    final result = await db.insert(
      'PopularSeries',
      _toMap(newSerie),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    return result;
  }

  @override
  Future<void> updatePopularSeries(PopularSeries updateSerie) async {
    final db = await dbHelper.database;
    if (db == null) {
      throw Exception('O banco de dados não foi inicializado corretamente');
    }

    await db.update(
      'PopularSeries',
      _toMap(updateSerie),
      where: 'id = ?',
      whereArgs: [updateSerie.id],
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  @override
  Future<List<PopularSeries>> readPopularSeriesFavorites() async {
    final db = await dbHelper.database;
    if (db == null) {
      throw Exception('O banco de dados não foi inicializado corretamente');
    }

    List<Map<String, dynamic>> maps = await db.query(
      'PopularSeries',
      where: 'is_favorite = ?',
      whereArgs: [1],
    );

    List<PopularSeries> favoritePopularSeries = maps.map((map) {
      return _fromMap(map);
    }).toList();

    return favoritePopularSeries;
  }

  @override
  Future<List<PopularSeries>> readPopularSeries() async {
    final db = await dbHelper.database;

    if (db == null) {
      throw Exception('O banco de dados não foi inicializado corretamente');
    }

    List<Map<String, dynamic>> maps = await db.query('PopularSeries');

    List<PopularSeries> popularSeries = maps.map((map) {
      return _fromMap(map);
    }).toList();

    return popularSeries;
  }

  Map<String, dynamic> _toMap(PopularSeries series) {
    List<int> genreIds = (series.genreIds).cast<int>();

    return {
      'id': series.id,
      'title': series.title,
      'poster_path': series.posterPath,
      'genre_ids': genreIds,
      'overview': series.overview,
      'vote_average': series.voteAverage,
      'is_favorite': series.isFavorite ? 1 : 0,
    };
  }

  PopularSeries _fromMap(Map<String, dynamic> map) {
    return PopularSeries(
      id: map['id'],
      title: map['title'],
      posterPath: map['poster_path'],
      overview: map['overview'],
      voteAverage: map['vote_average'],
      isFavorite: map['is_favorite'] == 1,
      genreIds: map['genre_ids'],
    );
  }

  @override
  Future<int> buscarPopularSeriesNextPage() async {
    final db = await dbHelper.database;
    if (db == null) {
      throw Exception('O banco de dados não foi inicializado corretamente');
    }

    final List<Map<String, dynamic>> result = await db.query("PopularSeriesNextPage");

    if (result.isNotEmpty) {
      return result.first['next_page'] as int;
    } else {
      return 2;
    }
  }

  @override
  Future<int> insertPopularSeriesNextPage(int nextPage) async {
    final db = await dbHelper.database;
    if (db == null) {
      throw Exception('O banco de dados não foi inicializado corretamente');
    }

    final List<Map<String, dynamic>> result = await db.query("PopularSeriesNextPage");
    if (result.isNotEmpty) {
      return await db.update(
        "PopularSeriesNextPage",
        {'next_page': nextPage},
      );
    } else {
      return await db.insert(
        "PopularSeriesNextPage",
        {'next_page': nextPage},
      );
    }
  }
}
