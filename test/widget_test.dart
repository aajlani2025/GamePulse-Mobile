// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';

import 'package:movesense_app/providers/gateway_provider.dart';
import 'package:movesense_app/screens/gateway_screen.dart';

void main() {
  testWidgets('GatewayScreen loads', (WidgetTester tester) async {
    // Build our app with the provider structure
    await tester.pumpWidget(
      ChangeNotifierProvider(
        create: (_) => GatewayProvider(),
        child: const MaterialApp(home: GatewayScreen()),
      ),
    );

    // Verify that GatewayScreen is rendered (basic smoke test)
    expect(find.byType(GatewayScreen), findsOneWidget);
    
    // You can add more specific UI tests here based on your GatewayScreen content
    // For example, if it has a title or specific widgets:
    // expect(find.text('Gateway'), findsOneWidget);
  });
}
