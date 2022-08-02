import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart';
import 'package:mobile/custom/wide_button.dart';
import 'package:mobile/fonts.dart';
import 'package:mobile/screens/register/personal_details_screen.dart';
import 'package:mobile/utils/widget_functions.dart';
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
                // addVerticalSpace(16),
                Text("Enter the code", style: BlipFonts.title),
                addVerticalSpace(16),
                Text(
                  'We sent a one-time code \nvia SMS to confirm',
                  style: BlipFonts.label,
                  textAlign: TextAlign.center,
                ),
                addVerticalSpace(32),
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
                        TextSpan(
                            text: "Didn't receive a code? ",
                            style: BlipFonts.outline),
                        TextSpan(
                            text: 'Try again',
                            style: BlipFonts.outlineBold
                                .merge(TextStyle(color: BlipColors.orange)),
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
    );
  }
}
