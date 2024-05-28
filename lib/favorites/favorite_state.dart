import 'package:equatable/equatable.dart';

abstract class FavoriteState extends Equatable {
  const FavoriteState();

  @override
  List<Object> get props => [];
}

class FavoriteInitial extends FavoriteState {
  final bool isFavorite;

  const FavoriteInitial(this.isFavorite);

  @override
  List<Object> get props => [isFavorite];
}
