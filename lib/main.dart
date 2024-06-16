import 'package:dart_plus_app/presentation/bloc/favorites/favorite_bloc.dart';
import 'package:dart_plus_app/presentation/bloc/login/bloc/login_bloc.dart';
import 'package:dart_plus_app/presentation/bloc/popular_movies/popular_movies_bloc.dart';
import 'package:dart_plus_app/presentation/bloc/popular_series/popular_series_bloc.dart';
import 'package:dart_plus_app/presentation/bloc/register/bloc/register_bloc.dart';
import 'package:dart_plus_app/presentation/bloc/top_rated_movies/top_rated_movies_bloc.dart';
import 'package:dart_plus_app/presentation/bloc/videos_popular_movie/videos_popular_movie_bloc.dart';
import 'package:dart_plus_app/routes/app_router.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import 'di/service_locator.dart';
import 'domain/user_data.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  setupServiceLocator();
  runApp(
      ChangeNotifierProvider(create: (context) => UserData(), child: MyApp()));
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
        BlocProvider(create: (_) => getIt<LoginBloc>()),
        BlocProvider(create: (_) => getIt<RegisterBloc>()),
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
