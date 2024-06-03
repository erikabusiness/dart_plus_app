import 'package:flutter/material.dart';
import 'package:dart_plus_app/routes/routes.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemTapped;

  const CustomBottomNavigationBar({
    super.key,
    required this.selectedIndex,
    required this.onItemTapped,
  });

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return NavigationBar(
      backgroundColor: theme.colorScheme.background,
      selectedIndex: selectedIndex,
      onDestinationSelected: (index) {
        onItemTapped(index);
        switch (index) {
          case 0:
            index == 0
                ? Navigator.pushNamed(context, NavRoutes.homePage)
                : null;
            break;
          case 1:
            index == 1
                ? Navigator.pushNamed(context, NavRoutes.catalogoPage)
                : null;
            break;
          case 2:
            index == 2
                ? Navigator.pushNamed(context, NavRoutes.favoritesPage)
                : null;
            break;
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
