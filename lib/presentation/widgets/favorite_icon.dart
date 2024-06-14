import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/interfaces/models/media.dart';
import '../bloc/favorites/favorite_bloc.dart';

class FavoriteIconWidget extends StatelessWidget {
  final double size;
  final Media media;
  final void Function(bool isFavorite) onPressed;

  const FavoriteIconWidget({
    super.key,
    this.size = 32,
    required this.media,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavoriteBloc, FavoriteState>(
      builder: (context, state) {
        bool isFavorite;
        if (state is FavoriteToggled) {
          isFavorite = state.isFavorite;
        } else {
          isFavorite = true;
        }

        return IconButton(
          icon: Icon(
            isFavorite ? Icons.favorite : Icons.favorite_border_outlined,
            size: size,
          ),
          onPressed: () {
            BlocProvider.of<FavoriteBloc>(context).add(ToggleFavorite(media));
            onPressed(!isFavorite);
          },
        );
      },
    );
  }
}
