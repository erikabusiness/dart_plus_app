import 'package:dart_plus_app/presentation/widgets/title_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('The widget title section displays a title', (tester) async {

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: WidgetTitleSection(title: 'Titulo'),
        ),
      ),
    );

    await expectLater(
      find.byType(WidgetTitleSection),
      matchesGoldenFile('../assets/home-page.png'),
    );
  });
}
