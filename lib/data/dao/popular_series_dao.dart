import 'dart:convert';
import '../../domain/interfaces/models/series/popular_series.dart';
import '../database.dart';
import 'package:sqflite/sqflite.dart';

abstract class PopularSeriesDaoInterface {
  Future<int> insertPopularSeries(PopularSeries newSerie);
  Future<void> updatePopularSeries(PopularSeries updateSerie);
  Future<List<PopularSeries>> readPopularSeries();
  Future<List<PopularSeries>> readPopularSeriesFavorites();
}

class PopularSeriesDao implements PopularSeriesDaoInterface {
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
      'is_favorite': series.isFavorite! ? 1 : 0,
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
}
