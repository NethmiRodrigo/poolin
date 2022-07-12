import 'package:flutter/material.dart';
import 'package:mobile/custom/OTPFields.dart';
import 'package:mobile/custom/WideButton.dart';
import 'package:mobile/screens/ResetPasswordScreen.dart';
import 'package:mobile/utils/widget_functions.dart';

class VerifyEmailScreen extends StatefulWidget {
  const VerifyEmailScreen({Key? key}) : super(key: key);

  @override
  VerifyEmailScreenState createState() => VerifyEmailScreenState();
}

class VerifyEmailScreenState extends State<VerifyEmailScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController textEditingController = TextEditingController();
  String currentText = "";

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
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                addVerticalSpace(104),
                const Icon(Icons.lock_outline_rounded, size: 110),
                addVerticalSpace(12),
                Text(
                  "Verify it's you",
                  style: Theme.of(context)
                      .textTheme
                      .headline4!
                      .merge(const TextStyle(color: Colors.black)),
                ),
                addVerticalSpace(16),
                Text(
                  'We sent a one-time code \nto your email to confirm',
                  style: Theme.of(context).textTheme.bodyText1,
                  textAlign: TextAlign.center,
                ),
                addVerticalSpace(48),
                Form(
                  key: _formKey,
                  child: OTPFields(
                    controller: textEditingController,
                    context: context,
                    onChangeAction: (value) {
                      debugPrint(value);
                      setState(() {
                        currentText = value;
                      });
                    },
                  ),
                ),
                addVerticalSpace(56),
                WideButton(
                  text: 'Verify Email',
                  onPressedAction: () {
                    if (_formKey.currentState!.validate()) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ResetPasswordScreen()),
                      );
                    }
                  },
                ),
                addVerticalSpace(16),
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Didn't receive a code? Try Again",
                    style: Theme.of(context).textTheme.bodyText1,
                    textAlign: TextAlign.left,
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
