import 'package:flutter/material.dart';
import '../styles/colors.dart';

class InputTextWidget extends StatelessWidget {
  final String hint;
  final String inputName;
  final double width;
  final double height;
  final double borderRadius;
  final Color fontColor;
  final IconData? prefixIcon;
  final TextEditingController? controller;
  final FormFieldValidator<String>? validator;

  const InputTextWidget({
    super.key,
    required this.inputName,
    this.controller,
    this.hint = "",
    this.height = 56,
    this.width = double.infinity,
    this.borderRadius = 15,
    this.fontColor = CustomColor.defaultTextColor,
    this.prefixIcon,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    final InputBorder borderType = OutlineInputBorder(
      borderRadius: BorderRadius.circular(borderRadius),
    );

    return SizedBox(
      width: width,
      child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              inputName,
              textAlign: TextAlign.start,
              style: const TextStyle(
                color: CustomColor.defaultTextColor,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 8.0),
            TextFormField(
              validator: validator,
              style: TextStyle(color: fontColor),
              controller: controller,
              decoration: InputDecoration(
                errorMaxLines: 4,
                prefixIcon: prefixIcon != null
                    ? Icon(
                        prefixIcon,
                        color: fontColor,
                      )
                    : null,
                border: borderType,
                hintText: hint,
                hintStyle: const TextStyle(
                  color: CustomColor.defaultTextColor,
                ),
              ),
            )
          ]),
    );
  }
}
