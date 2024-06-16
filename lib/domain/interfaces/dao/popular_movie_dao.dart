import '../models/movies/popular_movies.dart';

abstract class PopularMoviesDaoInterface {
  Future<int> insertPopularMovies(PopularMovie newMovie);
  Future<void> updatePopularMovies(PopularMovie updateMovie);
  Future<List<PopularMovie>> readPopularMovies();
  Future<List<PopularMovie>> readPopularMoviesFavorites();
  Future<int> insertPopularMoviesNextPage(int nextPage);
  Future<int> buscarPopularMoviesNextPage();
}