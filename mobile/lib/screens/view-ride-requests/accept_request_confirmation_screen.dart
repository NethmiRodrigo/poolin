import 'package:flutter/material.dart';
import 'package:poolin/custom/wide_button.dart';
import 'package:poolin/fonts.dart';
import 'package:poolin/screens/home/driver_home.dart';
import 'package:poolin/utils/widget_functions.dart';

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
              addVerticalSpace(size.height * 0.25),
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
          ),
        ),
      ),
    );
  }
}
