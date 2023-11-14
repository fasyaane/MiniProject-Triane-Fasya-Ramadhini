import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:notesapp/pages/register.dart';

void main() {
  testWidgets('Judul halaman harus Registrasi ', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: RegisterScreen(),
    ));

    expect(find.text('Registrasi'), findsWidgets);
  });
}
