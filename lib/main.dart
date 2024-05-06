import 'package:dart_plus_app/widgets/search_bar.dart';
import 'package:dart_plus_app/widgets/title_section.dart';
import 'package:dart_plus_app/data/mock/fetch/localdataservice.dart';
import 'package:dart_plus_app/widgets/grid_view_vertical.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
        fontFamily: 'Poppins',
      ),
      home: const MyHomePage(
        title: 'Dart+',
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;
  //const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late Future<List<dynamic>> mediaItems;

  @override
  void initState() {
    super.initState();
    mediaItems = LocalDataService().fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 41, 41, 41),
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Column(
        children: [
          WidgetSearchBar(),
          const WidgetTitleSection(title: 'Filmes e Séries Populares'),
          FutureBuilder<List<dynamic>>(
            future: mediaItems,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasError) {
                  return Center(child: Text('Erro: ${snapshot.error}'));
                }
                if (snapshot.hasData) {
                  return WidgetGridViewVertical(mediaItems: snapshot.data!);
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
