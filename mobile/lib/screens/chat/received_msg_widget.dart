import 'package:flutter/material.dart';
import 'package:poolin/colors.dart';
import 'package:poolin/fonts.dart';
import 'package:poolin/utils/widget_functions.dart';

class ReceivedMessage extends StatelessWidget {
  final String sender;
  final String message;

  const ReceivedMessage(this.sender, this.message, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Align(
      alignment: Alignment.centerLeft,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: size.width * 0.6,
          minWidth: size.width * 0.3,
        ),
        child: Card(
          color: BlipColors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(sender, style: BlipFonts.outlineBold),
                addVerticalSpace(8),
                Text(message, style: BlipFonts.outline),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
