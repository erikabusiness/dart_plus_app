import 'package:flutter/material.dart';

class WidgetTitleSection extends StatelessWidget {
  final String title;
  final double padding;
  final double sizeTitle;
  final FontWeight fontWeight;
  final Color fontColor;


  const WidgetTitleSection({super.key, required this.title, this.padding = 16, this.sizeTitle = 18, this.fontWeight = FontWeight.bold, this.fontColor = Colors.white});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: EdgeInsets.all(padding),
          child: Text(
            '$title',
            textAlign: TextAlign.left,
            style: TextStyle(
              fontSize: sizeTitle,
              color: fontColor,
              fontWeight: fontWeight,
            ),
          ),
        ),
      ],
    );
  }
}
