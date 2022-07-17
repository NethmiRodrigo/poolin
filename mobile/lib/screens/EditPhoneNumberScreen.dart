import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:mobile/custom/WideButton.dart';
import 'package:mobile/screens/EditPhoneNumberOTPScreen.dart';
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
          child: GestureDetector(
            // padding: sidePadding,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                addVerticalSpace(48),

                Container(
                  // width: double.infinity,
                  // padding: sidePadding,

                  // padding: EdgeInsets.all(20.0),
                  child: Row(
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
                      addHorizontalSpace(44),
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
                Container(
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
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                  ),
                  initialCountryCode: 'LK',
                  onChanged: (phone) {
                    print(phone.completeNumber);
                  },
                ),
                addVerticalSpace(20),
                WideButton(
                    text: 'Proceed',
                    onPressedAction: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                const EditPhoneNumberOTPScreen()),
                      );
                    }),
                ]),
                    ),),
                
                
                // addVerticalSpace(16),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
