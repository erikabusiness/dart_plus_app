import 'package:dart_plus_app/data/dao/favorites_dao_impl.dart';
import 'package:dart_plus_app/presentation/bloc/favorites/favorite_bloc.dart';
import 'package:dart_plus_app/presentation/bloc/popular_movies/popular_movies_bloc.dart';
import 'package:dart_plus_app/presentation/bloc/popular_series/popular_series_bloc.dart';
import 'package:dart_plus_app/presentation/bloc/top_rated_movies/top_rated_movies_bloc.dart';
import 'package:dart_plus_app/presentation/bloc/videos_popular_movie/videos_popular_movie_bloc.dart';
import 'package:dart_plus_app/presentation/view/catalogo_page.dart';
import 'package:dart_plus_app/presentation/view/details_page.dart';
import 'package:dart_plus_app/presentation/view/favorites_page.dart';
import 'package:dart_plus_app/presentation/view/home_page.dart';
import 'package:dart_plus_app/presentation/view/login_page.dart';
import 'package:dart_plus_app/presentation/view/register_page.dart';
import 'package:dart_plus_app/presentation/view/see_all_page.dart';
import 'package:dart_plus_app/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  final favoriteDao = FavoritesDaoImpl();
  final favoriteBloc = FavoriteBloc(favoriteDao);

  final popularMoviesBloc = PopularMoviesBloc();
  final topRatedMoviesBloc = TopRatedMoviesBloc();
  final popularSeriesBloc = PopularSeriesBloc();
  final videosPopularMovieBloc = VideosPopularMovieBloc();

  runApp(MyApp(
    favoriteBloc: favoriteBloc,
    popularMoviesBloc: popularMoviesBloc,
    topRatedMoviesBloc: topRatedMoviesBloc,
    popularSeriesBloc: popularSeriesBloc,
    videosPopularMovieBloc: videosPopularMovieBloc,
  ));
}

class MyApp extends StatelessWidget {
  final FavoriteBloc favoriteBloc;
  final PopularMoviesBloc popularMoviesBloc;
  final TopRatedMoviesBloc topRatedMoviesBloc;
  final PopularSeriesBloc popularSeriesBloc;
  final VideosPopularMovieBloc videosPopularMovieBloc;

  const MyApp({super.key, 
    required this.favoriteBloc,
    required this.popularMoviesBloc,
    required this.topRatedMoviesBloc,
    required this.popularSeriesBloc,
    required this.videosPopularMovieBloc,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: favoriteBloc),
        BlocProvider.value(value: popularMoviesBloc),
        BlocProvider.value(value: topRatedMoviesBloc),
        BlocProvider.value(value: popularSeriesBloc),
        BlocProvider.value(value: videosPopularMovieBloc),
      ],
      child: MaterialApp(
        initialRoute: NavRoutes.loginPage,
        routes: {
          NavRoutes.loginPage: (context) => const LoginPage(),
          NavRoutes.registerPage: (context) => const RegisterPage(),
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
