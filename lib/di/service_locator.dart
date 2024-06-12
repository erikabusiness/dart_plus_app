import 'package:dart_plus_app/data/dao/favorites_dao_impl.dart';
import 'package:dart_plus_app/data/dao/popular_movies_dao.dart';
import 'package:dart_plus_app/data/repositories/movie_repository_impl.dart';
import 'package:dart_plus_app/data/services/http_client_impl.dart';
import 'package:dart_plus_app/domain/interfaces/repositories/movie_repository.dart';
import 'package:dart_plus_app/domain/interfaces/repositories/series_repository.dart';
import 'package:dart_plus_app/domain/interfaces/services/http_client.dart';
import 'package:dart_plus_app/presentation/bloc/favorites/favorite_bloc.dart';
import 'package:dart_plus_app/presentation/bloc/popular_series/popular_series_bloc.dart';
import 'package:dart_plus_app/presentation/bloc/top_rated_movies/top_rated_movies_bloc.dart';
import 'package:dart_plus_app/presentation/bloc/videos_popular_movie/videos_popular_movie_bloc.dart';
import 'package:get_it/get_it.dart';

import '../data/dao/popular_series_dao.dart';
import '../data/repositories/series_repository_impl.dart';
import '../domain/interfaces/dao/favorites_dao.dart';
import '../domain/interfaces/dao/popular_movie_dao.dart';
import '../domain/interfaces/dao/popular_serie_dao.dart';
import '../presentation/bloc/popular_movies/popular_movies_bloc.dart';

final GetIt getIt = GetIt.instance;

void setupServiceLocator() {
  // Register the HttpClient implementation
  getIt.registerLazySingleton<HttpClientInterface>(() => HttpClientImpl());

  // Register the DAO
  getIt.registerLazySingleton<PopularMoviesDaoInterface>(() => PopularMoviesDaoImpl());
  getIt.registerLazySingleton<PopularSeriesDaoInterface>(() => PopularSeriesDaoImpl());
  getIt.registerLazySingleton<FavoritesDao>(() => FavoritesDaoImpl());

  // Register the repository
  getIt.registerLazySingleton<MovieRepository>(() => MovieRepositoryImpl(httpClient: getIt<HttpClientInterface>()));
  getIt.registerLazySingleton<SeriesRepository>(() => SeriesRepositoryImpl(httpClient: getIt<HttpClientInterface>()));

  // Register the BLoCs
  getIt.registerFactory<PopularMoviesBloc>(
        () => PopularMoviesBloc(
      getIt<MovieRepository>(),
      getIt<PopularMoviesDaoInterface>(),
    ),
  );

  getIt.registerFactory<TopRatedMoviesBloc>(
        () => TopRatedMoviesBloc(
      getIt<MovieRepository>(),
      getIt<PopularMoviesDaoInterface>(),
    ),
  );

  getIt.registerFactory<VideosPopularMovieBloc>(
        () => VideosPopularMovieBloc(
      getIt<MovieRepository>(),
    ),
  );

  getIt.registerFactory<FavoriteBloc>(
          () => FavoriteBloc(
        getIt<FavoritesDao>(),
      )
  );

  getIt.registerFactory<PopularSeriesBloc>(
        () => PopularSeriesBloc(
      getIt<SeriesRepository>(),
      getIt<PopularSeriesDaoInterface>(),
    ),
  );
}
