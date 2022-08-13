import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:mobile/custom/wide_button.dart';
import 'package:mobile/fonts.dart';
import 'package:mobile/screens/home/driver_home.dart';
import 'package:mobile/screens/home/rider_home.dart';
import 'package:mobile/utils/widget_functions.dart';

class AcceptRequestConfirmation extends StatelessWidget {
  const AcceptRequestConfirmation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    const double padding = 16;
    const sidePadding = EdgeInsets.symmetric(horizontal: padding);

    return Scaffold(
        body: SizedBox(
            width: size.width,
            height: size.height,
            child: Padding(
                padding: sidePadding,
                child: Column(
                  children: [
                    addVerticalSpace(size.height * 0.05),
                    Align(
                      alignment: Alignment.topLeft,
                      child: IconButton(
                        icon: const Icon(
                          EvaIcons.arrowBackOutline,
                          color: Colors.black,
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                    addVerticalSpace(size.height * 0.12),
                    Image.asset('assets/images/confirmation-tick.png',
                        width: size.width * 0.5),
                    addVerticalSpace(size.height * 0.05),
                    const Text(
                      "Nethmi's request has been accepted!",
                      style: BlipFonts.outlineBold,
                      textAlign: TextAlign.center,
                    ),
                    addVerticalSpace(size.height * 0.1),
                    WideButton(
                      text: 'Back to Home',
                      onPressedAction: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const DriverHomeScreen()),
                        );
                      },
                    )
                  ],
                ))));
  }
}
