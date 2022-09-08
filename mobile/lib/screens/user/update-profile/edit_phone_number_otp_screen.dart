import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart';
import 'package:poolin/custom/otp_fields.dart';
import 'package:poolin/custom/wide_button.dart';
import 'package:poolin/screens/user/update-profile/edit_profile_screen.dart';
import 'package:poolin/services/update_profile_service.dart';
import 'package:poolin/utils/widget_functions.dart';

class EditPhoneNumberOTPScreen extends StatefulWidget {
  const EditPhoneNumberOTPScreen({Key? key}) : super(key: key);

  @override
  EditPhoneNumberOTPScreenState createState() =>
      EditPhoneNumberOTPScreenState();
}

class EditPhoneNumberOTPScreenState extends State<EditPhoneNumberOTPScreen> {
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
                      String? token = await _storage.read(key: 'TOKEN');
                      Response response =
                          await editcheckSMSOTP(currentText, token!);
                      if (response.statusCode == 200) {
                        if (!mounted) {
                          return;
                        }

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const EditProfileScreen()),
                        );
                      } else {}
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
