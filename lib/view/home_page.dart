import 'package:dart_plus_app/classes/popular_movies.dart';
import 'package:dart_plus_app/classes/popular_series.dart';
import 'package:dart_plus_app/widgets/list_view_horizontal.dart';
import 'package:dart_plus_app/widgets/search_bar.dart';
import 'package:dart_plus_app/widgets/title_section.dart';
import 'package:dart_plus_app/data/mock/fetch/localdataservice.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
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
        title: Image.asset('assets/logo.png'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          const WidgetSearchBar(),
          _buildSection(
            'Filmes Populares',
            (data) => data.whereType<PopularMovie>().toList(),
            mediaItems,
          ),
          _buildSection(
            'Séries Populares',
            (data) => data.whereType<PopularSeries>().toList(),
            mediaItems,
          ),
        ],
      ),
    );
  }
}

Widget _buildSection(
  String title,
  List<dynamic> Function(List<dynamic>) filterFunction,
  Future<List<dynamic>> mediaItems,
) {
  return Column(
    children: [
      WidgetTitleSection(title: title),
      FutureBuilder<List<dynamic>>(
        future: mediaItems,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              return Center(child: Text('Erro: ${snapshot.error}'));
            }
            if (snapshot.hasData) {
              List<dynamic> filteredMediaItems = filterFunction(snapshot.data!);
              return WidgetListViewHorizontal(
                mediaItems: filteredMediaItems,
              );
            } else {
              return const Center(child: Text('Nenhum dado disponível'));
            }
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    ],
  );
}
