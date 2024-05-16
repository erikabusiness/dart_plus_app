import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class WidgetTitleSection extends StatelessWidget {
  final String title;
  final double padding;
  final double margin;
  final double sizeTitle;
  final FontWeight fontWeight;
  final Color fontColor;

  const WidgetTitleSection({
    super.key,
    required this.title,
    this.padding = 16,
    this.sizeTitle = 18,
    this.fontWeight = FontWeight.bold,
    this.fontColor = Colors.white,
    this.margin = 0,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: EdgeInsets.all(padding),
          margin: EdgeInsets.all(margin),
          child: Text(
            title,
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
