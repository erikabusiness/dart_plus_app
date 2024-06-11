import 'package:dart_plus_app/domain/interfaces/models/popular_movies.dart';
import 'package:dart_plus_app/presentation/widgets/media_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockFunction extends Mock {
  void call();
}

void main() {
  final PopularMovie movieMock = PopularMovie(
    originalTitle: 'Furiosa: Uma Saga Mad Max',
    video: false,
    id: 1,
    overview: 'Overview',
    voteAverage: 10.0,
    posterPath: '/isXDRoaeOm7BJVXVwPzPTnKWKqi.jpg',
    title: 'Furiosa: Uma Saga Mad Max',
    genreIds: [28, 878],
    isFavorite: false,
  );

  testWidgets('MediaCard displays correctly', (tester) async {
    await tester.pumpWidget(
      MaterialApp(home: MediaCard(media: movieMock, onClick: () {})),
    );

    // Verifica se o MediaCard é renderizado
    expect(find.byType(MediaCard), findsOneWidget);
    // Verifica se a Image é renderizada
    expect(find.byType(Image), findsOneWidget);
    // Verifica se o Icon de estrela é renderizado
    expect(find.byIcon(Icons.star), findsOneWidget);
  });

  testWidgets('MediaCard displays placeholder image when network image fails to load', (tester) async {
    await tester.pumpWidget(
      MaterialApp(home: MediaCard(media: movieMock, onClick: () {})),
    );

    await tester.pumpAndSettle();

    // Verifica se a imagem de placeholder é exibida quando a imagem da rede falha
    expect(find.image(const AssetImage('assets/image_not_available.png')), findsOneWidget);
  });

  testWidgets('MediaCard calls onClick when tapped', (tester) async {

    // Criação de uma função mock
    final mockFunction = MockFunction();

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Center(
            child: MediaCard(
              media: movieMock,
              onClick: () {
                mockFunction();
              },
            ),
          ),
        ),
      ),
    );

    // Ensure the MediaCard is fully on-screen and interactable
    await tester.pumpAndSettle();

    // Simula o clique no MediaCard
    await tester.tap(find.byType(MediaCard));
    await tester.pumpAndSettle();

    // Verifica se a função mock foi chamada
    verify(() => mockFunction()).called(1);

  });
}
