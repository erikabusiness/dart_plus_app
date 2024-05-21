import 'dart:convert';

import 'package:dart_plus_app/models/popular_series.dart';
import 'package:dart_plus_app/routes/api_conections.dart';
import 'package:http/http.dart' as http;

class SeriesRepository {
  final String _getAllPopularSeriesUrl =
      ApiConectionsUrl.getAllPopularSeriesUrl;

  Future<List<PopularSeries>> getAllPopularSeries() async {
    final response = await http.get(Uri.parse(_getAllPopularSeriesUrl));
    if (response.statusCode == 200) {
      Map<String, dynamic> jsonResponse = json.decode(response.body);
      List<dynamic> seriesJson = jsonResponse['results'];
      return seriesJson
          .map((series) => PopularSeries.fromJson(series))
          .toList();
    } else {
      throw Exception("Falha ao carregar os series populares");
    }
  }
}
