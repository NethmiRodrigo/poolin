import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:mobile/custom/wide_button.dart';
import 'package:mobile/fonts.dart';
import 'package:mobile/screens/register/phone_otp_screen.dart';
import 'package:mobile/services/register_service.dart';
import 'package:mobile/utils/widget_functions.dart';

class PhoneNumberScreen extends StatefulWidget {
  const PhoneNumberScreen({Key? key}) : super(key: key);

  @override
  PhoneNumberScreenState createState() => PhoneNumberScreenState();
}

class PhoneNumberScreenState extends State<PhoneNumberScreen> {
  TextEditingController textEditingController = TextEditingController();
  String currentNumber = "";
  final _storage = const FlutterSecureStorage();
  final _formKey = GlobalKey<FormState>();

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
                Image.asset('assets/images/phone.png', height: 177),
                addVerticalSpace(16),
                Text("Add phone number", style: BlipFonts.title),
                addVerticalSpace(16),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 48),
                  child: Text(
                    'A 4-digit OTP will be sent via SMS to verify your number',
                    style: BlipFonts.label,
                    textAlign: TextAlign.center,
                  ),
                ),
                addVerticalSpace(48),
                Form(
                  key: _formKey,
                  child: IntlPhoneField(
                    style: Theme.of(context).textTheme.labelLarge,
                    validator: (v) {
                      if (v == null) {
                        return 'Please enter a phone number';
                      }
                      return null;
                    },
                    flagsButtonPadding: const EdgeInsets.only(left: 16),
                    showDropdownIcon: false,
                    decoration: const InputDecoration(
                      hintText: 'Phone Number',
                    ),
                    initialCountryCode: 'LK',
                    onChanged: (phone) {
                      currentNumber = phone.completeNumber;
                    },
                  ),
                ),
                addVerticalSpace(40),
                WideButton(
                    text: 'Proceed',
                    onPressedAction: () async {
                      if (_formKey.currentState!.validate()) {
                        String? email = await _storage.read(key: 'KEY_EMAIL');
                        Response response =
                            await submitPhoneNumber(currentNumber, email!);
                        if (response.statusCode == 200) {
                          await _storage.write(
                              key: 'KEY_MOBILE', value: currentNumber);
                          if (!mounted) {
                            return;
                          }

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const PhoneOTPScreen()),
                          );
                        } else {}
                      }
                    }),
                addVerticalSpace(16),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
