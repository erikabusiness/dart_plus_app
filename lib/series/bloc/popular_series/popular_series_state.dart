part of 'popular_series_bloc.dart';

sealed class PopularSeriesState extends Equatable {
  const PopularSeriesState();
}

final class PopularSeriesInitial extends PopularSeriesState {
  @override
  List<Object> get props => [];
}

//Estado para quando a lista de series populares esta em carregamento
class PopularSeriesLoading extends PopularSeriesState {
  const PopularSeriesLoading();

  @override
  List<Object> get props => [];
}

//Estado para quando a lista de series populares é carregada
class PopularSeriesLoaded extends PopularSeriesState {
  final List<PopularSeries> series;

  const PopularSeriesLoaded(this.series);

  @override
  List<Object> get props => [series];
}

//Estado para quando a lista de series populares retorna um erro
class PopularSeriesError extends PopularSeriesState {
  const PopularSeriesError();

  @override
  List<Object> get props => [];
}