import 'package:flutter/material.dart';

class ClickableText extends StatelessWidget {
  final String text;
  final double fontSize;
  final Color textColor;
  final void Function() onClick;

  const ClickableText({
    super.key,
    required this.text,
    required this.onClick,
    this.fontSize = 12,
    this.textColor = Colors.white
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: GestureDetector(
        onTap: () {
          onClick();
        },
        child: Text(
          text,
          style: TextStyle(
            color: textColor,
            decoration: TextDecoration.underline,
          ),
        ),
      ),
    );
  }
}
