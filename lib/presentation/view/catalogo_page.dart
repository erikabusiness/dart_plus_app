import 'package:auto_route/auto_route.dart';
import 'package:dart_plus_app/presentation/styles/strings.dart';
import 'package:flutter/material.dart';
import '../../data/dao/popular_movies_dao.dart';
import '../../data/dao/popular_series_dao.dart';
import '../../domain/interfaces/models/media.dart';
import '../utils/utils_functions.dart';
import '../widgets/grid_view_vertical.dart';
import '../widgets/navigation_bar.dart';
import '../widgets/title_section.dart';

@RoutePage()
class CatalogoPage extends StatefulWidget {
  const CatalogoPage({super.key});

  @override
  State<CatalogoPage> createState() => _CatalogoPageState();
}

class _CatalogoPageState extends State<CatalogoPage> with SingleTickerProviderStateMixin {
  int _selectedIndex = 1;
  late TabController _tabController;
  List<Media> allMedias = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: UtilsFunctions.genre.length, vsync: this);
    _loadData();
  }

  Future<void> _loadData() async {
    try {
      final moviesDao = PopularMoviesDaoImpl();
      final seriesDao = PopularSeriesDaoImpl();

      final movies = await moviesDao.readPopularMovies();
      final series = await seriesDao.readPopularSeries();

      setState(() {
        allMedias = [...movies, ...series];
        isLoading = false;
      });
    } catch (e) {
      // Lidar com erros de carregamento de dados aqui
      setState(() {
        isLoading = false;
      });
      print('Erro ao carregar dados do banco de dados: $e');
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  List<Media> _filterMediaByGenre(String genre) {
    return allMedias.where((media) => UtilsFunctions.genreMap(media.genreIds).contains(genre)).toList();
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        backgroundColor: Theme.of(context).colorScheme.background,
        title: const WidgetTitleSection(title: StringsConstants.catalogo),
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
          if (filteredMedia.isEmpty) {
            return const Center(
              child: Text(StringsConstants.resutlsNotFound),
            );
          } else {
            return WidgetGridViewVertical(mediaItems: filteredMedia, scrollController: null);
          }
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
