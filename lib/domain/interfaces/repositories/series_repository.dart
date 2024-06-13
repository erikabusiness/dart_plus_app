import '../models/series/popular_series.dart';

abstract class SeriesRepository {
  Future<List<PopularSeries>> getAllPopularSeries();
  Future<List<PopularSeries>> getNextPopularSeries(int pageId);
}