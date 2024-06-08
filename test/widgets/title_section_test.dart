import 'package:dart_plus_app/presentation/widgets/title_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('The widget title section displays a title', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: WidgetTitleSection(
          title: 'title',
        ),
      ),
    );

    final title = find.text('title');
    expect(title, findsOneWidget);
  });
}
