import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile/custom/wide_button.dart';
import 'package:mobile/screens/register/register_screen.dart';

void main() {
  testWidgets('Register Screen has Email, Password and Confirm Password fields',
      (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Material(child: RegisterScreen()),
      ),
    );

    final emailFieldFinder = find.byKey(const Key('email-field'));
    final passwordFieldFinder = find.byKey(const Key('password-field'));
    final confirmPasswordFieldFinder =
        find.byKey(const Key('confirm-password-field'));

    expect(emailFieldFinder, findsOneWidget);
    expect(passwordFieldFinder, findsOneWidget);
    expect(confirmPasswordFieldFinder, findsOneWidget);
  });

  testWidgets('All fields in Register Screen are required', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Material(child: RegisterScreen()),
      ),
    );

    final button = find.byType(WideButton);
    await tester.tap(button);
    await tester.pump();
    final errorMessage =
        find.textContaining(RegExp('required', caseSensitive: false));
    expect(errorMessage, findsWidgets);
  });

  testWidgets('Password less than 8 characters shows length error',
      (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Material(child: RegisterScreen()),
      ),
    );
    final passwordFieldFinder = find.byKey(const Key('password-field'));
    await tester.enterText(passwordFieldFinder, '1234567');
    final button = find.byType(WideButton);
    await tester.tap(button);
    await tester.pump();
    final errorMessage =
        find.textContaining(RegExp('8 characters', caseSensitive: false));
    expect(errorMessage, findsWidgets);
  });

  testWidgets('Password mismatch shows mismatch error', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Material(child: RegisterScreen()),
      ),
    );
    final passwordFieldFinder = find.byKey(const Key('password-field'));
    final confirmPasswordFieldFinder =
        find.byKey(const Key('confirm-password-field'));
    await tester.enterText(passwordFieldFinder, '12345678');
    await tester.enterText(confirmPasswordFieldFinder, '12345679');
    final button = find.byType(WideButton);
    await tester.tap(button);
    await tester.pump();

    final errorMessage =
        find.textContaining(RegExp('do not match', caseSensitive: false));
    expect(errorMessage, findsWidgets);
  });
}
