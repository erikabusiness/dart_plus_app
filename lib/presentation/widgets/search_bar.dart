import 'package:flutter/material.dart';

import '../styles/colors.dart';

class WidgetSearchBar extends StatelessWidget {
  final TextEditingController controller;
  final ValueChanged<String> onChanged;

  const WidgetSearchBar({
    super.key,
    required this.controller,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        height: 50.0,
        decoration: BoxDecoration(
          color: Colors.transparent,
          border: Border.all(color: CustomColor.defaultTextColor),
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: TextField(
          controller: controller,
          onChanged: onChanged,
          decoration: const InputDecoration(
            hintText: 'Pesquisar...',
            prefixIcon: Icon(Icons.search),
            border: InputBorder.none,
            contentPadding: EdgeInsets.symmetric(vertical: 10.0),
          ),
        ),
      ),
    );
  }
}
