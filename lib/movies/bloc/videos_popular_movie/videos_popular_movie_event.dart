part of 'videos_popular_movie_bloc.dart';

sealed class VideosPopularMovieEvent extends Equatable {
  const VideosPopularMovieEvent();
}

class GetTrailerPopularMovies extends VideosPopularMovieEvent {
  final int videoId;
  const GetTrailerPopularMovies(this.videoId);

  @override
  List<Object?> get props => [videoId];
}