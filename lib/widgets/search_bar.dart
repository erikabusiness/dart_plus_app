import 'package:dart_plus_app/styles/colors.dart';
import 'package:flutter/material.dart';

class WidgetSearchBar extends StatelessWidget {
  final TextEditingController controller;
  final ValueChanged<String> onChanged;
  final VoidCallback onMicPressed;

  const WidgetSearchBar({
    super.key,
    required this.controller,
    required this.onChanged,
    required this.onMicPressed,
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
        child: Row(
          children: [
            Expanded(
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
            IconButton(
              icon: const Icon(Icons.mic),
              onPressed: onMicPressed,
            ),
          ],
        ),
      ),
    );
  }
}
