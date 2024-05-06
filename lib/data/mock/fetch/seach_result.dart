import 'dart:convert';
import 'package:dart_plus_app/data/mock/fetch/localdataservice.dart';
import 'package:dart_plus_app/widgets/grid_view_vertical.dart';
import 'package:flutter/material.dart';
import 'package:dart_plus_app/classes/popular_movies.dart';
import 'package:dart_plus_app/classes/popular_series.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: ContentDisplayScreen(),
    );
  }
}

class ContentDisplayScreen extends StatefulWidget {
  const ContentDisplayScreen({super.key});

  @override
  State<ContentDisplayScreen> createState() => _ContentDisplayScreenState();
}

class _ContentDisplayScreenState extends State<ContentDisplayScreen> {
  List<dynamic> items = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  void fetchData() async {
    var data = await LocalDataService().fetchData();
    setState(() {
      items = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Popular Media")),
      body: WidgetGridViewVertical(mediaItems: items),
    );
  }
}

List<Widget> processMetadata(String jsonString) {
  Map<String, dynamic> data = jsonDecode(jsonString);
  List<Widget> widgets = [];

  List<dynamic> items = [];
  items.addAll((data['popularMovies'] as List)
      .map((item) => PopularMovie.fromJson(item))
      .toList());
  items.addAll((data['popularTvSeries'] as List)
      .map((item) => PopularSeries.fromJson(item))
      .toList());
  items.addAll((data['trending'] as List)
      .map((item) => PopularMovie.fromJson(item))
      .toList());

  for (var item in items) {
    widgets.add(ListTile(
      title: Text(item.title ?? item.originalName,
          style: const TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Text(item.overview),
      leading: Image.network(
          'https://image.tmdb.org/t/p/w500${item.posterPath}',
          width: 50,
          height: 100,
          fit: BoxFit.cover),
      isThreeLine: true,
    ));
  }
  return widgets;
}
