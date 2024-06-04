import 'package:dart_plus_app/models/media.dart';
import 'package:dart_plus_app/utils/utils_functions.dart';
import 'package:flutter/material.dart';

class GenreLabelWidget extends StatelessWidget {
  final Media media;
  final bool isCompact;

  const GenreLabelWidget(
      {super.key, required this.media, required this.isCompact});

  @override
  Widget build(BuildContext context) {
    List<String?> genres = UtilsFunctions.genreMap(media.genreIds);

    return Wrap(
      spacing: 8.0,
      runSpacing: 4.0,
      children: genres.map((genre) {
        return Chip(
          label: Text(
            genre!,
            style: TextStyle(fontSize: isCompact ? 12.0 : 14.0),
          ),
          padding: const EdgeInsets.all(2.0),
          materialTapTargetSize: isCompact
              ? MaterialTapTargetSize.shrinkWrap
              : MaterialTapTargetSize.padded,
        );
      }).toList(),
    );
  }
}
