import 'package:flutter/material.dart';
import '../models/media.dart';
import '../widgets/grid_view_vertical.dart';
import '../widgets/title_section.dart';

class SeeAllPopularMovies extends StatelessWidget {
  const SeeAllPopularMovies({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Media> mediaItems =
        ModalRoute.of(context)!.settings.arguments as List<Media>;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
        title: const WidgetTitleSection(title: 'Filmes Populares'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.search),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: mediaItems.isNotEmpty
                ? WidgetGridViewVertical(mediaItems: mediaItems)
                : const Center(child: Text('Nenhum dado disponível')),
          ),
        ],
      ),
    );
  }
}
