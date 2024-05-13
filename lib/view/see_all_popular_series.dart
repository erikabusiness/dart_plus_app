import 'package:dart_plus_app/classes/media.dart';
import 'package:dart_plus_app/classes/popular_series.dart';
import 'package:dart_plus_app/widgets/title_section.dart';
import 'package:dart_plus_app/data/mock/fetch/localdataservice.dart';
import 'package:dart_plus_app/widgets/grid_view_vertical.dart';
import 'package:flutter/material.dart';

class SeeAllPopularSeriesArguments {
  final Future<List<Media>> media;

  SeeAllPopularSeriesArguments({required this.media});
}

class SeeAllPopularSeries extends StatefulWidget {
  const SeeAllPopularSeries({super.key,});

  @override
  State<SeeAllPopularSeries> createState() => _SeeAllPopularSeries();
}

class _SeeAllPopularSeries extends State<SeeAllPopularSeries> {
  late Future<List<Media>> mediaItems;

  @override
  void initState() {
    super.initState();
    mediaItems = LocalDataService().fetchData();
  }

  @override
  Widget build(BuildContext context) {

    final args = ModalRoute.of(context)?.settings.arguments as Future<List<Media>>;
    mediaItems = args;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
        title: const WidgetTitleSection(title: 'Séries Populares'),
        actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.search))],
      ),
      body: Column(
        children: [
          FutureBuilder<List<Media>>(
            future: mediaItems,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasError) {
                  return Center(child: Text('Erro: ${snapshot.error}'));
                }
                if (snapshot.hasData) {
                  List<Media> filteredMediaItems =
                      snapshot.data!.whereType<PopularSeries>().toList();
                  return WidgetGridViewVertical(mediaItems: filteredMediaItems);
                } else {
                  return const Center(child: Text('Nenhum dado disponível'));
                }
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            },
          ),
        ],
      ),
    );
  }
}
