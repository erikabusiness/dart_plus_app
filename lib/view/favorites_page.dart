import 'package:dart_plus_app/favorites/favorite_bloc.dart';
import 'package:dart_plus_app/utils/utils_functions.dart';
import 'package:dart_plus_app/widgets/favorite_icon.dart';
import 'package:dart_plus_app/widgets/navigation_bar.dart';
import 'package:dart_plus_app/widgets/title_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/favorites.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({super.key});

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  int _selectedIndex = 2;

  @override
  void initState() {
    context.read<FavoriteBloc>().add(GetFavoritesEvent(listFavorites: []));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
        title: const WidgetTitleSection(title: 'Favoritos'),
      ),
      body: BlocBuilder<FavoriteBloc, FavoriteState>(
        builder: ((context, state) {
          if (state is FavoriteInitial) {
            context.read<FavoriteBloc>().add(GetFavoritesEvent(listFavorites: []));
            return const Center(child: CircularProgressIndicator());
          }
          if (state is FavoriteLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is FavoriteError) {
            return const Center(child: Text('Erro ao carregar favoritos'));
          }
          if (state is FavoriteLoaded) {
            List<Favorites> favorites = state.favorites;
            if (favorites.isEmpty) {
              return const Center(child: Text('Não há itens favoritados! ☹'));
            }
            return ListView.builder(
              itemCount: favorites.length,
              itemBuilder: (BuildContext context, int index) {
                List<String?> generos =
                UtilsFunctions.genreMap(favorites[index].genreIds);
                return ListTile(
                  leading: favorites[index].posterPath.isNotEmpty
                      ? Image.network(
                    'https://image.tmdb.org/t/p/w500${favorites[index].posterPath}',
                  )
                      : const Icon(Icons.favorite),
                  title: Text(favorites[index].title),
                  subtitle: Text(generos.join(", ")),
                  trailing: FavoriteIconWidget(media: favorites[index]),
                );
              },
            );
          } else {
            return const Center(child: Text('Estado desconhecido'));
          }
        }),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}
