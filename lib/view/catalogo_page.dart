import 'package:flutter/material.dart';
import 'package:dart_plus_app/utils/utils_functions.dart';
import 'package:dart_plus_app/widgets/navigation_bar.dart';
import 'package:dart_plus_app/widgets/title_section.dart';
import '../models/media.dart';
import '../widgets/grid_view_vertical.dart';

class CatalogoPage extends StatefulWidget {
  const CatalogoPage({super.key});

  @override
  State<CatalogoPage> createState() => _CatalogoPageState();
}

class _CatalogoPageState extends State<CatalogoPage>
    with SingleTickerProviderStateMixin {
  int _selectedIndex = 1;
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

  List<Media> _filterMediaByGenre(String genre) {
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final List<Media> allMedias = args["allMedias"];
    return allMedias
        .where(
            (media) => UtilsFunctions.genreMap(media.genreIds).contains(genre))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final List<Media> allMedias = args["allMedias"];

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        backgroundColor: Theme.of(context).colorScheme.background,
        title: const WidgetTitleSection(title: 'Catálogo'),
        bottom: TabBar(
          tabAlignment: TabAlignment.start,
          controller: _tabController,
          isScrollable: true,
          tabs: UtilsFunctions.genre.values.map((String genre) {
            return Tab(text: genre);
          }).toList(),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: UtilsFunctions.genre.values.map((String genre) {
          final filteredMedia = _filterMediaByGenre(genre);
          return WidgetGridViewVertical(mediaItems: filteredMedia);
        }).toList(),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
        allMedias: allMedias,
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}
