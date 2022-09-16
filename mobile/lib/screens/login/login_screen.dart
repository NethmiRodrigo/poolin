// ignore_for_file: unnecessary_null_comparison

import 'package:dio/dio.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/app.dart';
import 'package:mobile/cubits/auth_cubit.dart';
import 'package:mobile/custom/wide_button.dart';
import 'package:mobile/screens/forgot-password/forgot_password_screen.dart';
import 'package:mobile/services/login_service.dart';
import 'package:mobile/utils/widget_functions.dart';

import '../../colors.dart';
import '../../fonts.dart';
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

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    const double padding = 16;
    const sidePadding = EdgeInsets.symmetric(horizontal: padding);
    AuthStateCubit authState = BlocProvider.of<AuthStateCubit>(context);
    // Build a Form widget using the _formKey created above.
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
              Image.asset('assets/images/logo.png', height: 24),
              const Text(
                "Let's sign \nyou back in",
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
                    addVerticalSpace(24),
                    TextFormField(
                      style: Theme.of(context).textTheme.labelLarge,
                      controller: _pass,
                      obscureText: true,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.lock),
                        hintText: 'Enter password',
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
                            style: BlipFonts.outlineBold.merge(
                              const TextStyle(color: BlipColors.orange),
                            ),
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
                    addVerticalSpace(32),
                    WideButton(
                        text: 'Sign in',
                        onPressedAction: () async {
                          if (_formKey.currentState!.validate()) {
                            Response response =
                                await login(_email.text, _pass.text);

                            if (response.statusCode == 200) {
                              if (!mounted) {
                                return;
                              }
                              authState.setLoggedIn(true);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const App()),
                              );
                            } else {}
                          }
                        }),
                    addVerticalSpace(16),
                    Center(
                      child: RichText(
                        text: TextSpan(children: [
                          TextSpan(
                            text: 'Not a member? ',
                            style: BlipFonts.outline.merge(
                                const TextStyle(color: BlipColors.black)),
                          ),
                          TextSpan(
                              text: 'Sign Up',
                              style: BlipFonts.outlineBold.merge(
                                const TextStyle(color: BlipColors.orange),
                              ),
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
