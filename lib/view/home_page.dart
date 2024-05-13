import 'package:dart_plus_app/classes/media.dart';
import 'package:dart_plus_app/classes/popular_movies.dart';
import 'package:dart_plus_app/classes/popular_series.dart';
import 'package:dart_plus_app/data/routes.dart';
import 'package:dart_plus_app/view/see_all_popular_series.dart';
import 'package:dart_plus_app/widgets/list_view_horizontal.dart';
import 'package:dart_plus_app/widgets/navigation_bar.dart';
import 'package:dart_plus_app/widgets/title_section.dart';
import 'package:dart_plus_app/data/mock/fetch/localdataservice.dart';
import 'package:flutter/material.dart';

import '../widgets/clickable_text.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    super.key,
  });

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;
  late Future<List<Media>> mediaItems;
  late Future<List<Media>> mediaItemsCopy;
  late Future<List<Media>> filteredElements;

  final TextEditingController searchController = TextEditingController();

  void searchMedia(String value) {
    if (value.isEmpty) {
      setState(() {
        mediaItems = mediaItemsCopy;
      });
    } else {
      mediaItems.then((data) {
        List<Media> filteredData = data
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

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final String title;

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
                    () {
                      Navigator.pushNamed(context, NavRoutes.seeAllMovies,
                          arguments: mediaItems,);
                    },
                  ),
                  _buildSection(
                    'Séries Populares',
                    (data) => data.whereType<PopularSeries>().toList(),
                    mediaItems,
                    () {
                      Navigator.pushNamed(
                        context,
                        NavRoutes.seeAllSeries,
                        arguments: mediaItems,
                      );
                    },
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
  List<Media> Function(List<Media>) filterFunction,
  Future<List<Media>> mediaItems,
  VoidCallback verTodos,
) {
  return Column(
    children: [
      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        WidgetTitleSection(title: title),
        ClickableText(
          text: "Ver todos",
          onClick: () {
            verTodos();
          },
        ),
      ]),
      FutureBuilder<List<Media>>(
        future: mediaItems,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              return Center(child: Text('Erro: ${snapshot.error}'));
            }
            if (snapshot.hasData) {
              List<Media> filteredMediaItems = filterFunction(snapshot.data!);
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
