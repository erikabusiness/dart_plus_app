import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../styles/colors.dart';

class WidgetTitleSection extends StatelessWidget {
  final String title;
  final double padding;
  final double margin;
  final double sizeTitle;
  final FontWeight fontWeight;
  final Color fontColor;
  final TextAlign textAlign; 

  const WidgetTitleSection({
    super.key,
    required this.title,
    this.padding = 16,
    this.sizeTitle = 18,
    this.fontWeight = FontWeight.bold,
    this.fontColor = CustomColor.defaultTextColor,
    this.margin = 0,
    this.textAlign = TextAlign.start
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(padding),
          margin: EdgeInsets.all(margin),
          child: Text(
            title,
            textAlign: textAlign,
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
