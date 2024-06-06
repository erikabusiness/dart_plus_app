part of 'popular_series_bloc.dart';

sealed class PopularSeriesEvent extends Equatable {
  const PopularSeriesEvent();
}

class GetAllPopularSeries extends PopularSeriesEvent {
  const GetAllPopularSeries();

  @override
  List<Object> get props => [];
}


