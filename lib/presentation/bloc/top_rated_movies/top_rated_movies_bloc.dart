import 'package:dart_plus_app/data/connection_status.dart';
import 'package:dart_plus_app/data/dao/popular_movies_dao.dart';
import 'package:dart_plus_app/data/repositories/movie_repository_impl.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/interfaces/models/movies/popular_movies.dart';

part 'top_rated_movies_event.dart';

part 'top_rated_movies_state.dart';

class TopRatedMoviesBloc extends Bloc<TrhendMoviesEvent, TrhendMoviesState> {
  final _movieRepository = MovieRepositoryImpl();
  final dbRepository = PopularMoviesDao();

  TopRatedMoviesBloc() : super(TrhendMoviesInitial()) {
    on<TrhendMoviesEvent>((event, emit) async {
      if (event is GetAllTrhendMovies) {
        emit(const TrhendMoviesLoading());
        try {
          List<PopularMovie> movies;
          if (await isConnectedToInternet()) {
            movies = await _movieRepository.getAllTrhendMovies();
          } else {
            movies = await dbRepository.readPopularMovies();
          }
          emit(TrhendMoviesLoaded(movies));
        } catch (_) {
          emit(const TrhendMoviesError());
        }
      }
    });
  }
}
