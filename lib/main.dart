import 'package:dart_plus_app/presentation/bloc/favorites/favorite_bloc.dart';
import 'package:dart_plus_app/presentation/bloc/popular_movies/popular_movies_bloc.dart';
import 'package:dart_plus_app/presentation/bloc/popular_series/popular_series_bloc.dart';
import 'package:dart_plus_app/presentation/bloc/top_rated_movies/top_rated_movies_bloc.dart';
import 'package:dart_plus_app/presentation/bloc/videos_popular_movie/videos_popular_movie_bloc.dart';
import 'package:dart_plus_app/routes/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'di/service_locator.dart';

void main() async {
  setupServiceLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => getIt<FavoriteBloc>()),
        BlocProvider(create: (_) => getIt<PopularMoviesBloc>()),
        BlocProvider(create: (_) => getIt<TopRatedMoviesBloc>()),
        BlocProvider(create: (_) => getIt<PopularSeriesBloc>()),
        BlocProvider(create: (_) => getIt<VideosPopularMovieBloc>()),
      ],
      child: MaterialApp.router(
      routerConfig: _appRouter.config(),
        title: 'Dart Plus',
        debugShowCheckedModeBanner: false,
        theme: ThemeData.dark(
          useMaterial3: true,
        ),
      ),
    );
  }
}
