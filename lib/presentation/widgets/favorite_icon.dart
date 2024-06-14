import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/interfaces/models/media.dart';
import '../bloc/favorites/favorite_bloc.dart';
import '../styles/colors.dart';
import '../styles/strings.dart';

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
    return BlocListener<FavoriteBloc, FavoriteState>(
      listener: (context, state) {
        if (state is FavoriteToggled) {
          final message = state.isFavorite
              ? "O filme ${media.title} ${StringsConstants.favoriteAdded} "
              : "O filme ${media.title} ${StringsConstants.favoriteRemoved} ";
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: CustomColor.defaultBackgroundColor,
            content: Text(
              message,
              textAlign: TextAlign.center,
              style: const TextStyle(
                  color: CustomColor.defaultTextColor,
                fontSize: 16,
              ),
            ),
          ));
        }
      },
      child: BlocBuilder<FavoriteBloc, FavoriteState>(
        builder: (context, state) {
          bool isFavorite;
          if (state is FavoriteInitial) {
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
            },
          );
        },
      ),
    );
  }
}
