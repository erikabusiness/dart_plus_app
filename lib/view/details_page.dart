import 'package:dart_plus_app/styles/colors.dart';
import 'package:dart_plus_app/utils/utils_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/media.dart';
import '../movies/bloc/videos_popular_movie/videos_popular_movie_bloc.dart';
import '../widgets/list_view_horizontal.dart';
import '../widgets/media_trailer.dart';
import '../widgets/story_line.dart';
import '../widgets/title_section.dart';

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

    String dateFormat(String date) {
      String dateMedia = date;
      List<String> modifiedDate = dateMedia.split('-').reversed.toList();
      return modifiedDate.join('-');
    }

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
                      WidgetTitleSection(
                        title: media.title,
                        sizeTitle: 22.0,
                        padding: 0,
                      ),
                      const SizedBox(height: 8.0),
                      Wrap(
                        spacing: 8.0,
                        runSpacing: 4.0,
                        children: genres.map((genre) {
                          return Chip(
                              label: Text(genre!),
                              backgroundColor: Colors.grey.shade800);
                        }).toList(),
                      ),
                      const SizedBox(height: 8.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Data de lançamento: ${dateFormat(media.releaseDate)}',
                            style: const TextStyle(
                                fontSize: 14.0,
                                fontWeight: FontWeight.normal,
                                color: Colors.white),
                          ),
                          Row(
                            children: [
                              const Icon(
                                Icons.star,
                                color: Colors.yellow,
                                size: 18.0,
                              ),
                              Text(
                                voteStar(media.voteAverage),
                                style: const TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.normal,
                                    color: Colors.white),
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
