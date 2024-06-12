// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'app_router.dart';

abstract class _$AppRouter extends RootStackRouter {
  // ignore: unused_element
  _$AppRouter({super.navigatorKey});

  @override
  final Map<String, PageFactory> pagesMap = {
    CatalogoRoute.name: (routeData) {
      final args = routeData.argsAs<CatalogoRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: CatalogoPage(
          key: args.key,
          allMedias: args.allMedias,
        ),
      );
    },
    DetailsRoute.name: (routeData) {
      final args = routeData.argsAs<DetailsRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: DetailsPage(
          key: args.key,
          media: args.media,
          moviesList: args.moviesList,
        ),
      );
    },
    FavoritesRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const FavoritesPage(),
      );
    },
    MyHomeRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const MyHomePage(),
      );
    },
    SeeAllRoute.name: (routeData) {
      final args = routeData.argsAs<SeeAllRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: SeeAllPage(
          key: args.key,
          mediaItems: args.mediaItems,
          tela: args.tela,
        ),
      );
    },
  };
}

/// generated route for
/// [CatalogoPage]
class CatalogoRoute extends PageRouteInfo<CatalogoRouteArgs> {
  CatalogoRoute({
    Key? key,
    required List<Media> allMedias,
    List<PageRouteInfo>? children,
  }) : super(
          CatalogoRoute.name,
          args: CatalogoRouteArgs(
            key: key,
            allMedias: allMedias,
          ),
          initialChildren: children,
        );

  static const String name = 'CatalogoRoute';

  static const PageInfo<CatalogoRouteArgs> page =
      PageInfo<CatalogoRouteArgs>(name);
}

class CatalogoRouteArgs {
  const CatalogoRouteArgs({
    this.key,
    required this.allMedias,
  });

  final Key? key;

  final List<Media> allMedias;

  @override
  String toString() {
    return 'CatalogoRouteArgs{key: $key, allMedias: $allMedias}';
  }
}

/// generated route for
/// [DetailsPage]
class DetailsRoute extends PageRouteInfo<DetailsRouteArgs> {
  DetailsRoute({
    Key? key,
    required Media media,
    required List<Media> moviesList,
    List<PageRouteInfo>? children,
  }) : super(
          DetailsRoute.name,
          args: DetailsRouteArgs(
            key: key,
            media: media,
            moviesList: moviesList,
          ),
          initialChildren: children,
        );

  static const String name = 'DetailsRoute';

  static const PageInfo<DetailsRouteArgs> page =
      PageInfo<DetailsRouteArgs>(name);
}

class DetailsRouteArgs {
  const DetailsRouteArgs({
    this.key,
    required this.media,
    required this.moviesList,
  });

  final Key? key;

  final Media media;

  final List<Media> moviesList;

  @override
  String toString() {
    return 'DetailsRouteArgs{key: $key, media: $media, moviesList: $moviesList}';
  }
}

/// generated route for
/// [FavoritesPage]
class FavoritesRoute extends PageRouteInfo<void> {
  const FavoritesRoute({List<PageRouteInfo>? children})
      : super(
          FavoritesRoute.name,
          initialChildren: children,
        );

  static const String name = 'FavoritesRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [MyHomePage]
class MyHomeRoute extends PageRouteInfo<void> {
  const MyHomeRoute({List<PageRouteInfo>? children})
      : super(
          MyHomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'MyHomeRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [SeeAllPage]
class SeeAllRoute extends PageRouteInfo<SeeAllRouteArgs> {
  SeeAllRoute({
    Key? key,
    required List<Media> mediaItems,
    required String tela,
    List<PageRouteInfo>? children,
  }) : super(
          SeeAllRoute.name,
          args: SeeAllRouteArgs(
            key: key,
            mediaItems: mediaItems,
            tela: tela,
          ),
          initialChildren: children,
        );

  static const String name = 'SeeAllRoute';

  static const PageInfo<SeeAllRouteArgs> page = PageInfo<SeeAllRouteArgs>(name);
}

class SeeAllRouteArgs {
  const SeeAllRouteArgs({
    this.key,
    required this.mediaItems,
    required this.tela,
  });

  final Key? key;

  final List<Media> mediaItems;

  final String tela;

  @override
  String toString() {
    return 'SeeAllRouteArgs{key: $key, mediaItems: $mediaItems, tela: $tela}';
  }
}
