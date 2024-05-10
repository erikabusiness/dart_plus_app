import 'package:flutter/material.dart';

class WidgetTitleSection extends StatelessWidget {
  final String title;
  final double padding;

  const WidgetTitleSection({super.key, required this.title, this.padding = 16});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: EdgeInsets.all(padding),
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
