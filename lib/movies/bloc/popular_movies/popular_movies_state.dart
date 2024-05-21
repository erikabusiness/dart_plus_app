part of 'popular_movies_bloc.dart';

sealed class PopularMoviesState extends Equatable {
  const PopularMoviesState();
}

final class MoviesInitial extends PopularMoviesState {
  @override
  List<Object> get props => [];
}

class PopularMoviesLoading extends PopularMoviesState {
  const PopularMoviesLoading();

  @override
  List<Object> get props => [];
}

class PopularMoviesLoaded extends PopularMoviesState {
  final List<PopularMovie> movies;

  const PopularMoviesLoaded(this.movies);

  @override
  List<Object> get props => [movies];
}

class PopularMoviesError extends PopularMoviesState {
  const PopularMoviesError();

  @override
  List<Object> get props => [];
}


