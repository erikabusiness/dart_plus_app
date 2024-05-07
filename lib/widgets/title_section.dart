import 'package:flutter/material.dart';

class WidgetTitleSection extends StatelessWidget {
  final String title;

  const WidgetTitleSection({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: Text(
            '$title',
            textAlign: TextAlign.left,
            style: const TextStyle(
              fontSize: 18,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
