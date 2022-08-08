import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:mobile/custom/dashed_line.dart';
import 'package:mobile/custom/timeline.dart';
import 'package:mobile/custom/wide_button.dart';
import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:mobile/fonts.dart';
import 'package:mobile/utils/widget_functions.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

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
                  child: Icon(
                    EvaIcons.arrowBackOutline,
                    color: Colors.black,
                  )),
              addVerticalSpace(16),
              Text(
                "You're going to \nColombo!",
                style: BlipFonts.display,
              ),
              addVerticalSpace(16),
              Text(
                "Your trip",
                style: BlipFonts.heading,
              ),
              Row(
                children: [
                  Text(
                    "Monday, 23rd June",
                    style: BlipFonts.label,
                  ),
                  Spacer(),
                  TextButton(
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: BlipColors.orange,
                      ),
                      child: Text(("7.30 AM").toUpperCase(),
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
                child: ListView(
                  scrollDirection: Axis.vertical,
                children: 
                  [Timeline(
                    indicators: const <Widget>[
                      Icon(
                            Icons.circle,
                            color: BlipColors.orange,
                            size: 16,
                          ),
                      Icon(
                            Icons.circle,
                            color: BlipColors.black,
                            size: 16,
                          ),
                      Icon(
                            Icons.circle,
                            color: BlipColors.black,
                            size: 16,
                          ),
                      Icon(
                            Icons.circle,
                            color: BlipColors.orange,
                            size: 16,
                          ),
                    ],
                    children: <Widget>[
                      Row(
                        children: [
                          SizedBox(
                            width: 225,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('No.27, suwarapola, Piliyandala',
                                    style: BlipFonts.labelBold),
                              ],
                            ),
                          ),
                          Spacer(),
                          Text('7.30 AM', style: BlipFonts.outline),
                        ],
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: 225,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('No.20, Borelasgamuwa',
                                    style: BlipFonts.label),
                                Text('Pick up sarah', style: BlipFonts.tagline),
                              ],
                            ),
                          ),
                          Spacer(),
                          Text('7.40 AM', style: BlipFonts.outline),
                        ],
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: 225,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Thunmulla junction', style: BlipFonts.label),
                                Text('Drop off sarah', style: BlipFonts.tagline),
                              ],
                            ),
                          ),
                          Spacer(),
                          Text('8.00 AM', style: BlipFonts.outline),
                        ],
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: 225,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('University of Colombo School of Computing',
                                    style: BlipFonts.labelBold),
                              ],
                            ),
                          ),
                          Spacer(),
                          Text('8.05 AM', style: BlipFonts.outline),
                        ],
                      ),
                    ],
                  ),
                ],
              )),
              addVerticalSpace(32),
              Row(
                children: [
                  Text(
                    "The Party",
                    style: BlipFonts.title,
                  ),
                  Spacer(),
                  CircleAvatar(
                      radius: 15.0,
                      backgroundColor: BlipColors.black,
                      child: Icon(
                        Icons.message_outlined,
                        color: BlipColors.white,
                        size: 18.0,
                      )),
                ],
              ),
              addVerticalSpace(16),
              Container(
                height: 120,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  itemExtent: 70.0,
                  shrinkWrap: true,
                  children: <Widget>[
                    Column(
                      children: [
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
                          style: BlipFonts.tagline,
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
              ),
              addVerticalSpace(24),
              WideButton(text: 'Cancel ride', onPressedAction: () async {}),
            ],
          ),
        ),
      ),
    );
  }
}
