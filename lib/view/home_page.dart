import 'package:dart_plus_app/classes/popular_movies.dart';
import 'package:dart_plus_app/classes/popular_series.dart';
import 'package:dart_plus_app/widgets/list_view_horizontal.dart';
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
  late Future<List<dynamic>> mediaItemsCopy;
  late Future<List<dynamic>> filteredElements;

  final TextEditingController searchController = TextEditingController();

  void searchMedia(String value) {
    if (value.isEmpty) {
      setState(() {
        mediaItems = mediaItemsCopy;
      });
    } else {
      mediaItems.then((data) {
        List<dynamic> filteredData = data
            .where((element) =>
                (element is PopularMovie || element is PopularSeries))
            .where((element) =>
                element.title.toLowerCase().contains(value.toLowerCase()))
            .toList();
        filteredElements = Future.value(filteredData);

        setState(() {
          mediaItems = filteredElements;
        });
      });
    }
  }

  @override
  void initState() {
    super.initState();
    mediaItems = LocalDataService().fetchData();
    mediaItemsCopy = mediaItems;
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
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: SearchBar(
              controller: searchController,
              leading: const Icon(Icons.search),
              trailing: <Widget>[
                Tooltip(
                  message: 'Busca por voz',
                  child:
                      IconButton(onPressed: () {}, icon: const Icon(Icons.mic)),
                ),
              ],
              hintText: 'Procure um filme ou série',
              onChanged: (value) => {
                searchMedia(value),
              },
              padding: const MaterialStatePropertyAll<EdgeInsets>(
                  EdgeInsets.symmetric(horizontal: 16.0)),
            ),
          ),
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
              if (filteredMediaItems.isNotEmpty) {
                return WidgetListViewHorizontal(
                  mediaItems: filteredMediaItems,
                );
              } else {
                return const Center(child: Text('Nenhum resultado encontrado'));
              }
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    ],
  );
}
