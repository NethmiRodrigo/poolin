import 'package:flutter/material.dart';

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
          padding: const EdgeInsets.all(16.0),
          primary: Colors.white,
          backgroundColor: Colors.black,
          minimumSize: const Size.fromHeight(50),
          textStyle: Theme.of(context).textTheme.bodyText1),
      onPressed: () {
        onPressedAction();
      },
      child: Text(text),
    );
  }
}
