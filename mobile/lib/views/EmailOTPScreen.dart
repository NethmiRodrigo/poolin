import 'package:flutter/material.dart';
import 'package:mobile/custom/OTPFields.dart';
import 'package:mobile/custom/WideButton.dart';
import 'package:mobile/views/PhoneNumberScreen.dart';
import 'package:mobile/utils/widget_functions.dart';

class EmailOTPScreen extends StatefulWidget {
  const EmailOTPScreen({Key? key}) : super(key: key);

  @override
  _EmailOTPScreenState createState() => _EmailOTPScreenState();
}

class _EmailOTPScreenState extends State<EmailOTPScreen> {
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
                addVerticalSpace(48),
                Align(
                  alignment: Alignment.topRight,
                  child: Text(
                    'STEP 2/5',
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                ),
                addVerticalSpace(40),
                const Icon(Icons.lock_outline_rounded, size: 110),
                addVerticalSpace(40),
                Text(
                  "Verify it's you",
                  style: Theme.of(context)
                      .textTheme
                      .headline4!
                      .merge(TextStyle(color: Colors.black)),
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
                            builder: (context) => const PhoneNumberScreen()),
                      );
                    }
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
