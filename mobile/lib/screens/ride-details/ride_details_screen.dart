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
              const Text(
                "Your Trip",
                style: BlipFonts.heading,
              ),
              Row(
                children: [
                  Text(
                    "Sunday, 14th August",
                    style: BlipFonts.label,
                  ),
                  const Spacer(),
                  TextButton(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 6),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: BlipColors.orange,
                      ),
                      child: Text(("12:28AM").toUpperCase(),
                          style: BlipFonts.outlineBold
                              .merge(const TextStyle(color: BlipColors.white))),
                    ),
                    onPressed: () {},
                  )
                ],
              ),
              addVerticalSpace(12),
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
<<<<<<< HEAD
                                      Flexible(
                                        child: Text(
                                          'University of Colombo, School of Computing',
                                          style: BlipFonts.labelBold,
                                          overflow: TextOverflow.clip,
                                        ),
                                      ),
=======
                                      Text('No.20, Borelasgamuwa',
                                          style: BlipFonts.labelBold),
>>>>>>> add-offers-to-requests
                                      Spacer(),
                                      Text('12:28 PM',
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
<<<<<<< HEAD
                                          Text('Lionel Wendt Art Theatre',
                                              style: BlipFonts.label),
                                          Text('Pick up Nethmi',
=======
                                          const Text('No.20, Borelasgamuwa',
                                              style: BlipFonts.label),
                                          const Text('Pick up Sarah',
>>>>>>> add-offers-to-requests
                                              style: BlipFonts.outline),
                                          addVerticalSpace(4),
                                        ],
                                      ),
<<<<<<< HEAD
                                      Spacer(),
                                      Text('12:40 PM',
                                          style: BlipFonts.outline),
=======
                                      const Spacer(),
                                      const Text('7:30 AM', style: BlipFonts.outline),
>>>>>>> add-offers-to-requests
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
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
<<<<<<< HEAD
                                          Text('Cinnamon Red',
                                              style: BlipFonts.label),
                                          Text('Drop off Nethmi',
=======
                                          const Text('No.20, Thunmulla',
                                              style: BlipFonts.label),
                                          const Text('Drop off Sarah',
>>>>>>> add-offers-to-requests
                                              style: BlipFonts.outline),
                                          addVerticalSpace(4),
                                        ],
                                      ),
<<<<<<< HEAD
                                      Spacer(),
                                      Text('12:50 PM',
                                          style: BlipFonts.outline),
=======
                                      const Spacer(),
                                      const Text('7:30 AM', style: BlipFonts.outline),
>>>>>>> add-offers-to-requests
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
<<<<<<< HEAD
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
=======
                                    children: const [
                                      Text(
                                          'University of Colombo\nSchool of Computing',
                                          style: BlipFonts.labelBold),
>>>>>>> add-offers-to-requests
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
                children: const [
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
                    children: const [
                      CircleAvatar(
                        radius: 40,
                        backgroundColor: BlipColors.lightGrey,
                        foregroundImage: NetworkImage(
                          "https://i.pravatar.cc/300?img=3",
                        ),
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
<<<<<<< HEAD
                              radius: 30,
                              backgroundColor: BlipColors.lightGrey,
                              foregroundImage: NetworkImage(
                                "https://i.pravatar.cc/300?img=9",
                              ),
=======
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
>>>>>>> add-offers-to-requests
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
