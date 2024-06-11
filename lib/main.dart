import 'package:dart_plus_app/presentation/bloc/favorites/favorite_bloc.dart';
import 'package:dart_plus_app/presentation/bloc/popular_movies/popular_movies_bloc.dart';
import 'package:dart_plus_app/presentation/bloc/popular_series/popular_series_bloc.dart';
import 'package:dart_plus_app/presentation/bloc/top_rated_movies/top_rated_movies_bloc.dart';
import 'package:dart_plus_app/presentation/bloc/videos_popular_movie/videos_popular_movie_bloc.dart';
import 'package:dart_plus_app/presentation/view/catalogo_page.dart';
import 'package:dart_plus_app/presentation/view/details_page.dart';
import 'package:dart_plus_app/presentation/view/favorites_page.dart';
import 'package:dart_plus_app/presentation/view/home_page.dart';
import 'package:dart_plus_app/presentation/view/see_all_page.dart';
import 'package:dart_plus_app/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

main() async {
  runApp(const MyApp());
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
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
