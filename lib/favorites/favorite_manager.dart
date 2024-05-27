import 'package:shared_preferences/shared_preferences.dart';

class FavoriteManager {
  static const String _favoritesKey = 'favorites';

  Future<void> toggleFavorite(int mediaId) async {
    final prefs = await SharedPreferences.getInstance();
    final favorites = prefs.getStringList(_favoritesKey) ?? [];
    final mediaIdStr = mediaId.toString();
    if (favorites.contains(mediaIdStr)) {
      favorites.remove(mediaIdStr);
    } else {
      favorites.add(mediaIdStr);
    }
    await prefs.setStringList(_favoritesKey, favorites);
  }

  Future<bool> isFavorite(int mediaId) async {
    final prefs = await SharedPreferences.getInstance();
    final favorites = prefs.getStringList(_favoritesKey) ?? [];
    return favorites.contains(mediaId.toString());
  }

  Future<List<int>> getFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final favorites = prefs.getStringList(_favoritesKey) ?? [];
    return favorites.map((id) => int.parse(id)).toList();
  }
}
