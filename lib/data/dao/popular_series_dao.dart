import 'dart:convert';
import '../../domain/interfaces/models/popular_series.dart';
import '../database.dart';
import 'package:sqflite/sqflite.dart';

abstract class PopularSeriesDaoInterface {
  Future<int> insertPopularSeries(PopularSeries newSerie);
  Future<void> updatePopularSeries(PopularSeries updateSerie);
  Future<List<PopularSeries>> readPopularSeries();
  Future<List<PopularSeries>> readPopularSeriesFavorites();
}

class PopularSeriesDao implements PopularSeriesDaoInterface{
  final dbHelper = DatabaseHelper();

  @override
  Future<int> insertPopularSeries(PopularSeries newSerie) async {
    final db = await dbHelper.database;
    if (db == null) {
      throw Exception('O banco de dados não foi inicializado corretamente');
    }

    final result = await db.insert(
      'PopularSeries',
      newSerie.toMap(),
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
      updateSerie.toMap(),
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

    List<PopularSeries> favoritePopularSeries = List.generate(maps.length, (i) {
      List<int> genreIds = jsonDecode(maps[i]['genre_ids']).cast<int>();
      List<String> originCountry = [
        maps[i]['origin_country'].split('[').last.split(']').first
      ];

      return PopularSeries(
        originalName: maps[i]['original_name'],
        originCountry: originCountry,
        id: maps[i]['id'],
        releaseDate: maps[i]['release_date'],
        originalLanguage: maps[i]['original_language'],
        overview: maps[i]['overview'],
        popularity: maps[i]['popularity'],
        voteAverage: maps[i]['vote_average'],
        voteCount: maps[i]['vote_count'],
        posterPath: maps[i]['poster_path'],
        backdropPath: maps[i]['backdrop_path'],
        adult: maps[i]['adult'] == 'true',
        title: maps[i]['title'],
        genreIds: genreIds,
        isFavorite: maps[i]['is_favorite'] == 1,
      );
    });

    return favoritePopularSeries;
  }

  @override
  Future<List<PopularSeries>> readPopularSeries() async {
    final db = await dbHelper.database;

    if (db == null) {
      throw Exception('O banco de dados não foi inicializado corretamente');
    }

    List<Map<String, dynamic>> maps = await db.query('PopularSeries');

    List<PopularSeries> popularSerie = List.generate(maps.length, (i) {
      List<int> genreIds = jsonDecode(maps[i]['genre_ids']).cast<int>();
      List<String> originCountry = [
        maps[i]['origin_country'].split('[').last.split(']').first
      ];

      return PopularSeries(
        id: maps[i]['id'],
        releaseDate: maps[i]['release_date'],
        originalLanguage: maps[i]['original_language'],
        overview: maps[i]['overview'],
        popularity: maps[i]['popularity'],
        voteAverage: maps[i]['vote_average'],
        voteCount: maps[i]['vote_count'],
        posterPath: maps[i]['poster_path'],
        backdropPath: maps[i]['backdrop_path'],
        adult: maps[i]['adult'] == 'true',
        title: maps[i]['title'],
        genreIds: genreIds,
        isFavorite: maps[i]['is_favorite'] == 1,
        originalName: maps[i]['original_name'],
        originCountry: originCountry,
      );
    });

    return popularSerie;
  }
}
