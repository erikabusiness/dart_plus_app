import 'package:dart_plus_app/data/connection_status.dart';
import 'package:dart_plus_app/data/dao/popular_series_dao.dart';
import 'package:dart_plus_app/data/repositories/series_repository_impl.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/interfaces/models/series/popular_series.dart';

part 'popular_series_event.dart';

part 'popular_series_state.dart';

class PopularSeriesBloc extends Bloc<PopularSeriesEvent, PopularSeriesState> {
  final _seriesRepository = SeriesRepositoryImpl();
  final dbRepository = PopularSeriesDao();

  PopularSeriesBloc() : super(PopularSeriesInitial()) {
    on<PopularSeriesEvent>(
      (event, emit) async {
        if (event is GetAllPopularSeries) {
          emit(const PopularSeriesLoading());
          try {
            List<PopularSeries> series;
            if (await isConnectedToInternet()) {
              series = await _seriesRepository.getAllPopularSeries();
            } else {
              series = await dbRepository.readPopularSeries();
            }
            emit(PopularSeriesLoaded(series));
          } catch (_) {
            emit(const PopularSeriesError());
          }
        }
      },
    );
  }
}
