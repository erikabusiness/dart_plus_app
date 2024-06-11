import 'dart:convert';

import 'package:dart_plus_app/data/dao/popular_movies_dao.dart';
import 'package:dart_plus_app/data/repositories/movie_repository_impl.dart';
import 'package:dart_plus_app/domain/interfaces/models/movies/popular_movies.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;

void main() {
  group("Testes para verificar a chamada a API para filmes", () {
    test("Teste de chamada a API para filmes populares", () async {

      final movie = PopularMovie.fromJson({
        "id": 123,
        "release_date": "2023-01-01",
        "original_title": "Example Movie",
        "video": false,
        "title": "Example Movie Title",
        "poster_path": "/path/to/poster.jpg",
        "adult": false,
        "backdrop_path": "/path/to/backdrop.jpg",
        "genre_ids": [28, 12, 16],
        "original_language": "en",
        "overview": "This is an example movie overview.",
        "popularity": 150.5,
        "vote_average": 7.8,
        "vote_count": 1234,
        "is_favorite": false
      }
      ).toMap();

     Future<http.Response> mockGet(Uri url, {Map<String, String>? headers}) async {
        return http.Response(jsonEncode({"results": [movie]}), 200);
      }

      final movieRepository = MovieRepositoryImpl(mockGet, MockPopularMoviesDao());
      final getAllMovies = await movieRepository.getAllPopularMovies();

      expect(getAllMovies.length, 1);

    });
  });
}

class MockPopularMoviesDao implements PopularMoviesDaoInterface {
  @override
  Future<int> insertPopularMovies(PopularMovie newMovie) async{
    return 2;
  }

  @override
  Future<List<PopularMovie>> readPopularMovies() async {

    return [];
  }

  @override
  Future<List<PopularMovie>> readPopularMoviesFavorites() async {

    return [];
  }

  @override
  Future<void> updatePopularMovies(PopularMovie updateMovie) async {
  }


}