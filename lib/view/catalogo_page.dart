import 'package:dart_plus_app/widgets/favorite_icon.dart';
import 'package:dart_plus_app/widgets/genre_label.dart';
import 'package:dart_plus_app/widgets/navigation_bar.dart';
import 'package:dart_plus_app/widgets/title_section.dart';
import 'package:flutter/material.dart';
import '../models/media.dart';

class CatalogoPage extends StatefulWidget {
  const CatalogoPage({super.key});

  @override
  State<CatalogoPage> createState() => _CatalagoPageState();
}

class _CatalagoPageState extends State<CatalogoPage> {
  int _selectedIndex = 1;
  List<Media> media = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
        title: const WidgetTitleSection(title: 'Catálogo'),
      ),
      body: Column(
        children: [
          ListView.builder(
            itemCount: media.length,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                leading: media[index].posterPath.isNotEmpty
                    ? Image.network(
                        'https://image.tmdb.org/t/p/w500${media[index].posterPath}',
                      )
                    : const Icon(Icons.movie),
                title: Text(media[index].title),
                subtitle: GenreLabelWidget(
                  media: media[index],
                  isCompact: true,
                ),
              );
            },
          ),
        ],
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
