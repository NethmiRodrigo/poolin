import 'package:dio/dio.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:poolin/custom/otp_fields.dart';
import 'package:poolin/custom/wide_button.dart';
import 'package:poolin/screens/forgot-password/reset_password_screen.dart';
import 'package:poolin/utils/widget_functions.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:poolin/services/reset_password_service.dart';

import '../../colors.dart';
import '../../fonts.dart';

class VerifyEmailScreen extends StatefulWidget {
  const VerifyEmailScreen({Key? key}) : super(key: key);

  @override
  VerifyEmailScreenState createState() => VerifyEmailScreenState();
}

class VerifyEmailScreenState extends State<VerifyEmailScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController textEditingController = TextEditingController();
  String currentText = "";
  final _storage = const FlutterSecureStorage();

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
                Align(
                    alignment: Alignment.topLeft,
                    child: Icon(
                      EvaIcons.arrowBackOutline,
                      color: Colors.black,
                    )),
                addVerticalSpace(48),
                Image.asset('assets/images/otp.png', height: 206),
                Text(
                  "Verify it's you",
                  style: BlipFonts.title,
                ),
                addVerticalSpace(16),
                Text(
                  'We sent a one-time code \nto your email to confirm',
                  style: BlipFonts.label,
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
                addVerticalSpace(32),
                WideButton(
                  text: 'Verify Email',
                  onPressedAction: () async {
                    if (_formKey.currentState!.validate()) {
                      String? email = await _storage.read(key: 'KEY_EMAIL');
                      Response response =
                          await checkEmailOTP(currentText, email!);
                      if (response.statusCode == 200) {
                        await _storage.write(key: 'otp', value: currentText);
                        if (!mounted) {
                          return;
                        }

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const ResetPasswordScreen()),
                        );
                      } else {}
                    }
                  },
                ),
                addVerticalSpace(16),
                Align(
                  alignment: Alignment.topLeft,
                  child: RichText(
                    text: TextSpan(children: [
                      TextSpan(
                          text: "Didn't receive a code? ",
                          style: BlipFonts.outline),
                      TextSpan(
                          text: 'Try Again',
                          style: BlipFonts.outlineBold
                              .merge(TextStyle(color: BlipColors.orange)),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () async {
                              String? email =
                                  await _storage.read(key: 'KEY_EMAIL');
                              Response response = await submitEmail(email!);
                              if (response.statusCode == 200) {
                                if (!mounted) {
                                  return;
                                }
                              } else {}
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
