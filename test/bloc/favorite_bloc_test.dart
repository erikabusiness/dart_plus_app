import 'package:bloc_test/bloc_test.dart';
import 'package:dart_plus_app/domain/interfaces/dao/favorites_dao.dart';
import 'package:dart_plus_app/domain/interfaces/models/favorites/favorites.dart';
import 'package:dart_plus_app/domain/interfaces/models/media.dart';
import 'package:dart_plus_app/presentation/bloc/favorites/favorite_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class FavoriteDaoMock extends Mock implements FavoritesDao {
  @override
  Future<bool> isFavorite(Media media) async {
    return media.isFavorite;
  }

  @override
  Future<List<Favorites>> getFavorites() async {
    final Favorites favorite = Favorites(
      id: 1,
      title: 'Filme 1',
      posterPath: 'poster1.jpg',
      genreIds: [1, 2, 3],
      overview: 'Overview do Filme 1',
      voteAverage: 7.5,
      isFavorite: false,
      video: false,
    );
    List<Favorites> favoriteList = [favorite];
    return favoriteList;
  }

  @override
  Future<void> toggleFavorite(Media media) async {}
}

class MediaFake extends Fake implements Media {}

void main() {
  final Favorites favorite = Favorites(
    id: 1,
    title: 'Filme 1',
    posterPath: 'poster1.jpg',
    genreIds: [1, 2, 3],
    overview: 'Overview do Filme 1',
    voteAverage: 7.5,
    isFavorite: false,
    video: false,
  );

  final List<Favorites> favoritesList = [
    favorite,
  ];

  setUpAll(() {
    registerFallbackValue(MediaFake());
  });

  group('Favorite Bloc', () {
    late FavoriteDaoMock mockFavoriteDao;

    setUp(() {
      mockFavoriteDao = FavoriteDaoMock();
    });

// Verificar se uma midia é favoritada ou não
    blocTest(
      'emits [FavoriteLoading, FavoriteInitial] when LoadFavorite is added',
      build: () => FavoriteBloc(
          mockFavoriteDao), //injetando banco de dados fake (mockFavoriteDao) dentro do FavoriteBloc
      act: (bloc) => bloc.add(LoadFavorite(favorite)),
      expect: () => [
        isA<FavoriteLoading>(),
        isA<FavoriteInitial>()
            .having((favorite) => favorite.isFavorite, 'isFavorite', false),
      ],
    );

    blocTest(
        'emits [FavoriteLoading, FavoriteInitial] when ToggleFavorite is added',
        build: () => FavoriteBloc(mockFavoriteDao),
        act: (bloc) => bloc.add(ToggleFavorite(favorite)),
        expect: () => [
              isA<FavoriteLoading>(),
              isA<FavoriteInitial>().having(
                  (favorite) => favorite.isFavorite, 'isFavorite', true),
            ]);

// testando se retorna lista
    blocTest(
      'emits []',
      build: () => FavoriteBloc(mockFavoriteDao),
      act: (bloc) => bloc.add(GetFavoritesEvent()),
      wait: const Duration(seconds: 2),
      expect: () => [
        isA<FavoriteLoading>(),
        isA<FavoriteLoaded>().having((list) => list.favorites.length,
            'favorites.length', favoritesList.length)
      ],
    );
  });
}
