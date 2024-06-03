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
                ? null
                : Navigator.pushNamed(context, NavRoutes.homePage);
            break;
          // case 1:
          //   index == 1 ? null : Navigator.pushNamed(context, NavRoutes.catalogoPage);
          //   break;
          case 2:
            index == 1 ? null : Navigator.pushNamed(context, NavRoutes.favoritesPage); //TODO Alterar o index quando houver catalago
            break;
        }
      },
      destinations: const [
        NavigationDestination(
          icon: Icon(Icons.home),
          label: 'Início',
        ),
        NavigationDestination(
          icon: Icon(Icons.search),
          label: 'Catálogo',
          enabled: false,
        ),
        NavigationDestination(
          icon: Icon(Icons.favorite),
          label: 'Favoritos',
        ),
      ],
    );
  }
}
