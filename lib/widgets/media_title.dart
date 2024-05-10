import 'package:flutter/material.dart';

class MediaTitle extends StatelessWidget {
  final String title;

  
  const MediaTitle({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
