import 'package:dart_plus_app/presentation/styles/colors.dart';
import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  final void Function() onClick;
  final String text;
  final Color fontColor;
  final double textFontSize;
  final double borderRadius;
  final double width;
  final double height;
  final Color primaryColorGradient;
  final Color secondaryColorGradient;

  const ButtonWidget({
    super.key,
    required this.onClick,
    required this.text,
    this.fontColor = CustomColor.defaultTextColor,
    this.textFontSize = 20,
    this.borderRadius = 15,
    this.width = double.infinity,
    this.height = 50,
    this.primaryColorGradient =Colors.black,
    this.secondaryColorGradient = Colors.grey,
  });

  @override
  Widget build(BuildContext context) {
    final Gradient gradient = LinearGradient(
      colors: [primaryColorGradient, secondaryColorGradient],
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
    );

    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        gradient: gradient,
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadius)),
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
        ),
        onPressed: onClick,
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: fontColor,
            fontSize: textFontSize,
          ),
        ),
      ),
    );
  }
}
