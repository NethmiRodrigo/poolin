import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart';
import 'package:mobile/custom/WideButton.dart';
import 'package:mobile/screens/LoginScreen.dart';
import 'package:mobile/services/register_service.dart';
import 'package:mobile/utils/widget_functions.dart';
import 'package:mobile/screens/EmailOTPScreen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  RegisterScreenState createState() {
    return RegisterScreenState();
  }
}

class RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _pass = TextEditingController();
  final TextEditingController _confirmPass = TextEditingController();
  final _storage = const FlutterSecureStorage();

  @override
  void dispose() {
    _email.dispose();
    _pass.dispose();
    _confirmPass.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    const double padding = 16;
    const sidePadding = EdgeInsets.symmetric(horizontal: padding);

    return Scaffold(
      body: SizedBox(
        width: size.width,
        height: size.height,
        child: Padding(
          padding: sidePadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              addVerticalSpace(48),
              Align(
                alignment: Alignment.topRight,
                child: Text(
                  'STEP 1/5',
                  style: Theme.of(context).textTheme.subtitle1,
                ),
              ),
              Image.asset('assets/images/logo.png', scale: 3),
              Text(
                'Create your account',
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
                      key: const Key('email-field'),
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
                        if (!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                .hasMatch(value) ||
                            !(value.endsWith("cmb.ac.lk"))) {
                          return 'Invalid email format';
                        }

                        return null;
                      },
                    ),
                    addVerticalSpace(24),
                    TextFormField(
                      key: const Key('password-field'),
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
                      key: const Key('confirm-password-field'),
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
                        text: 'Proceed',
                        onPressedAction: () async {
                          if (_formKey.currentState!.validate()) {
                            Response response = await register(
                                _email.text, _pass.text, _confirmPass.text);

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
                                        const EmailOTPScreen()),
                              );
                            } else {}
                          }
                        }),
                    addVerticalSpace(16),
                    RichText(
                      text: TextSpan(children: [
                        TextSpan(
                            text: 'Already have an account? ',
                            style: Theme.of(context).textTheme.bodyText1),
                        TextSpan(
                            text: 'Login',
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
