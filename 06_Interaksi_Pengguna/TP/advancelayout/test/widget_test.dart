// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:advancelayout/main.dart';

void main() {
  testWidgets('BottomNavigationBar navigation test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Verify that the initial page is Beranda
    expect(find.text('Ini Halaman Beranda'), findsOneWidget);
    expect(find.text('Ini Halaman Wisata'), findsNothing);
    expect(find.text('Ini Halaman Profile'), findsNothing);

    // Tap the Wisata tab
    await tester.tap(find.byIcon(Icons.explore_outlined));
    await tester.pump();

    // Verify that the page changed to Wisata
    expect(find.text('Ini Halaman Beranda'), findsNothing);
    expect(find.text('Ini Halaman Wisata'), findsOneWidget);
    expect(find.text('Ini Halaman Profile'), findsNothing);

    // Tap the Profile tab
    await tester.tap(find.byIcon(Icons.person_outlined));
    await tester.pump();

    // Verify that the page changed to Profile
    expect(find.text('Ini Halaman Beranda'), findsNothing);
    expect(find.text('Ini Halaman Wisata'), findsNothing);
    expect(find.text('Ini Halaman Profile'), findsOneWidget);
  });
}
