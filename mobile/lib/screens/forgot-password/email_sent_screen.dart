import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:mobile/custom/wide_button.dart';
import 'package:mobile/screens/login/login_screen.dart';
import 'package:mobile/utils/widget_functions.dart';
import 'package:mobile/screens/forgot-password/verify_email_otp_screen.dart';

class EmailSentScreen extends StatefulWidget {
  const EmailSentScreen({Key? key}) : super(key: key);

  @override
  EmailSentScreenState createState() => EmailSentScreenState();
}

class EmailSentScreenState extends State<EmailSentScreen> {
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
                addVerticalSpace(216),
                const Icon(Icons.mark_email_read_outlined, size: 110),
                addVerticalSpace(16),
                Text(
                  "All good!",
                  style: Theme.of(context)
                      .textTheme
                      .headline4!
                      .merge(const TextStyle(color: Colors.black)),
                ),
                addVerticalSpace(8),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 48),
                  child: Text(
                    'A verification code was sent to your email',
                    style: Theme.of(context).textTheme.bodyText1,
                    textAlign: TextAlign.center,
                  ),
                ),
                addVerticalSpace(48),
                WideButton(
                    text: 'Proceed',
                    onPressedAction: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const VerifyEmailScreen()),
                      );
                    }),
                addVerticalSpace(16),
                Align(
                  alignment: Alignment.topLeft,
                  child: RichText(
                    text: TextSpan(children: [
                      TextSpan(
                          text: 'Return to ',
                          style: Theme.of(context).textTheme.bodyText1),
                      TextSpan(
                          text: 'Sign in',
                          style: Theme.of(context).textTheme.subtitle1,
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const LoginScreen()),
                              );
                            }),
                    ]),
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
