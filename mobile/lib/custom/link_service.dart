import 'package:flutter/material.dart';

class LinkService extends StatelessWidget {
  final String text;
  final Function onPressedAction;
  const LinkService(
      {Key? key, required this.text, required this.onPressedAction})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
          primary: Colors.black,
          padding: EdgeInsets.zero,
          alignment: Alignment.topLeft,
          textStyle: Theme.of(context).textTheme.bodyText1),
      onPressed: () {
        onPressedAction();
      },
      child: Text(text),
    );
  }
}
