import 'package:dart_plus_app/data/dao/favorites_dao.dart';

import '../../../domain/interfaces/models/favorites.dart';
import '../../../domain/interfaces/models/media.dart';


class FavoriteManager {
  final _favoriteDao = FavoriteDao();

  Future<void> toggleFavorite(Media media) async {
    await _favoriteDao.toggleFavorite(media);
  }

  Future<bool> isFavorite(Media media) async {
    return await _favoriteDao.isFavorite(media);
  }

  Future<List<Favorites>> getFavorites() async {
    try {
      List<Favorites> favorites = await _favoriteDao.getFavorites();
      return favorites;
    } catch (e) {
      return [];
    }
    
  }
}