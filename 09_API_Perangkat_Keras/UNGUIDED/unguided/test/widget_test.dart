// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';

import 'package:unguided_image_picker/main.dart';

void main() {
  testWidgets('App builds without errors', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const UnguidedImagePickerApp());

    // Verify that the app title is present.
    expect(find.text('Unguided - Pemilihan Gambar'), findsOneWidget);

    // Verify that the Gallery button is present.
    expect(find.text('Gallery'), findsOneWidget);

    // Verify that the Camera button is present.
    expect(find.text('Camera'), findsOneWidget);

    // Verify that the Delete button is present.
    expect(find.text('Hapus Gambar'), findsOneWidget);
  });
}
