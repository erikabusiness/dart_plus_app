import 'package:dart_plus_app/data/dao/favorites_dao_impl.dart';
import 'package:dart_plus_app/data/repositories/firebase_repository_impl.dart';
import 'package:dart_plus_app/domain/interfaces/repositories/auth_repository.dart';
import 'package:dart_plus_app/firebase_options.dart';
import 'package:dart_plus_app/presentation/bloc/favorites/favorite_bloc.dart';
import 'package:dart_plus_app/presentation/bloc/login/bloc/login_bloc.dart';
import 'package:dart_plus_app/presentation/bloc/popular_movies/popular_movies_bloc.dart';
import 'package:dart_plus_app/presentation/bloc/popular_series/popular_series_bloc.dart';
import 'package:dart_plus_app/presentation/bloc/register/bloc/register_bloc.dart';
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
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  final favoriteDao = FavoritesDaoImpl();
  final favoriteBloc = FavoriteBloc(favoriteDao);

  final popularMoviesBloc = PopularMoviesBloc();
  final topRatedMoviesBloc = TopRatedMoviesBloc();
  final popularSeriesBloc = PopularSeriesBloc();
  final videosPopularMovieBloc = VideosPopularMovieBloc();
  final registerBloc = RegisterBloc();
  final loginBloc = LoginBloc();

  runApp(MyApp(
    favoriteBloc: favoriteBloc,
    popularMoviesBloc: popularMoviesBloc,
    topRatedMoviesBloc: topRatedMoviesBloc,
    popularSeriesBloc: popularSeriesBloc,
    videosPopularMovieBloc: videosPopularMovieBloc,
    registerBloc: registerBloc,
    loginBloc: loginBloc,
  ));
}

class MyApp extends StatelessWidget {
  final FavoriteBloc favoriteBloc;
  final PopularMoviesBloc popularMoviesBloc;
  final TopRatedMoviesBloc topRatedMoviesBloc;
  final PopularSeriesBloc popularSeriesBloc;
  final VideosPopularMovieBloc videosPopularMovieBloc;
  final RegisterBloc registerBloc;
  final LoginBloc loginBloc;

  const MyApp({
    super.key,
    required this.favoriteBloc,
    required this.popularMoviesBloc,
    required this.topRatedMoviesBloc,
    required this.popularSeriesBloc,
    required this.videosPopularMovieBloc,
    required this.registerBloc,
    required this.loginBloc,
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
        BlocProvider.value(value: registerBloc),
        BlocProvider.value(value: loginBloc),
      ],
      child: MaterialApp(
        initialRoute: NavRoutes.registerPage,
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
