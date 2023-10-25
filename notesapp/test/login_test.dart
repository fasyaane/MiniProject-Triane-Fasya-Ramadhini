import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:notesapp/pages/login.dart';

void main() {
  testWidgets('Judul halaman harus MASUK', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: LoginScreen(),
    ));

    expect(find.text('MASUK'), findsOneWidget);
  });
}
