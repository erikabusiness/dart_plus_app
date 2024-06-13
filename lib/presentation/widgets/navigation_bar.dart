import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../domain/interfaces/models/media.dart';
import '../../routes/app_router.dart';

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
              context.pushRoute(
                const MyHomeRoute()
              );
              break;
            case 1:
              context.pushRoute(
                const CatalogoRoute()
              );
              break;
            case 2:
              context.pushRoute(
                const FavoritesRoute()
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
