import '../models/movies/popular_movies.dart';

abstract class MovieRepository {
  Future<List<PopularMovie>> getAllPopularMovies();
  Future<List<PopularMovie>> getAllTrhendMovies();
  Future<String> getFirstVideoKey(int videoId);
  Future<List<PopularMovie>> getNextPopularMovies(int pageId);
}