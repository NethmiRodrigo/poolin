import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:mobile/custom/backward_button.dart';
import 'package:mobile/custom/timeline.dart';
import 'package:mobile/custom/wide_button.dart';
import 'package:mobile/fonts.dart';
import 'package:mobile/screens/chat/group_chat.dart';
import 'package:mobile/utils/widget_functions.dart';

import '../../../colors.dart';

class RideDetailsScreen extends StatefulWidget {
  const RideDetailsScreen({super.key});

  @override
  RideDetailsScreenState createState() {
    return RideDetailsScreenState();
  }
}

class RideDetailsScreenState extends State<RideDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    const double padding = 16;
    const sidePadding = EdgeInsets.symmetric(horizontal: padding);
    
    // Build a Form widget using the _formKey created above.
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: const BackwardButton(),
      ),
      body: SizedBox(
        width: size.width,
        height: size.height,
        child: Padding(
          padding: sidePadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "You're going to \nColombo!",
                style: BlipFonts.display,
              ),
              addVerticalSpace(16),
              const Text(
                "Your Trip",
                style: BlipFonts.heading,
              ),
              Row(
                children: [
                  const Text(
                    "Monday, 23rd June",
                    style: BlipFonts.label,
                  ),
                  const Spacer(),
                  TextButton(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 4, vertical: 6),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: BlipColors.orange,
                      ),
                      child: Text(("7:30AM").toUpperCase(),
                          style: BlipFonts.outlineBold
                              .merge(const TextStyle(color: BlipColors.white))),
                    ),
                    onPressed: () {},
                  )
                ],
              ),
              SizedBox(
                  height: 200,
                  child: Scrollbar(
                    thumbVisibility: true,
                    child: ListView(
                      scrollDirection: Axis.vertical,
                      children: [
                        Timeline(
                          indicators: const <Widget>[
                            Icon(
                              Icons.circle,
                              color: BlipColors.orange,
                              size: 12,
                            ),
                            Icon(
                              Icons.circle,
                              color: BlipColors.black,
                              size: 12,
                            ),
                            Icon(
                              Icons.circle,
                              color: BlipColors.black,
                              size: 12,
                            ),
                            Icon(
                              Icons.circle,
                              color: BlipColors.orange,
                              size: 12,
                            ),
                          ],
                          children: <Widget>[
                            SizedBox(
                              height: 60,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Row(
                                    children: const [
                                      Text('No.20, Borelasgamuwa',
                                          style: BlipFonts.labelBold),
                                      Spacer(),
                                      Text('7:30 AM', style: BlipFonts.outline),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 60,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Text('No.20, Borelasgamuwa',
                                              style: BlipFonts.label),
                                          const Text('Pick up Sarah',
                                              style: BlipFonts.outline),
                                          addVerticalSpace(4),
                                        ],
                                      ),
                                      const Spacer(),
                                      const Text('7:30 AM',
                                          style: BlipFonts.outline),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 60,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Text('No.20, Thunmulla',
                                              style: BlipFonts.label),
                                          const Text('Drop off Sarah',
                                              style: BlipFonts.outline),
                                          addVerticalSpace(4),
                                        ],
                                      ),
                                      const Spacer(),
                                      const Text('7:30 AM',
                                          style: BlipFonts.outline),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 60,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: const [
                                      Text(
                                          'University of Colombo\nSchool of Computing',
                                          style: BlipFonts.labelBold),
                                      Spacer(),
                                      Text('7:30 AM', style: BlipFonts.outline),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  )),
              addVerticalSpace(32),
              Row(
                children: [
                  const Text(
                    "The Party",
                    style: BlipFonts.heading,
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const GroupChat()),
                      );
                    },
                    child: const CircleAvatar(
                        radius: 16.0,
                        backgroundColor: BlipColors.black,
                        child: Icon(
                          EvaIcons.messageSquareOutline,
                          color: BlipColors.white,
                          size: 14.0,
                        )),
                  ),
                ],
              ),
              addVerticalSpace(16),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    children: const [
                      CircleAvatar(
                        radius: 40.0,
                        backgroundImage: AssetImage('assets/images/user.jpg'),
                      ),
                      Text(
                        "John",
                        style: BlipFonts.outline,
                      ),
                      Text(
                        "Driver",
                        style: BlipFonts.taglineBold,
                      ),
                    ],
                  ),
                  addHorizontalSpace(20),
                  addVerticalSpace(24),
                  SizedBox(
                    height: 100,
                    width: 220,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      // itemExtent: 70.0,
                      shrinkWrap: true,
                      children: <Widget>[
                        Column(
                          children: const [
                            CircleAvatar(
                              radius: 30.0,
                              backgroundImage:
                                  AssetImage('assets/images/user.jpg'),
                            ),
                            Text(
                              "John",
                              style: BlipFonts.outline,
                            ),
                          ],
                        ),
                        addHorizontalSpace(16),
                        Column(
                          children: const [
                            CircleAvatar(
                              radius: 30.0,
                              backgroundImage:
                                  AssetImage('assets/images/user.jpg'),
                            ),
                            Text(
                              "John",
                              style: BlipFonts.outline,
                            ),
                          ],
                        ),
                        addHorizontalSpace(16),
                        Column(
                          children: const [
                            CircleAvatar(
                              radius: 30.0,
                              backgroundImage:
                                  AssetImage('assets/images/user.jpg'),
                            ),
                            Text(
                              "John",
                              style: BlipFonts.outline,
                            ),
                          ],
                        ),
                        addHorizontalSpace(16),
                        Column(
                          children: const [
                            CircleAvatar(
                              radius: 30.0,
                              backgroundImage:
                                  AssetImage('assets/images/user.jpg'),
                            ),
                            Text(
                              "John",
                              style: BlipFonts.outline,
                            ),
                          ],
                        ),
                        addHorizontalSpace(16),
                        Column(
                          children: const [
                            CircleAvatar(
                              radius: 30.0,
                              backgroundImage:
                                  AssetImage('assets/images/user.jpg'),
                            ),
                            Text(
                              "John",
                              style: BlipFonts.outline,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              addVerticalSpace(24),
              WideButton(text: 'Cancel Ride', onPressedAction: () async {}),
            ],
          ),
        ),
      ),
    );
  }
}
