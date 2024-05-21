part of 'popular_movies_bloc.dart';

sealed class PopularMoviesEvent extends Equatable {
  const PopularMoviesEvent();
}

class GetAllPopularMovies extends PopularMoviesEvent {
  const GetAllPopularMovies();

  @override
  List<Object> get props => [];
}


