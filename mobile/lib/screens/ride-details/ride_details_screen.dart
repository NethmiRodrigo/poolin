import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
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
      body: SizedBox(
        width: size.width,
        height: size.height,
        child: Padding(
          padding: sidePadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              addVerticalSpace(24),
              Align(
                alignment: Alignment.topLeft,
                child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Icon(
                    EvaIcons.arrowBackOutline,
                    color: Colors.black,
                  ),
                ),
              ),
              addVerticalSpace(16),
              Text(
                "You're going to \n Town Hall!",
                style: BlipFonts.display,
              ),
              addVerticalSpace(16),
              Text(
                "Your Trip",
                style: BlipFonts.heading,
              ),
              Row(
                children: [
                  Text(
                    "Sunday, 14th August",
                    style: BlipFonts.label,
                  ),
                  Spacer(),
                  TextButton(
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 4, vertical: 6),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: BlipColors.orange,
                      ),
                      child: Text(("12:28AM").toUpperCase(),
                          style: BlipFonts.outlineBold
                              .merge(TextStyle(color: BlipColors.white))),
                    ),
                    onPressed: () {},
                  )
                ],
              ),
              addVerticalSpace(12),
              Container(
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
                            Container(
                              height: 60,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Row(
                                    children: const [
                                      Flexible(
                                        child: Text(
                                          'University of Colombo, School of Computing',
                                          style: BlipFonts.labelBold,
                                          overflow: TextOverflow.clip,
                                        ),
                                      ),
                                      Spacer(),
                                      Text('12:28 PM',
                                          style: BlipFonts.outline),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Container(
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
                                          Text('Lionel Wendt Art Theatre',
                                              style: BlipFonts.label),
                                          Text('Pick up Nethmi',
                                              style: BlipFonts.outline),
                                          addVerticalSpace(4),
                                        ],
                                      ),
                                      Spacer(),
                                      Text('12:40 PM',
                                          style: BlipFonts.outline),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Container(
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
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Text('Cinnamon Red',
                                              style: BlipFonts.label),
                                          Text('Drop off Nethmi',
                                              style: BlipFonts.outline),
                                          addVerticalSpace(4),
                                        ],
                                      ),
                                      Spacer(),
                                      Text('12:50 PM',
                                          style: BlipFonts.outline),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Container(
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
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Text('Town Hall',
                                              style: BlipFonts.label),
                                          Text('End of Journey',
                                              style: BlipFonts.outline),
                                          addVerticalSpace(4),
                                        ],
                                      ),
                                      Spacer(),
                                      Text('1:00 PM', style: BlipFonts.outline),
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
                  Text(
                    "The Party",
                    style: BlipFonts.heading,
                  ),
                  Spacer(),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const GroupChat()),
                      );
                    },
                    child: CircleAvatar(
                      radius: 16.0,
                      backgroundColor: BlipColors.black,
                      child: Icon(
                        EvaIcons.messageSquareOutline,
                        color: BlipColors.white,
                        size: 14.0,
                      ),
                    ),
                  ),
                ],
              ),
              addVerticalSpace(16),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      CircleAvatar(
                        radius: 40.0,
                        backgroundImage: AssetImage('assets/images/user.jpg'),
                      ),
                      Text(
                        "Yadeesha (You)",
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
                  Container(
                    height: 100,
                    width: 220,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      // itemExtent: 70.0,
                      shrinkWrap: true,
                      children: <Widget>[
                        Column(
                          children: [
                            CircleAvatar(
                              radius: 30.0,
                              backgroundImage:
                                  AssetImage('assets/images/user.jpg'),
                            ),
                            Text(
                              "Nethmi",
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
