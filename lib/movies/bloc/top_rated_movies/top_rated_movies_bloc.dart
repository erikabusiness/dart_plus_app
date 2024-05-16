import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../models/popular_movies.dart';
import '../../movie_repository.dart';

part 'top_rated_movies_event.dart';

part 'top_rated_movies_state.dart';

class TopRatedMoviesBloc
    extends Bloc<TrhendMoviesEvent, TrhendMoviesState> {
  final _movieRepository = MovieRepository();

  TopRatedMoviesBloc() : super(TrhendMoviesInitial()) {
    on<TrhendMoviesEvent>((event, emit) async {
      if (event is GetAllTrhendMovies) {
        emit(const TrhendMoviesLoading());
        try {
          List<PopularMovie> movies =
              await _movieRepository.getAllTrhendMovies();
          emit(TrhendMoviesLoaded(movies));
        } catch (_) {
          emit(const TrhendMoviesError());
        }
      }
    });
  }
}
