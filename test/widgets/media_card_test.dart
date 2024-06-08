import 'package:dart_plus_app/domain/interfaces/models/popular_movies.dart';
import 'package:dart_plus_app/presentation/widgets/media_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final PopularMovie movieMock = PopularMovie(
    originalTitle: 'Furiosa: Uma Saga Mad Max',
    video: false,
    id: 1,
    releaseDate: '2020-02-29',
    originalLanguage: 'en',
    overview: 'Overview',
    popularity: 100.0,
    voteAverage: 10.0,
    voteCount: 10,
    posterPath: '/isXDRoaeOm7BJVXVwPzPTnKWKqi.jpg',
    backdropPath: '',
    adult: false,
    title: 'Furiosa: Uma Saga Mad Max',
    genreIds: [28, 878],
    isFavorite: false,
  );

  testWidgets('Widget media card displays an image', (tester) async {
    await tester.pumpWidget(
        MaterialApp(home: MediaCard(media: movieMock, onClick: () {})));

    expect(find.byType(MediaCard), findsOneWidget);
  });
}
