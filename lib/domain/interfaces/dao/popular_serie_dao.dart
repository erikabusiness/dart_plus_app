import '../models/series/popular_series.dart';

abstract class PopularSeriesDaoInterface {
  Future<int> insertPopularSeries(PopularSeries newSerie);
  Future<void> updatePopularSeries(PopularSeries updateSerie);
  Future<List<PopularSeries>> readPopularSeries();
  Future<List<PopularSeries>> readPopularSeriesFavorites();
}