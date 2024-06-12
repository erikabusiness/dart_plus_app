import 'dart:convert';
import '../../domain/interfaces/dao/popular_movie_dao.dart';
import '../../domain/interfaces/models/movies/popular_movies.dart';
import '../database.dart';
import 'package:sqflite/sqflite.dart';

class PopularMoviesDaoImpl implements PopularMoviesDaoInterface {
  final dbHelper = DatabaseHelper();

  @override
  Future<int> insertPopularMovies(PopularMovie newMovie) async {
    final db = await dbHelper.database;
    if (db == null) {
      throw Exception('O banco de dados não foi inicializado corretamente');
    }

    final existingMovies = await db.query(
      'PopularMovies',
      where: 'id = ?',
      whereArgs: [newMovie.id],
    );

    if (existingMovies.isNotEmpty) {
      return -1;
    } else {
      final result = await db.insert(
        'PopularMovies',
        newMovie.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      return result;
    }
  }


  @override
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

  @override
  Future<List<PopularMovie>> readPopularMovies() async {
    final db = await dbHelper.database;
    if (db == null) {
      throw Exception('O banco de dados não foi inicializado corretamente');
    }
    List<Map<String, dynamic>> maps = await db.query('PopularMovies');

    List<PopularMovie> popularMovie = List.generate(maps.length, (i) {
      List<int> genreIds = (maps[i]['genre_ids']).cast<int>();

      return PopularMovie(
        video: maps[i]['video'] == true,
        id: maps[i]['id'],
        overview: maps[i]['overview'],
        voteAverage: maps[i]['vote_average'],
        posterPath: maps[i]['poster_path'],
        title: maps[i]['title'],
        genreIds: genreIds,
        isFavorite: maps[i]['is_favorite'] == true,
      );
    });

    return popularMovie;
  }

  @override
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
        video: maps[i]['video'] == 'true',
        id: maps[i]['id'],
        overview: maps[i]['overview'],
        voteAverage: maps[i]['vote_average'],
        posterPath: maps[i]['poster_path'],
        title: maps[i]['title'],
        genreIds: genreIds,
        isFavorite: maps[i]['is_favorite'] == 1,
      );
    });

    return favoritePopularMovie;
  }

  @override
  Future<int> buscarPopularMoviesNextPage() async {
    final db = await dbHelper.database;
    if (db == null) {
      throw Exception('O banco de dados não foi inicializado corretamente');
    }

    final List<Map<String, dynamic>> result = await db.query("PopularMoviesNextPage");

    if (result.isNotEmpty) {
      return result.first['next_page'] as int;
    } else {
      return 2;
    }
  }


  @override
  Future<int> insertPopularMoviesNextPage(int nextPage) async {
    final db = await dbHelper.database;
    if (db == null) {
      throw Exception('O banco de dados não foi inicializado corretamente');
    }

    final List<Map<String, dynamic>> result = await db.query("PopularMoviesNextPage");
    if (result.isNotEmpty) {
      return await db.update(
        "PopularMoviesNextPage",
        {'next_page': nextPage},
      );
    } else {
      return await db.insert(
        "PopularMoviesNextPage",
        {'next_page': nextPage},
      );
    }
  }





}
