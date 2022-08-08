import 'package:eva_icons_flutter/eva_icons_flutter.dart';
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
    return Scaffold(
      body: SizedBox(
        width: size.width,
        height: size.height,
        child: Padding(
          padding: sidePadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
               addVerticalSpace(32),
              Align(
                  alignment: Alignment.topLeft,
                  child: Icon(
                    EvaIcons.arrowBackOutline,
                    color: Colors.black,
                  )),
              addVerticalSpace(24),
              Align(
                alignment: Alignment.topCenter,
                child: Stack(
                  alignment: AlignmentDirectional.topCenter,
                  children: [
                    CircleAvatar(
                      radius: 60.0,
                      backgroundImage: AssetImage('assets/images/user.jpg'),
                    ),
                    Positioned(
                      child: Icon(
                        PhosphorIcons.circleWavyCheckFill,
                        color: BlipColors.orange,
                      ),
                      right: 10.0,
                      bottom: 0.0,
                    ),
                  ],
                ),
              ),
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
