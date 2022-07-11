import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:mobile/utils/widget_functions.dart';
import '../theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login Screen',
      theme: AppTheme().themeData,
      home: MyForm(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyForm extends StatelessWidget {
  final _key = GlobalKey<FormState>();
// class LoginScreen extends StatelessWidget {
//   const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    const double padding = 16;
    const sidePadding = EdgeInsets.symmetric(horizontal: padding);
    return SafeArea(
      child: Scaffold(
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
                      .merge(TextStyle(color: Colors.black)),
                  textAlign: TextAlign.left,
                ),
                addVerticalSpace(48),
                Form(
                    key: _key,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextFormField(
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.email_outlined),
                            border: OutlineInputBorder(),
                            hintText: 'Enter University Email',
                            isDense: true,
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 16),
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
                          obscureText: true,
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.lock),
                            isDense: true,
                            border: OutlineInputBorder(),
                            hintText: 'Enter password',
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 16),
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
                          child: Text(
                            'Forgot password?',
                            style: Theme.of(context).textTheme.bodyText1,
                            textAlign: TextAlign.left,
                          ),
                        ),
                        addVerticalSpace(40),
                        TextButton(
                          style: TextButton.styleFrom(
                              padding: const EdgeInsets.all(16.0),
                              primary: Colors.white,
                              backgroundColor: Colors.black,
                              minimumSize: const Size.fromHeight(50),
                              textStyle: Theme.of(context).textTheme.bodyText1),
                          onPressed: () {
                            if (_key.currentState!.validate()) {
                              print("Your data is submitted");
                            }
                          },
                          child: const Text('Sign in'),
                        ),
                        addVerticalSpace(16),
                        Text(
                          'Not a member? Register now',
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
      ),
    );
  }
}
