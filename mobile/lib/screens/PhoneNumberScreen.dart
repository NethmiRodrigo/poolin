import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:mobile/custom/WideButton.dart';
import 'package:mobile/screens/PhoneOTPScreen.dart';
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
                addVerticalSpace(48),
                Align(
                  alignment: Alignment.topRight,
                  child: Text(
                    'STEP 3/5',
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                ),
                addVerticalSpace(40),
                const Icon(Icons.phone_android_rounded, size: 110),
                addVerticalSpace(40),
                Text(
                  "Add phone number",
                  style: Theme.of(context)
                      .textTheme
                      .headline4!
                      .merge(const TextStyle(color: Colors.black)),
                ),
                addVerticalSpace(16),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 48),
                  child: Text(
                    'A 4-digit OTP will be sent via SMS to verify your number',
                    style: Theme.of(context).textTheme.bodyText1,
                    textAlign: TextAlign.center,
                  ),
                ),
                addVerticalSpace(48),
                Form(
                  key: _formKey,
                  child: IntlPhoneField(
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
                      isDense: true,
                      border: OutlineInputBorder(),
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                    ),
                    initialCountryCode: 'LK',
                    onChanged: (phone) {
                      currentNumber = phone.completeNumber;
                      print(phone.completeNumber);
                    },
                  ),
                ),
                addVerticalSpace(56),
                WideButton(
                    text: 'Proceed',
                    onPressedAction: () async {
                      if (_formKey.currentState!.validate()) {
                        String? email = await _storage.read(key: 'KEY_EMAIL');
                        Response response =
                            await submitPhoneNumber(currentNumber, email);
                        if (response.statusCode == 200) {
                          if (!mounted) {
                            return;
                          }

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const PhoneOTPScreen()),
                          );
                        } else {
                          print(response.body);
                        }
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
