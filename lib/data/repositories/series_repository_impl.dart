import 'dart:convert';

import 'package:dart_plus_app/domain/interfaces/repositories/series_repository.dart';

import '../../domain/interfaces/models/series/popular_series.dart';
import '../../domain/interfaces/services/http_client.dart';
import '../services/api_conections.dart';

class SeriesRepositoryImpl implements SeriesRepository {
  final HttpClientInterface httpClient;

  SeriesRepositoryImpl({
    required this.httpClient,
  });



  @override
  Future<List<PopularSeries>> getAllPopularSeries() async {
    try {
      final response =
          await httpClient.get(Uri.parse(ApiConnectionsUrl.getPopularSeriesUrl()));
      if (response.statusCode == 200) {
        Map<String, dynamic> jsonResponse = json.decode(response.body);
        List<dynamic> seriesJson = jsonResponse['results'];

        List<PopularSeries> series =
            seriesJson.map((series) => PopularSeries.fromJson(series)).toList();
        return series;
      } else {
        return [];
      }
    } catch (e) {
      throw Exception("Falha ao carregar os series populares");
    }
  }
}
