import 'dart:convert';
import 'package:dart_plus_app/models/popular_series.dart';
import '../database.dart';
import 'package:sqflite/sqflite.dart';

class PopularSeriesDao {
  final dbHelper = DatabaseHelper();

  Future<int> createPopularSeries(PopularSeries newSerie) async {
    final db = await dbHelper.database;
    if (db == null) {
      throw Exception('O banco de dados não foi inicializado corretamente');
    }

    final result = await db.insert(
      'PopularSeries',
      newSerie.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    return result;
  }

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
        isFavorite: maps[i]['is_favorite'] == 'true',
        originalName: maps[i]['original_name'],
        originCountry: originCountry,
      );
    });

    return popularSerie;
  }
}
