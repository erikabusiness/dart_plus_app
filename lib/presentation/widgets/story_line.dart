import 'package:dart_plus_app/presentation/widgets/title_section.dart';
import 'package:flutter/material.dart';

import '../styles/colors.dart';

class WidgetStoryLine extends StatelessWidget {
  final String synopsisTitle;
  final String synopsisText;
  double? width;
  final double padding;
  final Color textColor;

  WidgetStoryLine(
      {super.key,
      required this.synopsisTitle,
      required this.synopsisText,
      this.width,
      this.padding = 12,
      this.textColor = CustomColor.defaultTextColor});

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;

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
          const SizedBox(
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
