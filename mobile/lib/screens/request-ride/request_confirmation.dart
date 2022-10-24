import 'package:flutter/material.dart';
import 'package:poolin/custom/wide_button.dart';
import 'package:poolin/fonts.dart';
import 'package:poolin/screens/home/rider_home.dart';
import 'package:poolin/utils/widget_functions.dart';

class RequestConfirmation extends StatelessWidget {
  const RequestConfirmation({Key? key}) : super(key: key);

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
                    addVerticalSpace(size.height * 0.2),
                    Image.asset('assets/images/confirmation-tick.png',
                        width: size.width * 0.5),
                    addVerticalSpace(size.height * 0.05),
                    const Text(
                      'Your request has been posted!\n We will let you know when once someone\n accepts your request',
                      style: BlipFonts.outlineBold,
                      textAlign: TextAlign.center,
                    ),
                    addVerticalSpace(size.height * 0.1),
                    WideButton(
                      text: 'Back to home',
                      onPressedAction: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const RiderHomeScreen()),
                        );
                      },
                    )
                  ],
                ))));
  }
}
