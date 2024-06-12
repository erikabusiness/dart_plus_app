import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/interfaces/dao/popular_serie_dao.dart';
import '../../../domain/interfaces/models/series/popular_series.dart';
import '../../../domain/interfaces/repositories/series_repository.dart';

part 'popular_series_event.dart';
part 'popular_series_state.dart';

class PopularSeriesBloc extends Bloc<PopularSeriesEvent, PopularSeriesState> {
  final SeriesRepository _seriesRepository;
  final PopularSeriesDaoInterface dbRepository;

  PopularSeriesBloc(this._seriesRepository, this.dbRepository) : super(PopularSeriesInitial()) {
    on<PopularSeriesEvent>(
      (event, emit) async {
        if (event is GetAllPopularSeries) {
          emit(const PopularSeriesLoading());
          try {
            List<PopularSeries> series = await dbRepository.readPopularSeries();
            if (series.isEmpty) {
              series = await _seriesRepository.getAllPopularSeries();
              for (var serie in series) {
                await dbRepository.insertPopularSeries(serie);
              }
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
