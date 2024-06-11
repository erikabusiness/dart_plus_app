import 'package:dart_plus_app/data/dao/popular_series_dao.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/dao/popular_movies_dao.dart';
import '../../domain/interfaces/models/media.dart';
import '../../routes.dart';
import '../bloc/popular_movies/popular_movies_bloc.dart';
import '../bloc/popular_series/popular_series_bloc.dart';
import '../bloc/top_rated_movies/top_rated_movies_bloc.dart';
import '../styles/strings.dart';
import '../widgets/caroseul.dart';
import '../widgets/clickable_text.dart';
import '../widgets/list_view_horizontal.dart';
import '../widgets/title_section.dart';
import '../widgets/navigation_bar.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Media> allMedias = [];
  List<Media> displayedMedias = [];
  TextEditingController searchController = TextEditingController();
  int _selectedIndex = 0;

  final dbMoviePopularRepository = PopularMoviesDao();
  final dbSeriePopularRepository = PopularSeriesDao();


  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    final allMovies = await dbMoviePopularRepository.readPopularMovies();
    final allSeries = await dbSeriePopularRepository.readPopularSeries();

    setState(() {
      allMedias.addAll(allMovies);
      allMedias.addAll(allSeries);
    });

    _loadMovies(context);
    _loadSeries(context);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Theme
            .of(context)
            .colorScheme
            .background,
        title: Image.asset('assets/logo.png'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          BlocBuilder<TopRatedMoviesBloc, TrhendMoviesState>(
            builder: (context, state) {
              if (state is TrhendMoviesLoaded) {
                final movies = state.movies;
                return WidgetCarousel(mediaItems: movies);
              }
              if (state is TrhendMoviesError) {
                return const Center(
                  child: Text(StringsConstants.moviesError),
                );
              }
              return const CircularProgressIndicator();
            },
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  BlocBuilder<PopularMoviesBloc, PopularMoviesState>(
                    builder: (context, state) {
                      if (state is PopularMoviesLoaded) {
                        final movies = state.movies;
                        return _buildSection(
                          context,
                          StringsConstants.popularMovies,
                          movies,
                              () {
                            Navigator.pushNamed(
                              context,
                              NavRoutes.seeAll,
                              arguments: {
                                "medias": movies,
                                "tela": StringsConstants.popularMovies
                              },
                            );
                          },
                        );
                      }

                      if (state is PopularMoviesError) {
                        return const Center(
                          child: Text(StringsConstants.moviesError),
                        );
                      }

                      if (state is PopularMoviesLoading) {
                        return const CircularProgressIndicator();
                      }

                      return const Center(
                        child: Text(StringsConstants.stateNotfound),
                      );
                    },
                  ),
                  BlocBuilder<PopularSeriesBloc, PopularSeriesState>(
                    builder: (context, state) {
                      if (state is PopularSeriesLoaded) {
                        final series = state.series;
                        return _buildSection(
                          context,
                          StringsConstants.popularSeries,
                          series,
                              () {
                            Navigator.pushNamed(
                              context,
                              NavRoutes.seeAll,
                              arguments: {
                                "medias": series,
                                "tela": StringsConstants.popularSeries
                              },
                            );
                          },
                        );
                      }

                      if (state is PopularSeriesError) {
                        return const Center(
                          child: Text(StringsConstants.seriesError),
                        );
                      }
                      return const CircularProgressIndicator();
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped, allMedias: allMedias,
      ),
    );
  }

  void _loadMovies(BuildContext context) {
    final popularMoviesBloc = BlocProvider.of<PopularMoviesBloc>(context);
    final topratedMoviesBloc = BlocProvider.of<TopRatedMoviesBloc>(context);

    popularMoviesBloc.add(const GetAllPopularMovies());
    topratedMoviesBloc.add(const GetAllTrhendMovies());
  }

  void _loadSeries(BuildContext context) {
    final popularSeriesBloc = BlocProvider.of<PopularSeriesBloc>(context);
    popularSeriesBloc.add(const GetAllPopularSeries());
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget _buildSection(BuildContext context,
      String title,
      List<Media> mediaItems,
      VoidCallback verTodos,) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            WidgetTitleSection(title: title),
            ClickableText(
              text: "Ver todos",
              onClick: verTodos,
            ),
          ],
        ),
        mediaItems.isNotEmpty
            ? WidgetListViewHorizontal(mediaItems: mediaItems)
            : const Center(child: Text(StringsConstants.resutlsNotFound)),
      ],
    );
  }
}