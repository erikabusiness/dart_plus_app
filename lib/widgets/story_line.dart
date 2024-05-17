import 'package:dart_plus_app/styles/colors.dart';
import 'package:dart_plus_app/widgets/title_section.dart';
import 'package:flutter/material.dart';

class WidgetStoryLine extends StatelessWidget {
  final String synopsisTitle;
  final String synopsisText;
  final double width;
  final double padding;
  final Color textColor;

  const WidgetStoryLine(
      {super.key,
      required this.synopsisTitle,
      required this.synopsisText,
      required this.width,
      this.padding = 12,
      this.textColor = CustomColor.defaultTextColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(padding),
      width: width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          WidgetTitleSection(
            title: synopsisTitle,
            padding: 0,
          ),
          SizedBox(
            height: 12,
          ),
          Text(
            synopsisText,
            style: TextStyle(color: textColor),
            textAlign: TextAlign.justify,
          ),
        ],
      ),
    );
  }
}
