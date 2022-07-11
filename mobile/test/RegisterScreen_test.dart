import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile/views/RegisterScreen.dart';

void main() {
  testWidgets('Register Screen has Email, Password and Confirm Password fields',
      (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Material(child: RegisterScreen()),
      ),
    );

    final emailFieldFinder = find.textContaining('Email');
    final passwordFieldFinder =
        find.textContaining(RegExp('Password', caseSensitive: false));

    expect(emailFieldFinder, findsOneWidget);
    expect(passwordFieldFinder, findsNWidgets(2));
  });
}
