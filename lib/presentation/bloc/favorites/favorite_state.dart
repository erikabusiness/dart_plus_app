part of 'favorite_bloc.dart';

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

class FavoriteLoading extends FavoriteState {
  const FavoriteLoading();
}

class FavoriteError extends FavoriteState {
  final String message;

  const FavoriteError({required this.message});

  @override
  List<Object> get props => [message];
}

class FavoriteLoaded extends FavoriteState {
  final List<Favorites> favorites;

  const FavoriteLoaded({required this.favorites});

  @override
  List<Object> get props => [favorites];
}

class FavoriteToggled extends FavoriteState {
  final bool isFavorite;

  const FavoriteToggled({required this.isFavorite});

  @override
  List<Object> get props => [isFavorite];
}
