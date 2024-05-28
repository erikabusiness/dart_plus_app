import 'package:dart_plus_app/favorites/favorite_bloc.dart';
import 'package:dart_plus_app/favorites/favorite_event.dart';
import 'package:dart_plus_app/favorites/favorite_state.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoriteIconWidget extends StatelessWidget {
  final double size;
  final int mediaId;

  const FavoriteIconWidget({
    super.key,
    this.size = 32,
    required this.mediaId,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavoriteBloc, FavoriteState>(
      builder: (context, state) {
        bool isFavorite = (state as FavoriteInitial).isFavorite;

        return IconButton(
          icon: Icon(
            isFavorite ? Icons.favorite : Icons.favorite_border_outlined,
            size: size,
            //color: isFavorite ? Colors.red : null,
          ),
          onPressed: () {
            BlocProvider.of<FavoriteBloc>(context)
                .add(ToggleFavorite(mediaId));
          },
        );
      },
    );
  }
}
