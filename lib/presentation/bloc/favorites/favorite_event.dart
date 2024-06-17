part of 'favorite_bloc.dart';

abstract class FavoriteEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class ToggleFavorite extends FavoriteEvent {
  final Media media;

  ToggleFavorite(this.media);

  @override
  List<Object> get props => [media];
}

class LoadFavorite extends FavoriteEvent {
  final Media media;

  LoadFavorite(this.media);

  @override
  List<Object> get props => [media];
}

class GetFavoritesEvent extends FavoriteEvent {

  GetFavoritesEvent();

  @override
  List<Object> get props => [];
}