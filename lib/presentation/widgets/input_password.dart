import 'package:flutter/material.dart';
import '../styles/colors.dart';

class InputPasswordWidget extends StatefulWidget {
  final String hint;
  final String inputName;
  final double width;
  final double height;
  final double borderRadius;
  final Color fontColor;
  final IconData? prefixIcon;
  final TextEditingController? controller;
  final FormFieldValidator<String>? validator;

  const InputPasswordWidget({
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
  State<InputPasswordWidget> createState() =>
      _InputPasswordWidgetState();
}

class _InputPasswordWidgetState
    extends State<InputPasswordWidget> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    final InputBorder borderType = OutlineInputBorder(
      borderRadius: BorderRadius.circular(widget.borderRadius),
    );

    return SizedBox(
      width: widget.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.inputName,
            textAlign: TextAlign.start,
            style: TextStyle(
              color: widget.fontColor,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 8.0),
          TextFormField(
            validator: widget.validator,
            style: TextStyle(color: widget.fontColor),
            controller: widget.controller,
            obscureText: _obscureText,
            decoration: InputDecoration(
              errorMaxLines: 4,
              prefixIcon: widget.prefixIcon != null
                  ? Icon(
                      widget.prefixIcon,
                      color: widget.fontColor,
                    )
                  : null,
              suffixIcon: IconButton(
                icon: Icon(
                  _obscureText ? Icons.visibility : Icons.visibility_off,
                  color: widget.fontColor,
                ),
                onPressed: () {
                  setState(() {
                    _obscureText = !_obscureText;
                  });
                },
              ),
              border: borderType,
              hintText: widget.hint,
              hintStyle: const TextStyle(
                color: CustomColor.defaultTextColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}