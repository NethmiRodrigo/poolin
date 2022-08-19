import 'package:flutter/material.dart';
import 'package:poolin/fonts.dart';

class OutlineButton extends StatelessWidget {
  final String text;
  final Color color;
  final Function onPressedAction;
  const OutlineButton({
    Key? key,
    required this.text,
    required this.color,
    required this.onPressedAction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 4, vertical: 2),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            border: Border.all(
              color: color,
            )),
        child: Text((text).toUpperCase(),
            style: BlipFonts.outlineBold.merge(TextStyle(color: color))),
      ),
      onPressed: () {
        onPressedAction();
      },
    );
  }
}
