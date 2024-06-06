part of 'favorite_bloc.dart';

sealed class FavoriteState extends Equatable {
  const FavoriteState();
}

class FavoriteInitial extends FavoriteState {
  final bool isFavorite;

  const FavoriteInitial(this.isFavorite);

  @override
  List<Object> get props => [isFavorite];
}

class FavoriteLoading extends FavoriteState {
  const FavoriteLoading();

  @override
  List<Object> get props => [];
}

class FavoriteLoaded extends FavoriteState {
  final List<Favorites> favorites;
  const FavoriteLoaded({required this.favorites});

  @override
  List<Object?> get props => [favorites];
}

class FavoriteError extends FavoriteState {
  final String message;
  const FavoriteError({required this.message});

  @override
  List<Object> get props => [message];
}