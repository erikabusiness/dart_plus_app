import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';
import 'package:dart_plus_app/presentation/styles/colors.dart';

class ToastificationWidget {
  static void show({
    required BuildContext context,
    required String message,
    required ToastificationType type,
    ToastificationStyle style = ToastificationStyle.fillColored,
    Alignment alignment = Alignment.topCenter,
    Duration autoCloseDuration = const Duration(seconds: 3),
  }) {
    toastification.show(
      style: style,
      autoCloseDuration: autoCloseDuration,
      type: type,
      alignment: alignment,
      context: context,
      title: Text(
        message,
        textAlign: TextAlign.center,
        style: const TextStyle(
          color: CustomColor.defaultTextColor,
          fontSize: 16,
        ),
      ),
    );
  }
}
