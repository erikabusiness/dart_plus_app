import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/media.dart';
import '../movies/bloc/popular_movies/popular_movies_bloc.dart';
import '../movies/bloc/top_rated_movies/top_rated_movies_bloc.dart';
import '../series/bloc/popular_series/popular_series_bloc.dart';
import '../widgets/caroseul.dart';
import '../widgets/clickable_text.dart';
import '../widgets/list_view_horizontal.dart';
import '../widgets/title_section.dart';
import '../routes/routes.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Media> allMedias = [];
  List<Media> displayedMedias = [];
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadMovies(context);
    _loadSeries(context);
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,

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
                  child: Text('Erro ao carregar filmes.'),
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
                        allMedias.addAll(movies);
                        return _buildSection(
                          context,
                          "Filmes Populares",
                          movies,
                          () {
                            Navigator.pushNamed(
                              context,
                              NavRoutes.seeAllMovies,
                              arguments: movies,
                            );
                          },
                        );
                      }

                      if (state is PopularMoviesError) {
                        return const Center(
                          child: Text('Erro ao carregar filmes.'),
                        );
                      }

                      if (state is PopularMoviesLoading) {
                        return const CircularProgressIndicator();
                      }

                      return const Center(
                        child: Text('Erro inesperado.'),
                      );
                    },
                  ),
                  BlocBuilder<PopularSeriesBloc, PopularSeriesState>(
                    builder: (context, state) {
                      if (state is PopularSeriesLoaded) {
                        final series = state.series;
                        allMedias.addAll(series);
                        return _buildSection(
                          context,
                          "Series Populares",
                          series,
                          () {
                            Navigator.pushNamed(
                              context,
                              NavRoutes.seeAllMovies,
                              arguments: series,
                            );
                          },
                        );
                      }

                      if (state is PopularSeriesError) {
                        return const Center(
                          child: Text('Erro ao carregar series.'),
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

  void _filterMedias(String query) {
    setState(() {
      if (query.isEmpty) {
        displayedMedias.clear();
        displayedMedias.addAll(allMedias);
      } else {
        displayedMedias.clear();
        displayedMedias.addAll(allMedias.where((media) =>
            media.title.toLowerCase().contains(query.toLowerCase())));
      }
    });
  }

  Widget _buildSection(
    BuildContext context,
    String title,
    List<Media> mediaItems,
    VoidCallback verTodos,
  ) {
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
            : const Center(child: Text('Nenhum resultado encontrado')),
      ],
    );
  }
}
