import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:poolin/custom/wide_button.dart';
import 'package:poolin/fonts.dart';
import 'package:poolin/screens/login/login_screen.dart';
import 'package:poolin/utils/widget_functions.dart';
import 'package:poolin/screens/forgot-password/verify_email_otp_screen.dart';

import '../../colors.dart';

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
                addVerticalSpace(44),
                const Align(
                    alignment: Alignment.topLeft,
                    child: Icon(
                      EvaIcons.arrowBackOutline,
                      color: Colors.black,
                    )),
                addVerticalSpace(48),
                Image.asset('assets/images/otpsuccess.png', height: 177),
                addVerticalSpace(16),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 48),
                  child: Text(
                    'A verification code was \nsent to your email',
                    style: BlipFonts.label,
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
                RichText(
                  text: TextSpan(children: [
                    const TextSpan(text: 'Return to ', style: BlipFonts.outline),
                    TextSpan(
                        text: 'Sign in',
                        style: BlipFonts.outlineBold
                            .merge(const TextStyle(color: BlipColors.orange)),
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
