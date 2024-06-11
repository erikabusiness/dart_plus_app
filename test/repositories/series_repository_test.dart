import 'dart:convert';
import 'package:dart_plus_app/data/dao/popular_series_dao.dart';
import 'package:dart_plus_app/data/repositories/series_repository_impl.dart';
import 'package:dart_plus_app/domain/interfaces/models/series/popular_series.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;

void main() {
  group("Testes para verificar a chamada a API para séries", () {
    test("Teste de chamada a API para séries populares", () async {

      final serie = PopularSeries.fromJson({
        "id": 123,
        "release_date": "2023-01-01",
        "original_name": "Example PopularSeries",
        "origin_country": ['EX'],
        "title": "Example PopularSeries Title",
        "poster_path": "/path/to/poster.jpg",
        "adult": false,
        "backdrop_path": "/path/to/backdrop.jpg",
        "genre_ids": [28, 12, 16],
        "original_language": "en",
        "overview": "This is an example PopularSeries overview.",
        "popularity": 150.5,
        "vote_average": 7.8,
        "vote_count": 1234,
        "is_favorite": false
      }
      ).toMap();

      final serie2 = PopularSeries.fromJson({
        "id": 123,
        "release_date": "2023-01-01",
        "original_name": "Example PopularSeries",
        "origin_country": ['EX'],
        "title": "Example PopularSeries Title",
        "poster_path": "/path/to/poster.jpg",
        "adult": false,
        "backdrop_path": "/path/to/backdrop.jpg",
        "genre_ids": [28, 12, 16],
        "original_language": "en",
        "overview": "This is an example PopularSeries overview.",
        "popularity": 150.5,
        "vote_average": 7.8,
        "vote_count": 1234,
        "is_favorite": false
      }
      ).toMap();


     Future<http.Response> mockGet(Uri url, {Map<String, String>? headers}) async {
        return http.Response(jsonEncode({"results": [serie, serie2]}), 200);
      }

      final serieRepository = SeriesRepositoryImpl(mockGet, MockPopularSeriesDao());
      final getAllPopularSeries = await serieRepository.getAllPopularSeries();

      expect(getAllPopularSeries.length, 2);

    });
  });
}

class MockPopularSeriesDao implements PopularSeriesDaoInterface {
  @override
  Future<int> insertPopularSeries(PopularSeries newMo) async{
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
  Future<void> updatePopularSeries(PopularSeries updatesPopularSeries) async {
  }

}