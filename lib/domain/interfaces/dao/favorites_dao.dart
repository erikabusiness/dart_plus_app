import '../models/favorites/favorites.dart';
import '../models/media.dart';

abstract class FavoritesDao {
  Future<void> toggleFavorite(Media media);
  Future<bool> isFavorite(Media media);
  Future<List<Favorites>> getFavorites();
}