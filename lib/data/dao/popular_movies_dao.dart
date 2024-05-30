import 'dart:convert';
import 'package:dart_plus_app/models/popular_movies.dart';
import '../database.dart';
import 'package:sqflite/sqflite.dart';

class PopularMoviesDao {
  final dbHelper = DatabaseHelper();

  Future<int> insertPopularMovies(PopularMovie newMovie) async {
    final db = await dbHelper.database;
    if (db == null) {
      throw Exception('O banco de dados não foi inicializado corretamente');
    }

    final result = await db.insert(
      'PopularMovies',
      newMovie.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    return result;
  }

  Future<void> updatePopularMovies(PopularMovie updateMovie) async {
    final db = await dbHelper.database;
    if (db == null) {
      throw Exception('O banco de dados não foi inicializado corretamente');
    }

    await db.update(
      'PopularMovies',
      updateMovie.toMap(),
      where: 'id = ?',
      whereArgs: [updateMovie.id],
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<PopularMovie>> readPopularMovies() async {
    final db = await dbHelper.database;
    if (db == null) {
      throw Exception('O banco de dados não foi inicializado corretamente');
    }
    List<Map<String, dynamic>> maps = await db.query('PopularMovies');

    List<PopularMovie> popularMovie = List.generate(maps.length, (i) {
      List<int> genreIds = jsonDecode(maps[i]['genre_ids']).cast<int>();

      return PopularMovie(
        originalTitle: maps[i]['origin_title'] ?? '',
        video: maps[i]['video'] == 'true',
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

    return popularMovie;
  }

  Future<List<PopularMovie>> readPopularMoviesFavorites() async {
    final db = await dbHelper.database;
    if (db == null) {
      throw Exception('O banco de dados não foi inicializado corretamente');
    }

    List<Map<String, dynamic>> maps = await db.query(
      'PopularMovies',
      where: 'is_favorite = ?',
      whereArgs: [1],
    );

    List<PopularMovie> favoritePopularMovie = List.generate(maps.length, (i) {
      List<int> genreIds = jsonDecode(maps[i]['genre_ids']).cast<int>();

      return PopularMovie(
        originalTitle: maps[i]['origin_title'] ?? '',
        video: maps[i]['video'] == 'true',
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

    return favoritePopularMovie;
  }
}
