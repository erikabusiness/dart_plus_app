import 'dart:convert';

import 'package:dart_plus_app/data/dao/popular_movies_dao.dart';
import 'package:dart_plus_app/data/repositories/movie_repository_impl.dart';
import 'package:dart_plus_app/domain/interfaces/models/movies/popular_movies.dart';
import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;

void main() {
  group("Testes para verificar a chamada a API para filmes", () {
    test("Teste de chamada a API para filmes populares", () async {
      final movie = generateRandomPopularMovie().toMap();

      Future<http.Response> mockGet(Uri url,
          {Map<String, String>? headers}) async {
        return http.Response(
            jsonEncode({
              "results": [movie]
            }),
            200);
      }

      final movieRepository =
          MovieRepositoryImpl(mockGet, MockPopularMoviesDao());
      final getAllMovies = await movieRepository.getAllPopularMovies();

      expect(getAllMovies.length, 1);
    });
  });
}

PopularMovie generateRandomPopularMovie() {
  final faker = Faker();
  return PopularMovie(
    id: faker.randomGenerator.integer(1000),
    title: faker.lorem.sentence(),
    posterPath: faker.image.image(),
    genreIds: List.generate(3, (_) => faker.randomGenerator.integer(30)),
    overview: faker.lorem.sentences(3).join(' '),
    voteAverage: faker.randomGenerator.decimal(min: 0),
    isFavorite: faker.randomGenerator.boolean(),
  );
}

class MockPopularMoviesDao implements PopularMoviesDaoInterface {
  @override
  Future<int> insertPopularMovies(PopularMovie newMovie) async {
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
  Future<void> updatePopularMovies(PopularMovie updateMovie) async {}
}
