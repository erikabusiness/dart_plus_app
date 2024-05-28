import 'package:flutter_bloc/flutter_bloc.dart';
import 'favorite_manager.dart';
import 'favorite_event.dart';
import 'favorite_state.dart';

class FavoriteBloc extends Bloc<FavoriteEvent, FavoriteState> {
  final FavoriteManager _favoriteManager = FavoriteManager();

  FavoriteBloc() : super(const FavoriteInitial(false)) {
    on<ToggleFavorite>(_onToggleFavorite);
    on<LoadFavorite>(_onLoadFavorite);
  }

  Future<void> _onToggleFavorite(
    ToggleFavorite event,
    Emitter<FavoriteState> emit,
  ) async {
    await _favoriteManager.toggleFavorite(event.mediaId);
    final isFavorite = await _favoriteManager.isFavorite(event.mediaId);
    emit(FavoriteInitial(isFavorite));
  }

  Future<void> _onLoadFavorite(
    LoadFavorite event,
    Emitter<FavoriteState> emit,
  ) async {
    final isFavorite = await _favoriteManager.isFavorite(event.mediaId);
    emit(FavoriteInitial(isFavorite));
  }
}
