import '../media.dart';
import 'package:json_annotation/json_annotation.dart';

part 'popular_series.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class PopularSeries extends Media {

  @override
  @JsonKey(name: "name")
  final String title;

  PopularSeries({
    required this.title,
    super.posterPath = '',
    super.genreIds,
    super.overview,
    super.voteAverage,
    super.isFavorite,
    required super.id,
  }) : super(title: title);

  @override
  Map<String, dynamic> toMap() => _$PopularSeriesToJson(this);

  factory PopularSeries.fromJson(Map<String, dynamic> json) =>
      _$PopularSeriesFromJson(json);
}
