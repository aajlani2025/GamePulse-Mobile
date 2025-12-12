// This is a basic Flutter widget test.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:movesense_app/screens/home_screen.dart';

void main() {
  testWidgets('HomeScreen loads', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(home: HomeScreen()),
    );

    expect(find.byType(HomeScreen), findsOneWidget);
  });
}
