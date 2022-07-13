import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart';
import 'package:mobile/custom/WideButton.dart';
import 'package:mobile/screens/PersonalDetailsScreen.dart';
import 'package:mobile/utils/widget_functions.dart';
import '../custom/OTPFields.dart';
import '../services/register_service.dart';

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
                addVerticalSpace(48),
                Align(
                  alignment: Alignment.topRight,
                  child: Text(
                    'STEP 4/5',
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                ),
                addVerticalSpace(40),
                const Icon(Icons.lock_outline_rounded, size: 110),
                addVerticalSpace(40),
                Text(
                  "Enter the code",
                  style: Theme.of(context)
                      .textTheme
                      .headline4!
                      .merge(const TextStyle(color: Colors.black)),
                ),
                addVerticalSpace(16),
                Text(
                  'We sent a one-time code via \nSMS to confirm',
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
                  text: 'Verify Phone Number',
                  onPressedAction: () async {
                    if (_formKey.currentState!.validate()) {
                      String? email = await _storage.read(key: 'KEY_EMAIL');
                      Response response =
                          await checkEmailOTP(currentText, email);
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
                      } else {
                        print(response.body);
                      }
                    }
                  },
                ),
                addVerticalSpace(16),
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Didn’t receive a code? Try Again',
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
