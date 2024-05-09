import 'package:dart_plus_app/classes/popular_movies.dart';
import 'package:dart_plus_app/widgets/title_section.dart';
import 'package:dart_plus_app/data/mock/fetch/localdataservice.dart';
import 'package:dart_plus_app/widgets/grid_view_vertical.dart';
import 'package:flutter/material.dart';

class SeeAllPopularMovies extends StatefulWidget {
  const SeeAllPopularMovies({super.key, required this.title});
  final String title;

  @override
  State<SeeAllPopularMovies> createState() => _SeeAllPopularMovies();
}

class _SeeAllPopularMovies extends State<SeeAllPopularMovies> {
  late Future<List<dynamic>> mediaItems;

  @override
  void initState() {
    super.initState();
    mediaItems = LocalDataService().fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {},
        ),
        title: const WidgetTitleSection(title: 'Filmes Populares'),
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.search))],
      ),
      body: Column(
        children: [],
      ),
    );
  }
}
