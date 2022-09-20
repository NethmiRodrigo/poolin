import 'package:flutter/material.dart';
import 'package:mobile/colors.dart';
import 'package:mobile/fonts.dart';
import 'package:mobile/utils/widget_functions.dart';

class SentMessage extends StatelessWidget {
  final String message;

  const SentMessage(this.message, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Align(
      alignment: Alignment.centerRight,
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
                const Text('You', style: BlipFonts.outlineBold),
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
