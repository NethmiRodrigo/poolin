import 'package:flutter/material.dart';
import 'package:mobile/custom/wide_button.dart';
import 'package:mobile/fonts.dart';
import 'package:mobile/utils/widget_functions.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';


import '../../../colors.dart';

class RiderProfileScreen extends StatefulWidget {
  const RiderProfileScreen({super.key});

  @override
  RiderProfileScreenState createState() {
    return RiderProfileScreenState();
  }
}

class RiderProfileScreenState extends State<RiderProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    const double padding = 16;
    const sidePadding = EdgeInsets.symmetric(horizontal: padding);
    // Build a Form widget using the _formKey created above.
    return Scaffold(
      body: SizedBox(
        width: size.width,
        height: size.height,
        child: Padding(
          padding: sidePadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              addVerticalSpace(64),
              const Align(
                  alignment: Alignment.topCenter,
                  child: SizedBox(
                    child: CircleAvatar(
                      radius: 60.0,
                      backgroundImage: AssetImage('assets/images/user.png'),
                      child: Align(
                        alignment: Alignment.bottomRight,
                        child: CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: 12.0,
                          child: Icon(
                            PhosphorIcons.circleWavyCheckFill,
                            color: BlipColors.orange,
                          ),
                        ),
                      ),
                    ),
                  )),
              Align(
                alignment: Alignment.topCenter,
                child: Column(
                  children: [
                    Text(
                      "Yadeesha",
                      style: BlipFonts.title,
                    ),
                    Text(
                      "Student",
                      style: BlipFonts.label,
                    ),
                  ],
                ),
              ),
              addVerticalSpace(40),
              Text(
                "About",
                style: BlipFonts.title,
              ),
              addVerticalSpace(16),
              Text(
                "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat",
                style: BlipFonts.outline,
              ),
              addVerticalSpace(32),
              Row(
                children: [
                  Text(
                    "Mutual friends",
                    style: BlipFonts.title,
                  ),
                  Text(
                    "  (20)",
                    style: BlipFonts.label,
                  ),
                  Spacer(),
                  const Icon(
                    Icons.arrow_forward_ios_outlined,
                    size: 15,
                  ),
                ],
              ),
              addVerticalSpace(16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      CircleAvatar(
                        radius: 30.0,
                        backgroundImage: AssetImage('assets/images/user.jpg'),
                      ),
                      Text(
                        "John",
                        style: BlipFonts.outline,
                      ),
                    ],
                  ),
                  // addHorizontalSpace(20),
                  Column(
                    children: [
                      CircleAvatar(
                        radius: 30.0,
                        backgroundImage: AssetImage('assets/images/user.jpg'),
                      ),
                      Text(
                        "John",
                        style: BlipFonts.outline,
                      ),
                    ],
                  ),
                  // addHorizontalSpace(20),
                  Column(
                    children: [
                      CircleAvatar(
                        radius: 30.0,
                        backgroundImage: AssetImage('assets/images/user.jpg'),
                      ),
                      Text(
                        "John",
                        style: BlipFonts.outline,
                      ),
                    ],
                  ),
                  // addHorizontalSpace(20),
                  Column(
                    children: [
                      CircleAvatar(
                        radius: 30.0,
                        backgroundImage: AssetImage('assets/images/user.jpg'),
                      ),
                      Text(
                        "John",
                        style: BlipFonts.outline,
                      ),
                    ],
                  ),
                ],
              ),
              addVerticalSpace(32),
              WideButton(
                  text: 'Send friend request',
                  onPressedAction: () async {
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
