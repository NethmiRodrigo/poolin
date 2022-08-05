import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';

class BackwardButton extends StatelessWidget {
  const BackwardButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
        alignment: Alignment.topLeft,
        child: IconButton(
          icon: const Icon(EvaIcons.arrowBackOutline),
          color: Colors.black,
          onPressed: () {
            Navigator.pop(context);
          },
        ));
  }
}
