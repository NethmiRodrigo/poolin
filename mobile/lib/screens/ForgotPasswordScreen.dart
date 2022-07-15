// ignore_for_file: unnecessary_null_comparison

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:mobile/custom/WideButton.dart';
import 'package:mobile/screens/LoginScreen.dart';
import 'package:mobile/services/reset_password_service.dart';
import 'package:mobile/utils/widget_functions.dart';
import 'package:mobile/screens/EmailSentScreen.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

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
              Text(
                "Forgot Password?",
                style: Theme.of(context)
                    .textTheme
                    .headline4!
                    .merge(const TextStyle(color: Colors.black)),
              ),
              addVerticalSpace(16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 48),
                child: Text(
                  'Enter the emal address you used when you joined and we’ll send you the instructions to reset your password.',
                  style: Theme.of(context).textTheme.bodyText1,
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
                      controller: _email,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.email_outlined),
                        border: OutlineInputBorder(),
                        hintText: 'Enter University Email',
                        isDense: true,
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 16),
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
                            Response response =
                                await ForgotPasswordSubmitEmail(_email.text);

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
                            } else {
                              print(response.body);
                              const snackBar = SnackBar(
                                content: Text('invalid email'),
                              );
                            }
                          }
                        }),
                    addVerticalSpace(16),
                    RichText(
                      text: TextSpan(children: [
                        TextSpan(
                            text: 'Return to ',
                            style: Theme.of(context).textTheme.bodyText1),
                        TextSpan(
                            text: 'Sign in',
                            style: Theme.of(context).textTheme.subtitle1,
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
