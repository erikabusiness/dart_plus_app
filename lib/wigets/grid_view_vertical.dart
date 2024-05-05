import 'package:flutter/material.dart';

class WidgetGridViewVertical extends StatelessWidget {
  final List<dynamic> mediaItems;

  const WidgetGridViewVertical({
    super.key,
    required this.mediaItems,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GridView.builder(
        padding: const EdgeInsets.only(left: 24, right: 24, top: 16),
        itemCount: mediaItems.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 24,
          childAspectRatio: 0.50,
        ),
        itemBuilder: (context, index) {
          dynamic media = mediaItems[index];
          return Column(
            children: [
              AspectRatio(
                aspectRatio: 0.7,
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(8),
                    ),
                    image: DecorationImage(
                      image: NetworkImage(media.posterPath),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: Center(
                    child: Container(
                      constraints: const BoxConstraints(
                        minHeight: 0,
                        maxHeight: double.infinity,
                      ),
                      child: Text(
                        media.title,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.normal,
                          overflow: TextOverflow.ellipsis,
                        ),
                        maxLines: 2,
                        softWrap: true,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
