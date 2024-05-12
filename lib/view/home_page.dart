import 'package:dart_plus_app/classes/popular_movies.dart';
import 'package:dart_plus_app/classes/popular_series.dart';
import 'package:dart_plus_app/widgets/list_view_horizontal.dart';
import 'package:dart_plus_app/widgets/navigation_bar.dart';
import 'package:dart_plus_app/widgets/search_bar.dart';
import 'package:dart_plus_app/widgets/title_section.dart';
import 'package:dart_plus_app/data/mock/fetch/localdataservice.dart';
import 'package:flutter/material.dart';

import '../widgets/clickable_text.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late Future<List<dynamic>> mediaItems;
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    mediaItems = LocalDataService().fetchData();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
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
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  _buildSection(
                    'Filmes Populares',
                    (data) => data.whereType<PopularMovie>().toList(),
                    mediaItems,
                    () {},
                  ),
                  _buildSection(
                    'Séries Populares',
                    (data) => data.whereType<PopularSeries>().toList(),
                    mediaItems,
                    () {},
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }
}

Widget _buildSection(
  String title,
  List<dynamic> Function(List<dynamic>) filterFunction,
  Future<List<dynamic>> mediaItems,
  VoidCallback verTodos,
) {
  return Column(
    children: [
      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        WidgetTitleSection(title: title),
        ClickableText(
          text: "Ver todos",
          onClick: () {
            verTodos;
          },
        ),
      ]),
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
