import 'package:dart_plus_app/models/popular_series.dart';
import 'package:dart_plus_app/series/series_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'popular_series_event.dart';

part 'popular_series_state.dart';

class PopularSeriesBloc extends Bloc<PopularSeriesEvent, PopularSeriesState> {
  final _seriesRepository = SeriesRepository();

  PopularSeriesBloc() : super(PopularSeriesInitial()) {
    on<PopularSeriesEvent>(
      (event, emit) async {
        if (event is GetAllPopularSeries) {
          emit(const PopularSeriesLoading());
          try {
            List<PopularSeries> series =
                await _seriesRepository.getAllPopularSeries();
            emit(PopularSeriesLoaded(series));
          } catch (_) {
            emit(const PopularSeriesError());
          }
        }
      },
    );
  }
}
