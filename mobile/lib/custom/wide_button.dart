import 'package:flutter/material.dart';
import 'package:mobile/colors.dart';
import 'package:mobile/fonts.dart';

class WideButton extends StatelessWidget {
  final String text;
  final Function onPressedAction;
  final bool isDisabled;
  const WideButton(
      {Key? key,
      required this.text,
      required this.onPressedAction,
      this.isDisabled = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(30))),
          padding: const EdgeInsets.all(16.0),
          primary: BlipColors.white,
          backgroundColor:
              isDisabled ? BlipColors.black.withOpacity(0.3) : BlipColors.black,
          minimumSize: const Size.fromHeight(50),
          textStyle: BlipFonts.label),
      onPressed: isDisabled
          ? () {}
          : () {
              onPressedAction();
            },
      child: Text(text),
    );
  }
}
