import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:mobile/custom/wide_button.dart';
import 'package:mobile/screens/user/update-profile/edit_phone_number_otp_screen.dart';
import 'package:mobile/services/update_profile_service.dart';
import 'package:mobile/utils/widget_functions.dart';

class EditPhoneNumberScreen extends StatefulWidget {
  const EditPhoneNumberScreen({Key? key}) : super(key: key);

  @override
  EditPhoneNumberScreenState createState() => EditPhoneNumberScreenState();
}

class EditPhoneNumberScreenState extends State<EditPhoneNumberScreen> {
  TextEditingController textEditingController = TextEditingController();
  final TextEditingController _mobile = TextEditingController();
  String currentNumber = "";
  final _storage = const FlutterSecureStorage();
  final _formKey = GlobalKey<FormState>();
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
          child: GestureDetector(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                addVerticalSpace(48),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    addHorizontalSpace(8),
                    IconButton(
                      icon: const Icon(
                        Icons.close,
                        color: Colors.black,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    addHorizontalSpace(8),
                    Text(
                      'Edit Phone Number',
                      style: Theme.of(context).textTheme.headline3!.merge(
                          const TextStyle(color: Colors.black, fontSize: 24)),
                    ),
                  ],
                ),
                addVerticalSpace(20),
                addVerticalSpace(20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 48),
                  child: Text(
                    'A 4-digit OTP will be sent via SMS to verify your number',
                    style: Theme.of(context).textTheme.bodyText1,
                    textAlign: TextAlign.center,
                  ),
                ),
                addVerticalSpace(40),
                Form(
                  key: _formKey,
                  child: Padding(
                    padding: sidePadding,
                    child: Column(children: [
                      IntlPhoneField(
                        flagsButtonPadding: const EdgeInsets.only(left: 16),
                        showDropdownIcon: false,
                        decoration: const InputDecoration(
                          hintText: 'Phone Number',
                          isDense: true,
                          border: OutlineInputBorder(),
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 16),
                        ),
                        initialCountryCode: 'LK',
                        onChanged: (phone) {},
                      ),
                      addVerticalSpace(20),
                      WideButton(
                          text: 'Proceed',
                          onPressedAction: () async {
                            if (_formKey.currentState!.validate()) {
                              Map data = {'mobile': _mobile};
                              String? token = await _storage.read(key: 'TOKEN');
                              Response response =
                                  await updateprofile(data, token!);
                              if (response.statusCode == 200) {
                                if (!mounted) {
                                  return;
                                }

                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const EditPhoneNumberOTPScreen()),
                                );
                              } else {}
                            }
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
