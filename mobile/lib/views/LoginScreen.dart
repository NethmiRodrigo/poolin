import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:mobile/utils/widget_functions.dart';
import '../theme.dart';
// import 'package:email_validator/email_validator.dart';

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
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: const MyForm(),
      ),
    );
  }
}

class MyForm extends StatefulWidget {
  const MyForm({super.key});

  @override
  MyFormState createState() {
    return MyFormState();
  }
}

// Create a corresponding State class.
// This class holds data related to the form.
class MyFormState extends State<MyForm> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a GlobalKey<FormState>,
  // not a GlobalKey<MyCustomFormState>.
  final _key = GlobalKey<FormState>();

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
                          // else if (!EmailValidator.validate(value, true)) {
                          //   return 'Please enter valid email';
                          // }

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
                            // print("Your data is submitted");
                            // If the form is valid, display a snackbar. In the real world,
                            // you'd often call a server or save the information in a database.
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Processing Data')),
                            );
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

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    throw UnimplementedError();
  }
}
