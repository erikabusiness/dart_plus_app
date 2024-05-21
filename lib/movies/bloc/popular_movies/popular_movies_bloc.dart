import 'package:dart_plus_app/movies/movie_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../models/popular_movies.dart';

part 'popular_movies_event.dart';

part 'popular_movies_state.dart';

class PopularMoviesBloc extends Bloc<PopularMoviesEvent, PopularMoviesState> {
  final _movieRepository = MovieRepository();

  PopularMoviesBloc() : super(MoviesInitial()) {
    on<PopularMoviesEvent>((event, emit) async {

      if (event is GetAllPopularMovies) {
        emit(const PopularMoviesLoading());
        try {
          List<PopularMovie> movies =
              await _movieRepository.getAllPopularMovies();
          emit(PopularMoviesLoaded(movies));
        } catch (_) {
          emit(const PopularMoviesError());
        }
      }
    });
  }
}
