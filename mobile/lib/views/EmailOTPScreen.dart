import 'package:flutter/material.dart';
import 'package:mobile/views/PhoneNumberScreen.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:mobile/utils/widget_functions.dart';

class EmailOTPScreen extends StatefulWidget {
  const EmailOTPScreen({Key? key}) : super(key: key);

  @override
  _EmailOTPScreenState createState() => _EmailOTPScreenState();
}

class _EmailOTPScreenState extends State<EmailOTPScreen> {
  final _formKey = GlobalKey<FormState>();
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
                addVerticalSpace(48),
                Align(
                  alignment: Alignment.topRight,
                  child: Text(
                    'STEP 2/5',
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                ),
                addVerticalSpace(40),
                const Icon(Icons.lock_outline_rounded, size: 110),
                addVerticalSpace(40),
                Text(
                  "Verify it's you",
                  style: Theme.of(context)
                      .textTheme
                      .headline4!
                      .merge(TextStyle(color: Colors.black)),
                ),
                addVerticalSpace(16),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 80),
                  child: Text(
                    'We sent a one-time code to your email to confirm',
                    style: Theme.of(context).textTheme.bodyText1,
                    textAlign: TextAlign.center,
                  ),
                ),
                addVerticalSpace(48),
                Form(
                  key: _formKey,
                  child: PinCodeTextField(
                    length: 4,
                    obscureText: false,
                    animationType: AnimationType.fade,
                    pinTheme: PinTheme(
                        shape: PinCodeFieldShape.box,
                        borderRadius: BorderRadius.circular(5),
                        fieldHeight: 72,
                        inactiveFillColor: Colors.white,
                        fieldWidth: 72,
                        activeFillColor: Colors.white,
                        activeColor: Colors.black,
                        borderWidth: 1,
                        selectedColor: Colors.blue,
                        selectedFillColor: Colors.white,
                        inactiveColor: Colors.black),
                    animationDuration: const Duration(milliseconds: 300),
                    enableActiveFill: true,
                    validator: (v) {
                      if (v == null || v.isEmpty || v.length < 4) {
                        return 'Invalid code';
                      }
                      ;
                    },
                    controller: textEditingController,
                    onCompleted: (v) {
                      debugPrint("Completed");
                    },
                    onChanged: (value) {
                      debugPrint(value);
                      setState(() {
                        currentText = value;
                      });
                    },
                    beforeTextPaste: (text) {
                      return true;
                    },
                    appContext: context,
                  ),
                ),
                addVerticalSpace(56),
                TextButton(
                  style: TextButton.styleFrom(
                      padding: const EdgeInsets.all(16.0),
                      primary: Colors.white,
                      backgroundColor: Colors.black,
                      minimumSize: const Size.fromHeight(50),
                      textStyle: Theme.of(context).textTheme.bodyText1),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const PhoneNumberScreen()),
                      );
                    }
                  },
                  child: const Text('Verify Email'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


// send response to validator