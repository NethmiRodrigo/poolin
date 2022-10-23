import 'package:dio/dio.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:poolin/colors.dart';

import 'package:poolin/custom/wide_button.dart';
import 'package:poolin/fonts.dart';
import 'package:poolin/screens/login/login_screen.dart';
import 'package:poolin/services/reset_password_service.dart';
import 'package:poolin/utils/widget_functions.dart';
import 'package:poolin/screens/forgot-password/email_sent_screen.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  ForogtPasswordScreenState createState() {
    return ForogtPasswordScreenState();
  }
}

class ForogtPasswordScreenState extends State<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _email = TextEditingController();
  final _storage = const FlutterSecureStorage();

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    const double padding = 16;
    const sidePadding = EdgeInsets.symmetric(horizontal: padding);
    // Build a Form widget using the _formKey created above.
    return Scaffold(
      body: SizedBox(
        width: size.width,
        height: size.height,
        child: Padding(
          padding: sidePadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              addVerticalSpace(160),
              const Text(
                "Forgot Password?",
                style: BlipFonts.title,
              ),
              addVerticalSpace(16),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 48),
                child: Text(
                  'Enter the email address you \nused when you joined and \nwe’ll send you the instructions \nto reset your password',
                  style: BlipFonts.label,
                  textAlign: TextAlign.center,
                ),
              ),
              addVerticalSpace(48),
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                      style: Theme.of(context).textTheme.labelLarge,
                      controller: _email,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.email_outlined),
                        hintText: 'Enter University Email',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Email is required';
                        }

                        return null;
                      },
                    ),
                    addVerticalSpace(40),
                    WideButton(
                        text: 'Send Code',
                        onPressedAction: () async {
                          if (_formKey.currentState!.validate()) {
                            Response response = await submitEmail(_email.text);

                            if (response.statusCode == 200) {
                              await _storage.write(
                                  key: 'KEY_EMAIL', value: _email.text);

                              if (!mounted) {
                                return;
                              }

                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const EmailSentScreen()),
                              );
                            }
                          }
                        }),
                    addVerticalSpace(16),
                    RichText(
                      text: TextSpan(children: [
                        const TextSpan(
                            text: 'Return to ', style: BlipFonts.outline),
                        TextSpan(
                            text: 'Sign in',
                            style: BlipFonts.outlineBold.merge(
                                const TextStyle(color: BlipColors.orange)),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const LoginScreen()),
                                );
                              }),
                      ]),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
