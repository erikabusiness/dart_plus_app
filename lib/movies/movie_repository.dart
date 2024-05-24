import 'dart:convert';
import 'package:dart_plus_app/data/dao/popular_movies_dao.dart';
import 'package:http/http.dart' as http;
import '../models/popular_movies.dart';
import '../routes/api_conections.dart';

class MovieRepository {
  Future<List<PopularMovie>> getAllPopularMovies() async {
    final response =
        await http.get(Uri.parse(ApiConectionsUrl.getAllPopularMoviesUrl));

    if (response.statusCode == 200) {
      Map<String, dynamic> jsonResponse = json.decode(response.body);
      List<dynamic> moviesJson = jsonResponse['results'];
      List<PopularMovie> movies =
          moviesJson.map((movie) => PopularMovie.fromJson(movie)).toList();

      for (var movie in movies) {
        await PopularMoviesDao().insertMovie(movie);
      }

      return movies;
    } else {
      throw Exception("Falha ao carregar os filmes populares");
    }
  }

  Future<List<PopularMovie>> getAllTrhendMovies() async {
    final response =
        await http.get(Uri.parse(ApiConectionsUrl.getAllTrhendsMoviesUrl));

    if (response.statusCode == 200) {
      Map<String, dynamic> jsonResponse = json.decode(response.body);
      List<dynamic> moviesJson = jsonResponse['results'];
      return moviesJson.map((movie) => PopularMovie.fromJson(movie)).toList();
    } else {
      throw Exception("Falha ao carregar os filmes mais votados");
    }
  }

  Future<String> getFirstVideoKey(int videoId) async {
    final response = await http
        .get(Uri.parse(ApiConectionsUrl.getTrailerPopularMovieUrl("$videoId")));

    if (response.statusCode == 200) {
      Map<String, dynamic> jsonResponse = json.decode(response.body);
      List<dynamic> videosJson = jsonResponse['results'];
      if (videosJson.isNotEmpty) {
        Map<String, dynamic> firstVideo = videosJson[0];
        return firstVideo['key'];
      } else {
        throw Exception("Não há vídeos disponíveis");
      }
    } else {
      throw Exception("Falha ao carregar os vídeos");
    }
  }
}
