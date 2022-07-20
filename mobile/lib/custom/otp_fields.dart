import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class OTPFields extends StatelessWidget {
  final TextEditingController controller;
  final context;
  final Function onChangeAction;
  const OTPFields(
      {Key? key,
      required this.controller,
      this.context,
      required this.onChangeAction})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PinCodeTextField(
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
        return null;
      },
      controller: controller,
      onCompleted: (v) {
        debugPrint("Completed");
      },
      onChanged: (value) {
        onChangeAction(value);
      },
      beforeTextPaste: (text) {
        return true;
      },
      appContext: context,
    );
  }
}
