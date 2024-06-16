part of 'top_rated_movies_bloc.dart';

sealed class TrhendMoviesState extends Equatable {
  const TrhendMoviesState();
}

final class TrhendMoviesInitial extends TrhendMoviesState {
  @override
  List<Object> get props => [];
}

//Estado para quando a lista de Filmes melhores avaliados esta em carregamento
class TrhendMoviesLoading extends TrhendMoviesState {
  const TrhendMoviesLoading();

  @override
  List<Object> get props => [];
}
//Estado para quando a lista de Filmes melhores avaliados é carregada
class TrhendMoviesLoaded extends TrhendMoviesState {
  final List<PopularMovie> movies;

  const TrhendMoviesLoaded(this.movies);

  @override
  List<Object> get props => [movies];
}

//Estado para quando a lista de Filmes melhores avaliados retorna um erro
class TrhendMoviesError extends TrhendMoviesState {
  const TrhendMoviesError();

  @override
  List<Object> get props => [];
}
