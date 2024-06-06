import '../models/popular_series.dart';

abstract class SeriesRepository {
  Future<List<PopularSeries>> getAllPopularSeries();
}