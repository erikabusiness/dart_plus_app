import 'package:dart_plus_app/favorites/favorite_bloc.dart';
import 'package:dart_plus_app/models/media.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoriteIconWidget extends StatelessWidget {
  final double size;
  final Media media;

  const FavoriteIconWidget({
    super.key,
    this.size = 32,
    required this.media,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavoriteBloc, FavoriteState>(
      builder: (context, state) {
        bool isFavorite;
        if(state is FavoriteInitial) {
          isFavorite = state.isFavorite;
        } else {
          isFavorite = true;
        }

        return IconButton(
          icon: Icon(
            isFavorite ? Icons.favorite : Icons.favorite_border_outlined,
            size: size,
            //color: isFavorite ? Colors.red : null,
          ),
          onPressed: () {
            BlocProvider.of<FavoriteBloc>(context).add(ToggleFavorite(media));
          },
        );
      },
    );
  }
}
