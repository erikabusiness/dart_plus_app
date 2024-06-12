import 'dart:convert';

import 'package:dart_plus_app/domain/interfaces/repositories/movie_repository.dart';
import 'package:dart_plus_app/domain/interfaces/services/http_client.dart';
import 'package:http/http.dart' as http;

import '../../domain/interfaces/models/movies/popular_movies.dart';
import '../services/api_conections.dart';

class MovieRepositoryImpl implements MovieRepository {

  final HttpClientInterface httpClient;

  MovieRepositoryImpl({
    required this.httpClient,
  });


  @override
  Future<List<PopularMovie>> getAllPopularMovies() async {
    try {
      final response =
      await httpClient.get(Uri.parse(ApiConnectionsUrl.getPopularMoviesUrl()));

      if (response.statusCode == 200) {
        Map<String, dynamic> jsonResponse = json.decode(response.body);
        List<dynamic> moviesJson = jsonResponse['results'];

        List<PopularMovie> movies =
        moviesJson.map((movie) => PopularMovie.fromJson(movie)).toList();

        return movies;
      } else {
        return [];
      }
    } catch (e) {
      throw Exception("Falha ao carregar os filmes populares");
    }
  }

  @override
  Future<List<PopularMovie>> getAllTrhendMovies() async {
    final response =
    await http.get(Uri.parse(ApiConnectionsUrl.getTrendingMoviesUrl()));

    if (response.statusCode == 200) {
      Map<String, dynamic> jsonResponse = json.decode(response.body);
      List<dynamic> moviesJson = jsonResponse['results'];
      List<PopularMovie> movies =
      moviesJson.map((movie) => PopularMovie.fromJson(movie)).toList();

      return movies;
    } else {
      throw Exception("Falha ao carregar os filmes mais votados");
    }
  }

  @override
  Future<String> getFirstVideoKey(int videoId) async {
    final response = await http
        .get(Uri.parse(ApiConnectionsUrl.getTrailerUrl("$videoId")));

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

  @override
  Future<List<PopularMovie>> getNextPopularMovies(int pageId) async {
    try {
      final response = await httpClient.get(
          Uri.parse(ApiConnectionsUrl.getPopularMoviesUrl(pageId: pageId)));

      if (response.statusCode == 200) {
        Map<String, dynamic> jsonResponse = json.decode(response.body);
        List<dynamic> moviesJson = jsonResponse['results'];

        List<PopularMovie> movies =
        moviesJson.map((movie) => PopularMovie.fromJson(movie)).toList();
        return movies;
      } else {
        return [];
      }
    } catch (e) {
      throw Exception("Falha ao carregar os filmes populares");
    }
  }
}
