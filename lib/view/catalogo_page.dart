import 'package:flutter/material.dart';
import 'package:dart_plus_app/utils/utils_functions.dart';
import 'package:dart_plus_app/widgets/favorite_icon.dart';
import 'package:dart_plus_app/widgets/genre_label.dart';
import 'package:dart_plus_app/widgets/navigation_bar.dart';
import 'package:dart_plus_app/widgets/title_section.dart';
import '../models/media.dart';

class CatalogoPage extends StatefulWidget {
  const CatalogoPage({super.key});

  @override
  State<CatalogoPage> createState() => _CatalogoPageState();
}

class _CatalogoPageState extends State<CatalogoPage>
    with SingleTickerProviderStateMixin {
  int _selectedIndex = 1;
  List<Media> media = [];
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController =
        TabController(length: UtilsFunctions.genre.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
        title: const WidgetTitleSection(title: 'Catálogo'),
        bottom: TabBar(
          controller: _tabController,
          isScrollable: true,
          tabs: UtilsFunctions.genre.values.map((String genre) {
            return Tab(text: genre);
          }).toList(),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: UtilsFunctions.genre.keys.map((int genreId) {
                return Expanded(
                  child: ListView.builder(
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
                );
              }).toList(),
            ),
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
