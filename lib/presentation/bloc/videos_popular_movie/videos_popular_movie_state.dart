part of 'videos_popular_movie_bloc.dart';

sealed class VideosPopularMovieState extends Equatable {
  const VideosPopularMovieState();
}

final class VideosPopularMovieInitial extends VideosPopularMovieState {
  @override
  List<Object> get props => [];
}

class TrailerPopularMovieLoading extends VideosPopularMovieState {

  const TrailerPopularMovieLoading();

  @override
  List<Object?> get props => [];
}


class TrailerPopularMovieLoaded extends VideosPopularMovieState {
  final String keyVideo;
  const TrailerPopularMovieLoaded(this.keyVideo);

  @override
  List<Object?> get props => [keyVideo];
}


class TrailerPopularMovieError extends VideosPopularMovieState {
  const TrailerPopularMovieError();

  @override
  List<Object?> get props => [];
}