import 'package:dart_plus_app/data/dao/favorites_dao.dart';

class FavoriteManager {
  final _favoriteDao = FavoriteDao();

  Future<void> toggleFavorite(int mediaId) async {
    final isFavorite = await this.isFavorite(mediaId);
    await _favoriteDao.toggleFavorite(mediaId, !isFavorite);
  }

  Future<bool> isFavorite(int mediaId) async {
    return await _favoriteDao.isFavorite(mediaId);
  }

  Future<List<int>> getFavorites() async {
    return await _favoriteDao.getFavorites();
  }
}
