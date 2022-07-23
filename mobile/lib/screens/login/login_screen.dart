// ignore_for_file: unnecessary_null_comparison

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:mobile/custom/wide_button.dart';
import 'package:mobile/screens/forgot-password/forgot_password_screen.dart';
import 'package:mobile/services/login_service.dart';
import 'package:mobile/utils/widget_functions.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:convert';

import '../register/register_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  LoginScreenState createState() {
    return LoginScreenState();
  }
}

class LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _pass = TextEditingController();
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              addVerticalSpace(64),
              Image.asset('assets/images/logo.png', scale: 3),
              Text(
                "Let's sign \nyou back in",
                style: Theme.of(context)
                    .textTheme
                    .headline3!
                    .merge(const TextStyle(color: Colors.black)),
                textAlign: TextAlign.left,
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
                    addVerticalSpace(24),
                    TextFormField(
                      controller: _pass,
                      obscureText: true,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.lock),
                        isDense: true,
                        border: OutlineInputBorder(),
                        hintText: 'Enter a password',
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Password is required';
                        } else if (value.length < 8) {
                          return 'Password length must be atleast 8 characters';
                        }
                        return null;
                      },
                    ),
                    addVerticalSpace(10),
                    Align(
                      alignment: Alignment.topRight,
                      child: RichText(
                        text: TextSpan(
                            text: 'Forgot password?',
                            style: Theme.of(context).textTheme.subtitle1,
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const ForgotPasswordScreen()),
                                );
                              }),
                      ),
                    ),
                    addVerticalSpace(40),
                    WideButton(
                        text: 'Sign in',
                        onPressedAction: () async {
                          if (_formKey.currentState!.validate()) {
                            Response response =
                                await login(_email.text, _pass.text);

                            if (response.statusCode == 200) {
                              var res = json.decode(response.body);
                              await _storage.write(
                                  key: 'TOKEN', value: res["token"]);

                              if (!mounted) {
                                return;
                              }
                            } else {}
                          }
                        }),
                    addVerticalSpace(16),
                    RichText(
                      text: TextSpan(children: [
                        TextSpan(
                            text: 'Not a member? ',
                            style: Theme.of(context).textTheme.bodyText1),
                        TextSpan(
                            text: 'Register now',
                            style: Theme.of(context).textTheme.subtitle1,
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const RegisterScreen()),
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
