// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:omdbassestment/main.dart';
import 'package:omdbassestment/ui/home/Home.dart';
import 'package:omdbassestment/ui/splash/Splash.dart';
import 'package:omdbassestment/ui/splash/SplashState.dart';

void main() {

  testWidgets('Splash Widget Test', (WidgetTester tester) async {
    // Build our widget and trigger a frame.
    await tester.pumpWidget(const MaterialApp(
      home: Splash(),
    ));

    // Verify that the Splash widget is rendered.
    expect(find.byType(Splash), findsOneWidget);

    // Simulate the timer completion (2 seconds delay).
    await tester.pump(const Duration(seconds: 2));

    // Wait for the asynchronous navigation to complete.
    await tester.pumpAndSettle();

    // Ensure that the navigation is triggered after the timer completes.
    expect(find.byType(Home), findsOneWidget);
  });
}
