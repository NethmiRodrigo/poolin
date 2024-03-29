import 'package:dio/dio.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
// import 'package:http/http.dart';
import 'package:poolin/colors.dart';
import 'package:poolin/custom/wide_button.dart';
import 'package:poolin/fonts.dart';
import 'package:poolin/screens/login/login_screen.dart';
import 'package:poolin/services/register_service.dart';
import 'package:poolin/utils/widget_functions.dart';
import 'package:poolin/screens/register/email_otp_screen.dart';

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
      resizeToAvoidBottomInset: false,
      body: SizedBox(
        width: size.width,
        height: size.height,
        child: Padding(
          padding: sidePadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              addVerticalSpace(44),
              const Align(
                  alignment: Alignment.topLeft,
                  child: Icon(
                    EvaIcons.arrowBackOutline,
                    color: Colors.black,
                  )),
              addVerticalSpace(48),
              Image.asset('assets/images/logo.png', height: 24),
              const Text(
                'Sign up and \nstart pooling',
                style: BlipFonts.display,
                textAlign: TextAlign.left,
              ),
              addVerticalSpace(48),
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                      style: Theme.of(context).textTheme.labelLarge,
                      textAlignVertical: TextAlignVertical.center,
                      key: const Key('email-field'),
                      controller: _email,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.email_outlined),
                        hintText: 'Enter University Email',
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
                      style: Theme.of(context).textTheme.labelLarge,
                      textAlignVertical: TextAlignVertical.center,
                      key: const Key('password-field'),
                      controller: _pass,
                      obscureText: true,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.lock),
                        hintText: 'Enter a password',
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
                      style: Theme.of(context).textTheme.labelLarge,
                      textAlignVertical: TextAlignVertical.center,
                      key: const Key('confirm-password-field'),
                      controller: _confirmPass,
                      obscureText: true,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.lock),
                        hintText: 'Confirm password',
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
                            await register(
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
                    Align(
                      alignment: Alignment.center,
                      child: RichText(
                        text: TextSpan(children: [
                          TextSpan(
                              text: 'Already have an account? ',
                              style: BlipFonts.outline.merge(
                                  const TextStyle(color: BlipColors.black))),
                          TextSpan(
                              text: 'Login',
                              style: BlipFonts.outlineBold.merge(
                                const TextStyle(color: BlipColors.orange),
                              ),
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
