import 'package:flutter/material.dart';
import 'package:mobile/fonts.dart';
import 'package:mobile/utils/widget_functions.dart';

class Indicator extends StatelessWidget {
  final IconData icon;
  final String text;
  final Color color;
  const Indicator(
      {Key? key, required this.icon, required this.text, required this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, color: color, size: 8),
        addHorizontalSpace(4),
        Text(text, style: BlipFonts.taglineBold.merge(TextStyle(color: color))),
      ],
    );
  }
}
