import 'package:dart_plus_app/data/dao/favorites_dao.dart';
import 'package:dart_plus_app/models/favorites.dart';
import 'package:dart_plus_app/models/media.dart';

class FavoriteManager {
  final _favoriteDao = FavoriteDao();

  Future<void> toggleFavorite(Media media) async {
    await _favoriteDao.toggleFavorite(media);
  }

  Future<bool> isFavorite(Media media) async {
    return await _favoriteDao.isFavorite(media);
  }

  Future<List<Favorites>> getFavorites() async {
    return await _favoriteDao.getFavorites();
  }
}
