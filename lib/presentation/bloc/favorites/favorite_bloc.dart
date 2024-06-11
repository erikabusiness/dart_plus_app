import 'dart:async';

import 'package:dart_plus_app/domain/interfaces/dao/favorites_dao.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/interfaces/models/favorites/favorites.dart';
import '../../../domain/interfaces/models/media.dart';

part 'favorite_event.dart';
part 'favorite_state.dart';

class FavoriteBloc extends Bloc<FavoriteEvent, FavoriteState> {
  final FavoritesDao _favoriteDao;

  FavoriteBloc(this._favoriteDao) : super(const FavoriteInitial(false)) {

    on<LoadFavorite>((event, emit) async {
      emit(const FavoriteLoading());
      try {
        final isFavorite = await _favoriteDao.isFavorite(event.media);
        emit(FavoriteInitial(isFavorite));
      } catch (_) {
        emit(const FavoriteError(message: "Erro na chamada do loadFavorite"));
      }
    });


    on<ToggleFavorite>((event, emit) async {
      emit(const FavoriteLoading());
      try {
        final isFavorite = await _favoriteDao.isFavorite(event.media);
        await _favoriteDao.toggleFavorite(event.media);
        emit(FavoriteInitial(!isFavorite));
      } catch (_) {
        emit(const FavoriteError(message: "Erro na chamada do toggleFavorite"));
      }
    });


    on<GetFavoritesEvent>((event, emit) async {
      emit(const FavoriteLoading());
      await Future.delayed(const Duration(seconds: 1));
      try {
        final favorites = await _favoriteDao.getFavorites();
        emit(FavoriteLoaded(favorites: favorites));
      } catch (_) {
        emit(const FavoriteError(message: "Erro na chamada do getFavorites"));
      }
    });
  }

}
