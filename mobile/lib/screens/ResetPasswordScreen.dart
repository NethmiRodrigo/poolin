// ignore_for_file: unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:mobile/custom/WideButton.dart';
import 'package:mobile/services/register_service.dart';
import 'package:mobile/utils/widget_functions.dart';
import 'package:mobile/screens/ForgotPasswordScreen.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  ResetPasswordScreenState createState() {
    return ResetPasswordScreenState();
  }
}

class ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _pass = TextEditingController();
  final TextEditingController _confirmPass = TextEditingController();

  @override
  void dispose() {
    _pass.dispose();
    _confirmPass.dispose();
    super.dispose();
  }

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
              addVerticalSpace(184),
              Text(
                "Create a password",
                style: Theme.of(context)
                    .textTheme
                    .headline4!
                    .merge(const TextStyle(color: Colors.black)),
              ),
              addVerticalSpace(16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 48),
                child: Text(
                  'Your new password should be different from your last one',
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
                    addVerticalSpace(24),
                    TextFormField(
                      controller: _confirmPass,
                      obscureText: true,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.lock),
                        isDense: true,
                        border: OutlineInputBorder(),
                        hintText: 'Confirm password',
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                      ),
                      validator: (value) {
                        if ((value == null || value.isEmpty) &&
                            !(_pass.text == null || _pass.text.isEmpty)) {
                          return 'Please re-enter your password';
                        } else if (value != _pass.text) {
                          return 'Passwords do not match';
                        }

                        return null;
                      },
                    ),
                    addVerticalSpace(40),
                    WideButton(
                        text: 'Reset password',
                        onPressedAction: () async {
                          if (_formKey.currentState!.validate()) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const ForgotPasswordScreen()),
                            );
                          }
                        }),
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
