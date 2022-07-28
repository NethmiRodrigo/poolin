import 'package:flutter/material.dart';
import 'package:mobile/fonts.dart';

class WideButton extends StatelessWidget {
  final String text;
  final Function onPressedAction;
  const WideButton(
      {Key? key, required this.text, required this.onPressedAction})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(30))),
          padding: const EdgeInsets.all(16.0),
          primary: Colors.white,
          backgroundColor: Colors.black,
          minimumSize: const Size.fromHeight(50),
          textStyle: BlipFonts.label),
      onPressed: () {
        onPressedAction();
      },
      child: Text(text),
    );
  }
}
