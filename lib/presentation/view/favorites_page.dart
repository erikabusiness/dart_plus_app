import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toastification/toastification.dart';

import '../../domain/interfaces/models/favorites/favorites.dart';
import '../bloc/favorites/favorite_bloc.dart';
import '../styles/strings.dart';
import '../widgets/favorite_icon.dart';
import '../widgets/genre_label.dart';
import '../widgets/navigation_bar.dart';
import '../widgets/title_section.dart';
import '../widgets/toastification.dart';

@RoutePage()
class FavoritesPage extends StatefulWidget {
  const FavoritesPage({super.key});

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  int _selectedIndex = 2;

  @override
  void initState() {
    context.read<FavoriteBloc>().add(GetFavoritesEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        backgroundColor: Theme.of(context).colorScheme.background,
        title: const WidgetTitleSection(title: StringsConstants.favorites),
      ),
      body: BlocBuilder<FavoriteBloc, FavoriteState>(
        builder: ((context, state) {
          if (state is FavoriteInitial) {
            context.read<FavoriteBloc>().add(GetFavoritesEvent());
            return const Center(child: CircularProgressIndicator());
          }
          if (state is FavoriteLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is FavoriteError) {
            return const Center(child: Text(StringsConstants.errorFavorites));
          }
          if (state is FavoriteLoaded) {
            List<Favorites> favorites = state.favorites;
            if (favorites.isEmpty) {
              return const Center(
                  child: Text(StringsConstants.favoritesNotFound));
            }
            return ListView.builder(
              itemCount: favorites.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  leading: favorites[index].posterPath.isNotEmpty
                      ? Image.network(
                          'https://image.tmdb.org/t/p/w500${favorites[index].posterPath}',
                        )
                      : const Icon(Icons.favorite),
                  title: Text(favorites[index].title),
                  subtitle: GenreLabelWidget(
                    media: favorites[index],
                    isCompact: true,
                  ),
                  trailing: FavoriteIconWidget(
                    media: favorites[index],
                    onPressed: (isFavorite) {
                      final message = isFavorite
                          ? "${favorites[index].title} ${StringsConstants.favoriteAdded} "
                          : "${favorites[index].title} ${StringsConstants.favoriteRemoved} ";
                      ToastificationWidget.show(
                        context: context,
                        message: message,
                        type: ToastificationType.success,
                      );
                    },
                  ),
                );
              },
            );
          } else {
            return const Center(child: Text(StringsConstants.stateNotfound));
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
