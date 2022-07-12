// ignore_for_file: unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:mobile/custom/WideButton.dart';
import 'package:mobile/services/register_service.dart';
import 'package:mobile/utils/widget_functions.dart';
import 'package:mobile/screens/EmailOTPScreen.dart';

class ChangePasswordScreenScreen extends StatefulWidget {
  const ChangePasswordScreenScreen({super.key});

  @override
  ChangePasswordScreenScreenState createState() {
    return ChangePasswordScreenScreenState();
  }
}

class ChangePasswordScreenScreenState
    extends State<ChangePasswordScreenScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _email = TextEditingController();
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              addVerticalSpace(20),
              Container(
                // width: double.infinity,
                padding: EdgeInsets.all(20.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Icon(
                      Icons.close,
                      color: Colors.black,
                    ),
                    SizedBox(
                      width: 16,
                    ),
                    Text(
                      'Change Password',
                      style: TextStyle(color: Colors.black87, fontSize: 25),
                    ),
                    Spacer(),
                    Icon(
                      Icons.check,
                      color: Colors.black,
                    ),
                  ],
                ),
              ),
              addVerticalSpace(48),
              // addVerticalSpace(48),
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                      controller: _pass,
                      obscureText: true,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.lock),
                        isDense: true,
                        border: OutlineInputBorder(),
                        hintText: 'Enter current password',
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
                      controller: _pass,
                      obscureText: true,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.lock),
                        isDense: true,
                        border: OutlineInputBorder(),
                        hintText: 'Enter new password',
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
                        hintText: 'Confirm new password',
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
                        text: 'Proceed',
                        onPressedAction: () async {
                          if (_formKey.currentState!.validate()) {
                            Response response = await register(
                                _email.text, _pass.text, _confirmPass.text);
                            if (!mounted) {
                              return;
                            }
                            if (response.statusCode == 200) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const EmailOTPScreen()),
                              );
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                    content: Text('Error: ${response.body}')),
                              );
                            }
                          }
                        }),
                    addVerticalSpace(16),
                    Text(
                      'Already have an account? Log in',
                      style: Theme.of(context).textTheme.bodyText1,
                      textAlign: TextAlign.left,
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
