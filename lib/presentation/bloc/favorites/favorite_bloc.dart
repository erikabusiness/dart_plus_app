import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/interfaces/models/favorites/favorites.dart';
import '../../../domain/interfaces/models/media.dart';
import 'favorite_manager.dart';

part 'favorite_event.dart';
part 'favorite_state.dart';

class FavoriteBloc extends Bloc<FavoriteEvent, FavoriteState> {
  final FavoriteManager _favoriteManager = FavoriteManager();

  FavoriteBloc() : super(const FavoriteInitial(false)) {
    on<ToggleFavorite>(_onToggleFavorite);
    on<LoadFavorite>(_onLoadFavorite);
    on<GetFavoritesEvent>(_getFavorites);
  }

  Future<void> _onToggleFavorite(
      ToggleFavorite event,
      Emitter<FavoriteState> emit,
      ) async {
    final isFavorite = await _favoriteManager.isFavorite(event.media);
    await _favoriteManager.toggleFavorite(event.media);
    emit(FavoriteInitial(!isFavorite));
  }

  Future<void> _onLoadFavorite(
      LoadFavorite event,
      Emitter<FavoriteState> emit,
      ) async {
    final isFavorite = await _favoriteManager.isFavorite(event.media);
    emit(FavoriteInitial(isFavorite));
  }

  FutureOr<void> _getFavorites(
      GetFavoritesEvent event,
      Emitter<FavoriteState> emit,
      ) async {
    emit(const FavoriteLoading());
    await Future.delayed(const Duration(seconds: 1));
    try {
      final favorites = await _favoriteManager.getFavorites();
      emit(FavoriteLoaded(favorites: favorites));
    } catch (e) {
      emit(const FavoriteError(message: 'Falha ao carregar lista de favoritos'));
    }
  }
}
