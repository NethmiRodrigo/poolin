import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart';
import 'package:mobile/colors.dart';
import 'package:mobile/custom/WideButton.dart';
import 'package:mobile/custom/indicator.dart';
import 'package:mobile/fonts.dart';

import 'package:mobile/screens/LoginScreen.dart';

import 'package:mobile/utils/widget_functions.dart';
import 'package:mobile/screens/EmailOTPScreen.dart';

import '../custom/dashed_line.dart';
import '../custom/outline_button.dart';
import '../custom/timeline.dart';

class ReservationRequestScreen extends StatefulWidget {
  const ReservationRequestScreen({super.key});

  @override
  ReservationRequestScreenState createState() {
    return ReservationRequestScreenState();
  }
}

class ReservationRequestScreenState extends State<ReservationRequestScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _pass = TextEditingController();
  final TextEditingController _confirmPass = TextEditingController();
  final _storage = const FlutterSecureStorage();

  @override
  void dispose() {
    _email.dispose();
    _pass.dispose();
    _confirmPass.dispose();
    super.dispose();
  }

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
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              addVerticalSpace(44),
              Align(
                  alignment: Alignment.topLeft,
                  child: Icon(
                    EvaIcons.arrowBackOutline,
                    color: Colors.black,
                  )),
              addVerticalSpace(16),
              Text(
                'Reservation Request',
                style: BlipFonts.title,
              ),
              addVerticalSpace(32),
              Container(
                height: 160,
                decoration: BoxDecoration(
                  color: BlipColors.orange,
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              addVerticalSpace(24),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Wednesday, 11th June, 2022',
                  style: BlipFonts.outline,
                ),
              ),
              addVerticalSpace(32),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      Text("11.30 AM", style: BlipFonts.outlineBold),
                      addVerticalSpace(32),
                      Text("12.30 AM", style: BlipFonts.outlineBold),
                    ],
                  ),
                  Column(
                    children: [
                      Icon(
                        Icons.check_box_outline_blank_rounded,
                        color: BlipColors.orange,
                        size: 16,
                      ),
                      CustomPaint(
                          size: Size(1, 18),
                          painter: DashedLineVerticalPainter()),
                      Icon(EvaIcons.arrowIosDownward, color: BlipColors.orange),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("University of Colombo",
                          style: BlipFonts.labelBold
                              .merge(TextStyle(color: BlipColors.orange))),
                      addVerticalSpace(24),
                      Text("Galadari Hotel",
                          style: BlipFonts.labelBold
                              .merge(TextStyle(color: BlipColors.orange))),
                    ],
                  )
                ],
              ),
              addVerticalSpace(40),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Text(
                          ("total trip fare").toUpperCase(),
                          style: BlipFonts.outlineBold,
                        ),
                        addVerticalSpace(16),
                        Row(
                          children: [
                            Text(
                              "Rs. 5500",
                              style: BlipFonts.labelBold,
                            ),
                            addHorizontalSpace(8),
                            Indicator(
                                icon: Icons.arrow_upward,
                                text: "+ Rs. 500",
                                color: BlipColors.green),
                          ],
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          ("room availible").toUpperCase(),
                          style: BlipFonts.outlineBold,
                        ),
                        addVerticalSpace(16),
                        Row(
                          children: [
                            Text(
                              "0",
                              style: BlipFonts.labelBold,
                            ),
                            addHorizontalSpace(8),
                            Indicator(
                                icon: Icons.arrow_downward,
                                text: "-1",
                                color: BlipColors.red),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              addVerticalSpace(32),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        backgroundImage: NetworkImage(
                            "https://www.rd.com/wp-content/uploads/2017/09/01-shutterstock_476340928-Irina-Bg.jpg?fit=640,427"),
                      ),
                      addHorizontalSpace(8),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Yadeeesha Werasinghe",
                            style: BlipFonts.outline,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Row(
                                children: [
                                  //star icon
                                  Icon(EvaIcons.star,
                                      color: BlipColors.gold, size: 8),
                                  addHorizontalSpace(4),
                                  Text(
                                    "4.5",
                                    style: BlipFonts.tagline,
                                  ),
                                ],
                              ),
                              addHorizontalSpace(8),
                              Icon(
                                Icons.circle,
                                size: 2,
                              ),
                              addHorizontalSpace(8),
                              Text("250 ratings", style: BlipFonts.tagline),
                            ],
                          )
                        ],
                      )
                    ],
                  ),
                  OutlineButton(
                    text: "See Profile",
                    color: BlipColors.black,
                  )
                ],
              ),
              addVerticalSpace(40),
              WideButton(text: 'Reserve a Seat', onPressedAction: () {})
            ],
          ),
        ),
      ),
    );
  }
}
