import 'dart:convert';

import 'package:dart_plus_app/data/dao/popular_series_dao.dart';
import 'package:dart_plus_app/domain/interfaces/repositories/series_repository.dart';
import 'package:http/http.dart' as http;

import '../../domain/interfaces/models/series/popular_series.dart';
import '../api_conections.dart';

class SeriesRepositoryImpl implements SeriesRepository {
  SeriesRepositoryImpl(
      [Future<http.Response> get(Uri url, {Map<String, String>? headers})?,
      PopularSeriesDaoInterface? popularSeriesDao])
      : get = get ?? http.get,
        popularSeriesDao = popularSeriesDao ?? PopularSeriesDao();

  final Future<http.Response> Function(Uri url, {Map<String, String>? headers})
      get;

  final PopularSeriesDaoInterface popularSeriesDao;

  @override
  Future<List<PopularSeries>> getAllPopularSeries() async {
    try {
      final response =
          await get(Uri.parse(ApiConectionsUrl.getAllPopularSeriesUrl));
      if (response.statusCode == 200) {
        Map<String, dynamic> jsonResponse = json.decode(response.body);
        List<dynamic> seriesJson = jsonResponse['results'];

        List<PopularSeries> series =
            seriesJson.map((series) => PopularSeries.fromJson(series)).toList();
        for (var serie in series) {
          await popularSeriesDao.insertPopularSeries(serie);
        }
        return series;
      } else {
        List<PopularSeries> series = await popularSeriesDao.readPopularSeries();
        return series;
      }
    } catch (e) {
      throw Exception("Falha ao carregar os series populares");
    }
  }
}
