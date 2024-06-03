import 'package:dart_plus_app/favorites/favorite_bloc.dart';
import 'package:dart_plus_app/movies/bloc/videos_popular_movie/videos_popular_movie_bloc.dart';
import 'package:dart_plus_app/routes/routes.dart';
import 'package:dart_plus_app/movies/bloc/popular_movies/popular_movies_bloc.dart';
import 'package:dart_plus_app/movies/bloc/top_rated_movies/top_rated_movies_bloc.dart';
import 'package:dart_plus_app/series/bloc/popular_series/popular_series_bloc.dart';
import 'package:dart_plus_app/view/catalogo_page.dart';
import 'package:dart_plus_app/view/details_page.dart';
import 'package:dart_plus_app/view/favorites_page.dart';
import 'package:dart_plus_app/view/home_page.dart';
import 'package:dart_plus_app/view/see_all_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => PopularMoviesBloc()),
        BlocProvider(create: (context) => TopRatedMoviesBloc()),
        BlocProvider(create: (context) => PopularSeriesBloc()),
        BlocProvider(create: (context) => VideosPopularMovieBloc()),
        BlocProvider(create: (context) => FavoriteBloc()),
      ],
      child: MaterialApp(
        initialRoute: NavRoutes.homePage,
        routes: {
          NavRoutes.homePage: (context) => const MyHomePage(),
          NavRoutes.details: (context) => const DetailsPage(),
          NavRoutes.seeAll: (context) => const SeeAll(),
          NavRoutes.favoritesPage: (context) => const FavoritesPage(),
          NavRoutes.catalogoPage: (context) => const CatalogoPage(),
        },
        title: 'Dart Plus',
        debugShowCheckedModeBanner: false,
        theme: ThemeData.dark(
          useMaterial3: true,
        ),
      ),
    );
  }
}
