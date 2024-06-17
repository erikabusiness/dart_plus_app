import 'package:dart_plus_app/data/repositories/movie_repository_impl.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/interfaces/repositories/movie_repository.dart';


part 'videos_popular_movie_event.dart';
part 'videos_popular_movie_state.dart';

class VideosPopularMovieBloc extends Bloc<VideosPopularMovieEvent, VideosPopularMovieState> {

  final MovieRepository _movieRepository;

  VideosPopularMovieBloc(this._movieRepository) : super(VideosPopularMovieInitial()) {
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
