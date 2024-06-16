import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/interfaces/dao/popular_serie_dao.dart';
import '../../../domain/interfaces/models/series/popular_series.dart';
import '../../../domain/interfaces/repositories/series_repository.dart';

part 'popular_series_event.dart';
part 'popular_series_state.dart';

class PopularSeriesBloc extends Bloc<PopularSeriesEvent, PopularSeriesState> {
  final SeriesRepository _seriesRepository;
  final PopularSeriesDaoInterface _dbRepository;

  PopularSeriesBloc(this._seriesRepository, this._dbRepository) : super(PopularSeriesInitial()) {
    on<PopularSeriesEvent>(
      (event, emit) async {
        if (event is LoadingDataBasePopularSeries) {
          emit(const PopularSeriesLoading());
          try {
            List<PopularSeries> movies = await _dbRepository.readPopularSeries();
            if (movies.isEmpty) {
              movies = await _seriesRepository.getAllPopularSeries();

              for (var movie in movies) {
                await _dbRepository.insertPopularSeries(movie);
              }
            }
            emit(PopularSeriesLoaded(movies));
          } catch (_) {
            emit(const PopularSeriesError());
          }
        }

        if (event is GetNextPopularSeries) {
          emit(const PopularSeriesLoading());
          try {
            int numberPage = await _dbRepository.buscarPopularSeriesNextPage();
            List<PopularSeries> movies = await _seriesRepository.getNextPopularSeries(numberPage);
            if (movies.isNotEmpty) {
              await _dbRepository.insertPopularSeriesNextPage(numberPage + 1);
              for (var movie in movies) {
                await _dbRepository.insertPopularSeries(movie);
              }
            }
            emit(PopularSeriesLoaded(movies));
          } catch (_) {
            emit(const PopularSeriesError());
          }
        }
      },
    );
  }
}
