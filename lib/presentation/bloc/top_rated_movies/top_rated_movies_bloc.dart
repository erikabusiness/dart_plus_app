import 'package:dart_plus_app/data/services/connection_status.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/interfaces/dao/popular_movie_dao.dart';
import '../../../domain/interfaces/models/movies/popular_movies.dart';
import '../../../domain/interfaces/repositories/movie_repository.dart';

part 'top_rated_movies_event.dart';
part 'top_rated_movies_state.dart';

class TopRatedMoviesBloc extends Bloc<TrhendMoviesEvent, TrhendMoviesState> {
  final MovieRepository _movieRepository;
  final PopularMoviesDaoInterface _dbRepository;

  TopRatedMoviesBloc(this._movieRepository, this._dbRepository)
      : super(TrhendMoviesInitial()) {
    on<TrhendMoviesEvent>((event, emit) async {
      if (event is GetAllTrhendMovies) {
        emit(const TrhendMoviesLoading());
        try {
          List<PopularMovie> movies;
          if (await isConnectedToInternet()) {
            movies = await _movieRepository.getAllTrhendMovies();
          } else {
            movies = await _dbRepository.readPopularMovies();
          }
          emit(TrhendMoviesLoaded(movies));
        } catch (_) {
          emit(const TrhendMoviesError());
        }
      }
    });
  }
}
