import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../movie_repository.dart';

part 'videos_popular_movie_event.dart';
part 'videos_popular_movie_state.dart';

class VideosPopularMovieBloc extends Bloc<VideosPopularMovieEvent, VideosPopularMovieState> {

  final _movieRepository = MovieRepository();

  VideosPopularMovieBloc() : super(VideosPopularMovieInitial()) {
    on<VideosPopularMovieEvent>((event, emit) async {
      if (event is GetTrailerPopularMovies) {
        emit(const TrailerPopularMovieLoading());
        try {
          String videoKey = await _movieRepository.getFirstVideoKey(event.videoId);
          emit(TrailerPopularMovieLoaded(videoKey));
        } catch (_) {
          emit(const TrailerPopularMovieError());
        }
      }
    });
  }
}
