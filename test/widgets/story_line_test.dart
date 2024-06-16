import 'package:dart_plus_app/presentation/widgets/story_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('The widget story line displays the movie or series synopsis',
      (tester) async {
    await tester.pumpWidget(
      MaterialApp(
          home: WidgetStoryLine(
        synopsisTitle: 'Sinopse',
        synopsisText: 'text',
      )),
    );

    final synopsisTitleFinder = find.text('Sinopse');
    final synopsisTextFinder = find.text('text');

    expect(synopsisTitleFinder, findsOneWidget);
    expect(synopsisTextFinder, findsOneWidget);
  });
}
