import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:mobile/custom/WideButton.dart';
import 'package:mobile/utils/widget_functions.dart';

class EditPhoneNumberScreen extends StatefulWidget {
  const EditPhoneNumberScreen({Key? key}) : super(key: key);

  @override
  EditPhoneNumberScreenState createState() => EditPhoneNumberScreenState();
}

class EditPhoneNumberScreenState extends State<EditPhoneNumberScreen> {
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
                addVerticalSpace(20),

                Container(
                  width: double.infinity,

                  // padding: EdgeInsets.all(20.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Icon(
                        Icons.close,
                        color: Colors.black,
                      ),
                      addHorizontalSpace(16),
                      Text(
                        'Edit Phone Number',
                        style: Theme.of(context).textTheme.headline3!.merge(
                            const TextStyle(color: Colors.black, fontSize: 24)),
                      ),
                      Spacer(),
                      Icon(
                        Icons.check,
                        color: Colors.black,
                      ),
                    ],
                  ),
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
                IntlPhoneField(
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
                    print(phone.completeNumber);
                  },
                ),
                addVerticalSpace(20),
                WideButton(text: 'Proceed', onPressedAction: () {}),
                // addVerticalSpace(16),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
