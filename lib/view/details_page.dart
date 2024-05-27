import 'package:dart_plus_app/utils/utils_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/media.dart';
import '../movies/bloc/videos_popular_movie/videos_popular_movie_bloc.dart';
import '../widgets/list_view_horizontal.dart';
import '../widgets/media_trailer.dart';
import '../widgets/story_line.dart';
import '../widgets/title_section.dart';
import '../favorites/favorite_bloc.dart';
import '../favorites/favorite_event.dart';
import '../favorites/favorite_state.dart';

class DetailsPage extends StatelessWidget {
  const DetailsPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final videoPopularMovieBloc =
        BlocProvider.of<VideosPopularMovieBloc>(context);
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final Media mediaArgsDetail = args["mediaDetails"];
    final List<Media> moviesList = args["listMedias"];

    final Media media = mediaArgsDetail;
    List<Media> mediaItems = moviesList;

    videoPopularMovieBloc.add(GetTrailerPopularMovies(media.id));

    String voteStar(double vote) {
      var voteStar = vote / 2;
      return voteStar.toStringAsFixed(1);
    }

    List<String?> genres = UtilsFunctions.genreMap(media.genreIds);

    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            expandedHeight: MediaQuery.of(context).size.height * 0.6,
            pinned: true,
            stretch: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                fit: StackFit.expand,
                children: <Widget>[
                  Image.network(
                    "https://image.tmdb.org/t/p/w500${media.posterPath}",
                    fit: BoxFit.cover,
                    alignment: Alignment.topCenter,
                  ),
                  Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        colors: [Colors.black87, Colors.transparent],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: WidgetTitleSection(
                              title: media.title,
                              sizeTitle: 22.0,
                              padding: 0,
                            ),
                          ),
                         BlocProvider(
                            create: (context) => FavoriteBloc()..add(LoadFavorite(media.id)),
                            child: BlocBuilder<FavoriteBloc, FavoriteState>(
                              builder: (context, state) {
                                bool isFavorite = (state as FavoriteInitial).isFavorite;
                                return IconButton(
                                  onPressed: () {
                                    BlocProvider.of<FavoriteBloc>(context).add(ToggleFavorite(media.id));
                                  },
                                  icon: Icon(
                                    isFavorite ? Icons.favorite : Icons.favorite_border_outlined,
                                    size: 32,
                                    color: isFavorite ? Colors.red : null,
                                  ),
                                );
                              },
                            ),
                          ),

                        ],
                      ),
                      
                      const SizedBox(height: 8.0),
                      Wrap(
                        spacing: 8.0,
                        runSpacing: 4.0,
                        children: genres.map((genre) {
                          return Chip(
                            label: Text(genre!),
                          );
                        }).toList(),
                      ),
                      const SizedBox(height: 8.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              const Icon(
                                Icons.star,
                                color: Colors.yellow,
                                size: 18.0,
                              ),
                              Text(
                                "${voteStar(media.voteAverage)}/5.0",
                                style: const TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.normal,
                                    color: Colors.white,),
                              ),
                              const SizedBox(
                                width: 8.0,
                              )
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 16.0),
                      WidgetStoryLine(
                        synopsisTitle: 'Sinopse',
                        synopsisText: media.overview,
                        width: MediaQuery.of(context).size.width,
                        padding: 0,
                        textColor: Colors.white,
                      ),
                      const SizedBox(height: 16.0),
                      BlocBuilder<VideosPopularMovieBloc,
                          VideosPopularMovieState>(
                        builder: (context, state) {
                          if (state is TrailerPopularMovieLoading) {
                            return const CircularProgressIndicator();
                          }

                          if (state is TrailerPopularMovieLoaded) {
                            final String key = state.keyVideo;
                            return WidgetMediaTrailer(videoKey: key);
                          }

                          if (state is TrailerPopularMovieError) {
                            return const Center(
                              heightFactor: 0.01,
                            );
                          }
                          return const Center();
                        },
                      ),
                      const SizedBox(height: 16.0),
                      const WidgetTitleSection(
                        title: 'Recomendados',
                        padding: 5,
                      ),
                      const SizedBox(height: 4.0),
                      WidgetListViewHorizontal(mediaItems: mediaItems),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
