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
      title: 'Register Screen',
      theme: AppTheme().themeData,
      home: const RegisterScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key}) : super(key: key);

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
                      .merge(TextStyle(color: Colors.black)),
                  textAlign: TextAlign.left,
                ),
                addVerticalSpace(48),
                const TextField(
                    decoration: InputDecoration(
                  prefixIcon: Icon(Icons.email_outlined),
                  border: OutlineInputBorder(),
                  hintText: 'Enter University Email',
                  isDense: true,
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                )),
                addVerticalSpace(24),
                const TextField(
                  obscureText: true,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.lock),
                    isDense: true,
                    border: OutlineInputBorder(),
                    hintText: 'Enter a password',
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                  ),
                ),
                addVerticalSpace(24),
                const TextField(
                  obscureText: true,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.lock),
                    isDense: true,
                    border: OutlineInputBorder(),
                    hintText: 'Confirm password',
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 10, horizontal: 16),
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
                  onPressed: () {},
                  child: const Text('Proceed'),
                ),
                addVerticalSpace(16),
                Text(
                  'Already have an account? Log in',
                  style: Theme.of(context).textTheme.bodyText1,
                  textAlign: TextAlign.left,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
