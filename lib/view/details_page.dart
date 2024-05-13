import 'package:dart_plus_app/classes/media.dart';
import 'package:dart_plus_app/classes/popular_movies.dart';
import 'package:dart_plus_app/classes/popular_series.dart';
import 'package:dart_plus_app/widgets/grid_view_vertical.dart';
import 'package:dart_plus_app/widgets/list_view_horizontal.dart';
import 'package:dart_plus_app/widgets/media_trailer.dart';
import 'package:dart_plus_app/widgets/story_line.dart';
import 'package:dart_plus_app/widgets/title_section.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class DetailsPage extends StatelessWidget {
  const DetailsPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {

    final args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final Media mediaArgsDetail = args["mediaDetails"];
    final List<Media> moviesList = args["listMedias"];

    final Media media = mediaArgsDetail;
    List<Media> mediaItems = moviesList;

    String dateFormat(String date) {
      String dateMedia = date;
      List<String> modifiedDate = dateMedia.split('-').reversed.toList();
      return modifiedDate.join('-');
    }

    String voteStar(double vote) {
      var voteStar = vote / 2;
      return voteStar.toStringAsFixed(1);
    }

    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    WidgetMediaTrailer(),
                    const SizedBox(height: 8.0),
                    WidgetTitleSection(title: media.title, sizeTitle: 22.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: WidgetTitleSection(
                            title:
                                'Data de lançamento: ${dateFormat(media.releaseDate)}',
                            sizeTitle: 14.0,
                            fontWeight: FontWeight.normal,
                            padding: 4.0,
                          ),
                        ),
                        Row(
                          children: [
                            const Icon(
                              Icons.star,
                              color: Colors.yellow,
                              size: 18.0,
                            ),
                            WidgetTitleSection(
                              title: voteStar(media.voteAverage),
                              sizeTitle: 18.0,
                              fontWeight: FontWeight.normal,
                              padding: 4.0,
                            ),
                            SizedBox(
                              width: 8.0,
                            )
                          ],
                        ),
                      ],
                    ),
                    //WidgetTitleSection(title: media.genreIds, ), //genero
                    WidgetStoryLine(
                      synopsisTitle: 'Sinopse',
                      synopsisText: media.overview,
                      width: MediaQuery.of(context).size.width,
                      padding: 16,
                    ),
                    const WidgetTitleSection(title: 'Recomendados'),
                    SizedBox(
                      height: 4.0,
                    ),
                    WidgetListViewHorizontal(mediaItems: mediaItems),
                  ],
                ),
              ),
            )
          ],
        ));
  }
}
