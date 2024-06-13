import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/interfaces/models/media.dart';
import '../bloc/popular_movies/popular_movies_bloc.dart';
import '../bloc/popular_series/popular_series_bloc.dart';
import '../styles/strings.dart';
import '../widgets/grid_view_vertical.dart';
import '../widgets/search_bar.dart';
import '../widgets/title_section.dart';

@RoutePage()
class SeeAllPage extends StatefulWidget {
  final List<Media> mediaItems;
  final String tela;

  const SeeAllPage({super.key, required this.mediaItems, required this.tela});

  @override
  State<SeeAllPage> createState() => _SeeAllPageState();
}

class _SeeAllPageState extends State<SeeAllPage> {
  final ScrollController _scrollController = ScrollController();
  TextEditingController searchController = TextEditingController();
  bool isSearching = false;

  List<Media> allMediaItems = [];
  List<Media> filteredMediaItems = [];
  String tela = "";

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
    searchController.addListener(_filterMediaItems);

    allMediaItems = widget.mediaItems;
    filteredMediaItems = allMediaItems;
    tela = widget.tela;
  }

  void _scrollListener() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      switch (tela) {
        case StringsConstants.popularMovies:
          BlocProvider.of<PopularMoviesBloc>(context)
              .add(const GetNextPopularMovies());
          break;
        case StringsConstants.popularSeries:
          BlocProvider.of<PopularSeriesBloc>(context)
              .add(const GetNextPopularSeries());
          break;
      }
    }
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    searchController.removeListener(_filterMediaItems);
    searchController.dispose();
    super.dispose();
  }

  void _filterMediaItems() {
    final query = searchController.text.toLowerCase();
    setState(() {
      filteredMediaItems = allMediaItems
          .where((media) => media.title.toLowerCase().contains(query))
          .toList();
    });
  }

  void _toggleSearch() {
    setState(() {
      isSearching = !isSearching;
      if (!isSearching) {
        searchController.clear();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.background,
        title: WidgetTitleSection(title: tela),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
            BlocProvider.of<PopularMoviesBloc>(context)
                .add(const LoadingDataBasePopularMovies());
            BlocProvider.of<PopularSeriesBloc>(context)
                .add(const LoadingDataBasePopularSeries());
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: _toggleSearch,
          ),
        ],
      ),
      body: Column(
        children: [
          if (isSearching)
            WidgetSearchBar(
              controller: searchController,
              onChanged: (query) => _filterMediaItems(),
            ),
          Expanded(
            child: MultiBlocListener(
              listeners: [
                BlocListener<PopularMoviesBloc, PopularMoviesState>(
                  listener: (context, state) {
                    if (tela == StringsConstants.popularMovies) {
                      if (state is PopularMoviesLoaded) {
                        setState(() {
                          allMediaItems.addAll(state.movies);
                          filteredMediaItems = allMediaItems;
                        });
                      }
                    }
                  },
                ),
                BlocListener<PopularSeriesBloc, PopularSeriesState>(
                  listener: (context, state) {
                    if (tela == StringsConstants.popularSeries) {
                      if (state is PopularSeriesLoaded) {
                        setState(() {
                          allMediaItems.addAll(state.series);
                          filteredMediaItems = allMediaItems;
                        });
                      }
                    }
                  },
                ),
              ],
              child: filteredMediaItems.isNotEmpty
                  ? WidgetGridViewVertical(
                      mediaItems: filteredMediaItems,
                      scrollController: _scrollController,
                    )
                  : const Center(child: Text(StringsConstants.resutlsNotFound)),
            ),
          ),
        ],
      ),
    );
  }
}
