import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:mobile/custom/wide_button.dart';
import 'package:mobile/custom/outline_button.dart';
import 'package:mobile/fonts.dart';
import 'package:mobile/utils/widget_functions.dart';
import '../../../colors.dart';

class MutualFriendsScreen extends StatefulWidget {
  const MutualFriendsScreen({super.key});

  @override
  MutualFriendsScreenState createState() {
    return MutualFriendsScreenState();
  }
}

class MutualFriendsScreenState extends State<MutualFriendsScreen> {
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
              addVerticalSpace(48),
              Text(
                "Mutual Friends",
                style: BlipFonts.display,
              ),
              addVerticalSpace(40),
              Padding(
                padding: EdgeInsets.fromLTRB(0.0, 0.0, 12.0, 0.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CircleAvatar(
                      radius: 30.0,
                      backgroundImage: AssetImage('assets/images/user.jpg'),
                    ),
                    addHorizontalSpace(16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Nethmi Dilinika ",
                          style: BlipFonts.labelBold,
                        ),
                        Text(
                          "Student",
                          style: BlipFonts.label,
                        ),
                      ],
                    ),
                    Spacer(),
                    OutlineButton(text: "SEE PROFILE", color: BlipColors.black),
                  ],
                ),
              ),
              addVerticalSpace(24),
             Padding(
                padding: EdgeInsets.fromLTRB(0.0, 0.0, 12.0, 0.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CircleAvatar(
                      radius: 30.0,
                      backgroundImage: AssetImage('assets/images/user.jpg'),
                    ),
                    addHorizontalSpace(16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Nethmi Dilinika ",
                          style: BlipFonts.labelBold,
                        ),
                        Text(
                          "Student",
                          style: BlipFonts.label,
                        ),
                      ],
                    ),
                    Spacer(),
                    OutlineButton(text: "SEE PROFILE", color: BlipColors.black),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
