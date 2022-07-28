import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart';
import 'package:mobile/custom/otp_fields.dart';
import 'package:mobile/custom/wide_button.dart';
import 'package:mobile/fonts.dart';
import 'package:mobile/screens/register/phone_number_screen.dart';
import 'package:mobile/services/register_service.dart';
import 'package:mobile/utils/widget_functions.dart';

class EmailOTPScreen extends StatefulWidget {
  const EmailOTPScreen({Key? key}) : super(key: key);

  @override
  EmailOTPScreenState createState() => EmailOTPScreenState();
}

class EmailOTPScreenState extends State<EmailOTPScreen> {
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
                          if (!mounted) {
                            return;
                          }

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const PhoneNumberScreen()),
                          );
                        } else {}
                      }
                    })
              ],
            ),
          ),
        ),
      ),
    );
  }
}
