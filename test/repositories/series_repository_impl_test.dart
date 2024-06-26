import 'dart:convert';
import 'package:dart_plus_app/data/dao/popular_series_dao.dart';
import 'package:dart_plus_app/data/repositories/series_repository_impl.dart';
import 'package:dart_plus_app/domain/interfaces/dao/popular_serie_dao.dart';
import 'package:dart_plus_app/domain/interfaces/models/series/popular_series.dart';
import 'package:dart_plus_app/domain/interfaces/services/http_client.dart';
import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';

void main() {
  group("Testes para verificar a chamada a API para séries", () {
    test("Teste de chamada a API para séries populares", () async {
      final serieRepository =
          SeriesRepositoryImpl(httpClient: MockHttpClient());
      final getAllPopularSeries = await serieRepository.getAllPopularSeries();

      expect(getAllPopularSeries.length, 2);
    });
  });
}

PopularSeries generateRandomPopularSeries() {
  final faker = Faker();
  return PopularSeries(
    id: faker.randomGenerator.integer(1000),
    title: faker.lorem.sentence(),
    posterPath: faker.image.image(),
    genreIds: List.generate(3, (_) => faker.randomGenerator.integer(30)),
    overview: faker.lorem.sentences(3).join(' '),
    voteAverage: faker.randomGenerator.decimal(min: 0),
    isFavorite: faker.randomGenerator.boolean(),
  );
}

class MockPopularSeriesDao implements PopularSeriesDaoInterface {
  @override
  Future<int> insertPopularSeries(PopularSeries newMo) async {
    return 2;
  }

  @override
  Future<List<PopularSeries>> readPopularSeries() async {
    return [];
  }

  @override
  Future<List<PopularSeries>> readPopularSeriesFavorites() async {
    return [];
  }

  @override
  Future<void> updatePopularSeries(PopularSeries updatesPopularSeries) async {}

  @override
  Future<int> buscarPopularSeriesNextPage() {
    // TODO: implement buscarPopularSeriesNextPage
    throw UnimplementedError();
  }

  @override
  Future<int> insertPopularSeriesNextPage(int nextPage) {
    // TODO: implement insertPopularSeriesNextPage
    throw UnimplementedError();
  }
}

class MockHttpClient extends Mock implements HttpClientInterface {
  final serie = generateRandomPopularSeries().toMap();
  final serie2 = generateRandomPopularSeries().toMap();

  Future<http.Response> get(Uri url, {Map<String, String>? headers}) async {
    return http.Response(
        jsonEncode({
          "results": [serie, serie2]
        }),
        200);
  }
}
