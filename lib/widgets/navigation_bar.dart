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
            Navigator.pushNamed(context, NavRoutes.homePage);
            break;
          // case 1:
          //   Navigator.pushNamed(context, NavRoutes.searchPage);
          //   break;
          // case 2:
          //   Navigator.pushNamed(context, NavRoutes.favoritesPage);
          //   break;
        }
      },
      destinations: const [
        NavigationDestination(
          icon: Icon(Icons.home),
          label: 'Início',
        ),
        NavigationDestination(
          icon: Icon(Icons.search),
          label: 'Buscar',
        ),
        NavigationDestination(
          icon: Icon(Icons.star),
          label: 'Favoritos',
        ),
      ],
    );
  }
}
