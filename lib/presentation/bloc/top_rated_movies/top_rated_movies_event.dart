part of 'top_rated_movies_bloc.dart';

sealed class TrhendMoviesEvent extends Equatable {
  const TrhendMoviesEvent();
}

class GetAllTrhendMovies extends TrhendMoviesEvent {
  const GetAllTrhendMovies();

  @override
  List<Object> get props => [];
}


