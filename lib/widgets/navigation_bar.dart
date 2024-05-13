import 'package:dart_plus_app/styles/colors.dart';
import 'package:flutter/material.dart';

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
    return BottomNavigationBar(
      backgroundColor: theme.colorScheme.background,
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Início',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.search),
          label: 'Buscar',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.star),
          label: 'Favoritos',
        ),
      ],
      currentIndex: selectedIndex,
      selectedItemColor: CustomColor.defaultTextColor,
      unselectedItemColor: Colors.grey[600],
      onTap: onItemTapped,
    );
  }
}
