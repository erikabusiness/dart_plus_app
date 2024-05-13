import 'package:dart_plus_app/data/routes.dart';
import 'package:dart_plus_app/view/details_page.dart';
import 'package:dart_plus_app/view/home_page.dart';
import 'package:dart_plus_app/view/see_all_popular_movies.dart';
import 'package:dart_plus_app/view/see_all_popular_series.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: NavRoutes.homePage,
      routes: {
        NavRoutes.homePage: (context) => const MyHomePage(),
        NavRoutes.details: (context) => const DetailsPage(),
        NavRoutes.seeAllMovies: (context) => const SeeAllPopularMovies(),
        NavRoutes.seeAllSeries: (context) => const SeeAllPopularSeries(),
      },
      title: 'Dart Plus',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(
        useMaterial3: true,
      ),
    );
  }
}
