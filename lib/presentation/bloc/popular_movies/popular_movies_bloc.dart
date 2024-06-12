// popular_movies_bloc.dart
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/interfaces/dao/popular_movie_dao.dart';
import '../../../domain/interfaces/models/movies/popular_movies.dart';
import '../../../domain/interfaces/repositories/movie_repository.dart';

part 'popular_movies_event.dart';
part 'popular_movies_state.dart';

class PopularMoviesBloc extends Bloc<PopularMoviesEvent, PopularMoviesState> {
  final MovieRepository _movieRepository;
  final PopularMoviesDaoInterface _dbRepository;

  PopularMoviesBloc(this._movieRepository, this._dbRepository) : super(MoviesInitial()) {
    on<PopularMoviesEvent>((event, emit) async {
      if (event is LoadingDataBasePopularMovies) {
        emit(const PopularMoviesLoading());
        try {
          List<PopularMovie> movies = await _dbRepository.readPopularMovies();
          if (movies.isEmpty) {
            movies = await _movieRepository.getAllPopularMovies();

            for (var movie in movies) {
              await _dbRepository.insertPopularMovies(movie);
            }
          }
          emit(PopularMoviesLoaded(movies));
        } catch (_) {
          emit(const PopularMoviesError());
        }
      }

      if (event is GetNextPopularMovies) {
        emit(const PopularMoviesLoading());
        try {
          int numberPage = await _dbRepository.buscarPopularMoviesNextPage();
          List<PopularMovie> movies = await _movieRepository.getNextPopularMovies(numberPage);
          if (movies.isNotEmpty) {
            await _dbRepository.insertPopularMoviesNextPage(numberPage + 1);
            for (var movie in movies) {
              await _dbRepository.insertPopularMovies(movie);
            }
          }
          emit(PopularMoviesLoaded(movies));
        } catch (_) {
          emit(const PopularMoviesError());
        }
      }
    });
  }
}
