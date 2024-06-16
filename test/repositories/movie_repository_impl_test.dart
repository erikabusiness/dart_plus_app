import 'dart:convert';

import 'package:dart_plus_app/data/dao/popular_movies_dao.dart';
import 'package:dart_plus_app/data/repositories/movie_repository_impl.dart';
import 'package:dart_plus_app/domain/interfaces/dao/popular_movie_dao.dart';
import 'package:dart_plus_app/domain/interfaces/models/movies/popular_movies.dart';
import 'package:dart_plus_app/domain/interfaces/services/http_client.dart';
import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';

void main() {
  group("Testes para verificar a chamada a API para filmes", () {
    test("Teste de chamada a API para filmes populares", () async {
      final movieRepository = MovieRepositoryImpl(httpClient: MockHttpClient());
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

class MockPopularMoviesDao extends Mock implements PopularMoviesDaoInterface {
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

  @override
  Future<int> buscarPopularMoviesNextPage() {
    // TODO: implement buscarPopularMoviesNextPage
    throw UnimplementedError();
  }

  @override
  Future<int> insertPopularMoviesNextPage(int nextPage) {
    // TODO: implement insertPopularMoviesNextPage
    throw UnimplementedError();
  }
}

class MockHttpClient extends Mock implements HttpClientInterface {
  final movie = generateRandomPopularMovie().toMap();

  Future<http.Response> get(Uri url, {Map<String, String>? headers}) async {
    return http.Response(
        jsonEncode({
          "results": [movie]
        }),
        200);
  }
}
