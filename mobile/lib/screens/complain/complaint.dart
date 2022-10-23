// ignore_for_file: unnecessary_null_comparison

import 'package:dio/dio.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poolin/app.dart';
import 'package:poolin/cubits/auth_cubit.dart';
import 'package:poolin/custom/wide_button.dart';
import 'package:poolin/screens/forgot-password/forgot_password_screen.dart';
import 'package:poolin/services/login_service.dart';
import 'package:poolin/utils/widget_functions.dart';

import '../../colors.dart';
import '../../fonts.dart';

class ComplaintScreen extends StatefulWidget {
  const ComplaintScreen({super.key});

  @override
  ComplaintScreenState createState() {
    return ComplaintScreenState();
  }
}

class ComplaintScreenState extends State<ComplaintScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _complaint = TextEditingController();

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
              const Text(
                "Issue Complaint",
                style: BlipFonts.heading,
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
                      controller: _complaint,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.email_outlined),
                        hintText: 'Tell us what happened',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Field cannot be empty';
                        }

                        return null;
                      },
                    ),
                    addVerticalSpace(24),
                    addVerticalSpace(10),
                    addVerticalSpace(32),
                    WideButton(
                        text: 'File Complaint',
                        onPressedAction: () async {
                          // if (_formKey.currentState!.validate()) {
                          //   Response response =
                          //       await login(_complaint.text);

                          //   if (response.statusCode == 200) {
                          //     if (!mounted) {
                          //       return;
                          //     }
                          //     authState.setLoggedIn(true);
                          //     Navigator.push(
                          //       context,
                          //       MaterialPageRoute(
                          //           builder: (context) => const App()),
                          //     );
                          //   } else {}
                          // }
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
