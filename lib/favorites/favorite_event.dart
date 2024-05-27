import 'package:equatable/equatable.dart';

abstract class FavoriteEvent extends Equatable {
  const FavoriteEvent();

  @override
  List<Object> get props => [];
}

class ToggleFavorite extends FavoriteEvent {
  final int mediaId;

  const ToggleFavorite(this.mediaId);

  @override
  List<Object> get props => [mediaId];
}

class LoadFavorite extends FavoriteEvent {
  final int mediaId;

  const LoadFavorite(this.mediaId);

  @override
  List<Object> get props => [mediaId];
}
