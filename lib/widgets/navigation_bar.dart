import 'package:flutter/material.dart';
import 'package:dart_plus_app/routes/routes.dart';

import '../models/media.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemTapped;
  final List<Media> allMedias;

  const CustomBottomNavigationBar({
    super.key,
    required this.selectedIndex,
    required this.onItemTapped,
    required this.allMedias,
  });

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return NavigationBar(
      backgroundColor: theme.colorScheme.background,
      selectedIndex: selectedIndex,
      onDestinationSelected: (index) {
        if (index != selectedIndex) {
          onItemTapped(index);
          switch (index) {
            case 0:
              Navigator.pushNamed(
                context,
                NavRoutes.homePage,
              );
              break;
            case 1:
              Navigator.pushNamed(
                context,
                NavRoutes.catalogoPage,
                arguments: {'allMedias': allMedias},
              );
              break;
            case 2:
              Navigator.pushNamed(
                context,
                NavRoutes.favoritesPage,
              );
              break;
          }
        }
      },
      destinations: const [
        NavigationDestination(
          icon: Icon(Icons.home),
          label: 'Início',
        ),
        NavigationDestination(
          icon: Icon(Icons.view_comfy_alt),
          label: 'Catálogo',
        ),
        NavigationDestination(
          icon: Icon(Icons.favorite),
          label: 'Favoritos',
        ),
      ],
    );
  }
}
