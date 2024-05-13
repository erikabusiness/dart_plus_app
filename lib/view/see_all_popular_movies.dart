import 'package:dart_plus_app/classes/media.dart';
import 'package:dart_plus_app/classes/popular_movies.dart';
import 'package:dart_plus_app/widgets/title_section.dart';
import 'package:dart_plus_app/data/mock/fetch/localdataservice.dart';
import 'package:dart_plus_app/widgets/grid_view_vertical.dart';
import 'package:flutter/material.dart';

class SeeAllPopularMovies extends StatefulWidget {
  const SeeAllPopularMovies({
    Key? key,
  }) : super(key: key);

  @override
  State<SeeAllPopularMovies> createState() => _SeeAllPopularMoviesState();
}

class _SeeAllPopularMoviesState extends State<SeeAllPopularMovies> {
  late Future<List<Media>> mediaItems;
  late Future<List<Media>> filteredElements;
  final TextEditingController searchController = TextEditingController();
  bool _isSearchBarVisible = false;

  @override
  void initState() {
    super.initState();
    mediaItems = LocalDataService().fetchData();
    filteredElements = mediaItems;
  }

  void searchMedia(String value) {
    if (value.isEmpty) {
      setState(() {
        filteredElements = mediaItems;
      });
    } else {
      mediaItems.then((data) {
        List<Media> filteredData = data
            .where((element) => element is PopularMovie)
            .where((element) =>
            element.title.toLowerCase().contains(value.toLowerCase()))
            .toList();
        setState(() {
          filteredElements = Future.value(filteredData);
        });
      });
    }
  }

  void _toggleSearchBarVisibility() {
    setState(() {
      _isSearchBarVisible = !_isSearchBarVisible;
      if (!_isSearchBarVisible) {
        searchController.clear();
        searchMedia('');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
        title: _isSearchBarVisible
            ? TextField(
          controller: searchController,
          onChanged: searchMedia,
          decoration: const InputDecoration(
            hintText: 'Buscar...',
            prefixIcon: Icon(Icons.search),
          ),
        )
            : const WidgetTitleSection(title: 'Filmes Populares'),
        actions: [
          IconButton(
            onPressed: _toggleSearchBarVisibility,
            icon: const Icon(Icons.search),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder<List<Media>>(
              future: filteredElements,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasError) {
                    return Center(child: Text('Erro: ${snapshot.error}'));
                  }
                  if (snapshot.hasData) {
                    return WidgetGridViewVertical(
                      mediaItems: snapshot.data as List<Media>,
                    );
                  } else {
                    return const Center(child: Text('Nenhum dado disponível'));
                  }
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
