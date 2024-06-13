import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static Database? _database;
  static const String dbName = 'Media.db';

  Future<Database?> get database async {
    if (_database != null) return _database;

    _database = await initDatabase();
    return _database;
  }

  Future<Database> initDatabase() async {
    String path = join(await getDatabasesPath(), dbName);
    return await openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int version) async {
        await db.execute('''
          CREATE TABLE PopularMovies (
            id INTEGER PRIMARY KEY,
            video TEXT,
            title TEXT,
            poster_path TEXT,
            genre_ids TEXT, 
            overview TEXT,
            vote_average REAL,
            is_favorite INTEGER
          )
        ''');
        await db.execute('''
          CREATE TABLE PopularSeries (
            id INTEGER PRIMARY KEY,
            title TEXT,
            poster_path TEXT,
            genre_ids TEXT, 
            overview TEXT,
            vote_average REAL,
            is_favorite INTEGER
          )
        ''');
        await db.execute('''
           CREATE TABLE Favorites (
            id INTEGER PRIMARY KEY,
            video TEXT,
            title TEXT,
            poster_path TEXT,
            genre_ids TEXT, 
            overview TEXT,
            vote_average REAL,
            is_favorite INTEGER
          )
         ''');
        await db.execute('''
          CREATE TABLE PopularMoviesNextPage (
          next_page INTEGER
          )''');
        await db.execute('''
          CREATE TABLE PopularSeriesNextPage (
          next_page INTEGER
          )''');
      },
    );
  }
}
