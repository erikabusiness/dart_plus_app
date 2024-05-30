import 'package:dart_plus_app/models/media.dart';
import 'package:equatable/equatable.dart';

abstract class FavoriteEvent extends Equatable {
  const FavoriteEvent();

  @override
  List<Object> get props => [];
}

class ToggleFavorite extends FavoriteEvent {
  final Media media;

  const ToggleFavorite(this.media);

  @override
  List<Object> get props => [media];
}

class LoadFavorite extends FavoriteEvent {
  final Media media;

  const LoadFavorite(this.media);

  @override
  List<Object> get props => [media];
}
