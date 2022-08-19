import 'package:dio/dio.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:poolin/custom/wide_button.dart';
import 'package:poolin/fonts.dart';
import 'package:poolin/screens/register/personal_details_screen.dart';
import 'package:poolin/screens/register/phone_number_screen.dart';
import 'package:poolin/utils/widget_functions.dart';
import '../../colors.dart';
import '../../custom/otp_fields.dart';
import '../../services/register_service.dart';

class PhoneOTPScreen extends StatefulWidget {
  const PhoneOTPScreen({Key? key}) : super(key: key);

  @override
  PhoneOTPScreenState createState() => PhoneOTPScreenState();
}

class PhoneOTPScreenState extends State<PhoneOTPScreen> {
  TextEditingController textEditingController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String currentText = "";
  final _storage = const FlutterSecureStorage();

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    const double padding = 16;
    const sidePadding = EdgeInsets.symmetric(horizontal: padding);
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: SizedBox(
            width: size.width,
            height: size.height,
            child: Padding(
              padding: sidePadding,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  addVerticalSpace(size.height * 0.02),
                  Align(
                      alignment: Alignment.topLeft,
                      child: IconButton(
                        icon: const Icon(
                          EvaIcons.arrowBackOutline,
                          color: Colors.black,
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const PhoneNumberScreen()),
                          );
                        },
                      )),
                  addVerticalSpace(size.height * 0.02),
                  Image.asset('assets/images/otp.png', height: 206),
                  // addVerticalSpace(16),
                  const Text("Enter the code", style: BlipFonts.title),
                  addVerticalSpace(16),
                  const Text(
                    'We sent a one-time code \nvia SMS to confirm',
                    style: BlipFonts.label,
                    textAlign: TextAlign.center,
                  ),
                  addVerticalSpace(size.height * 0.06),
                  Form(
                    key: _formKey,
                    child: OTPFields(
                      controller: textEditingController,
                      context: context,
                      onChangeAction: (value) {
                        setState(() {
                          currentText = value;
                        });
                      },
                    ),
                  ),
                  addVerticalSpace(size.height * 0.05),
                  WideButton(
                    text: 'Verify Phone Number',
                    onPressedAction: () async {
                      if (_formKey.currentState!.validate()) {
                        String? email = await _storage.read(key: 'KEY_EMAIL');
                        String? mobile = await _storage.read(key: 'KEY_MOBILE');
                        Response response =
                            await checkSMSOTP(currentText, mobile!, email!);
                        if (response.statusCode == 200) {
                          if (!mounted) {
                            return;
                          }

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const PersonalDetailsScreen()),
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
                          const TextSpan(
                              text: "Didn't receive a code? ",
                              style: BlipFonts.outline),
                          TextSpan(
                              text: 'Try again',
                              style: BlipFonts.outlineBold.merge(
                                  const TextStyle(color: BlipColors.orange)),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Navigator.pop(context);
                                }),
                        ]),
                      )),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
