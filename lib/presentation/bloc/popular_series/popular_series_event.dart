part of 'popular_series_bloc.dart';

sealed class PopularSeriesEvent extends Equatable {
  const PopularSeriesEvent();
}

class GetAllPopularSeries extends PopularSeriesEvent {
  const GetAllPopularSeries();

  @override
  List<Object> get props => [];
}

class LoadingDataBasePopularSeries extends PopularSeriesEvent {
  const LoadingDataBasePopularSeries();

  @override
  List<Object> get props => [];
}

class GetNextPopularSeries extends PopularSeriesEvent {
  const GetNextPopularSeries();

  @override
  List<Object> get props => [];
}


