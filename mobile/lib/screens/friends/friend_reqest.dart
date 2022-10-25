import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:mobile/custom/wide_button.dart';
import 'package:mobile/custom/outline_button.dart';
import 'package:mobile/fonts.dart';
import 'package:mobile/utils/widget_functions.dart';
import '../../../colors.dart';
import 'package:akar_icons_flutter/akar_icons_flutter.dart';

class FrienreqFriendsScreen extends StatefulWidget {
  const FrienreqFriendsScreen({super.key});

  @override
  FrienreqFriendsScreenState createState() {
    return FrienreqFriendsScreenState();
  }
}

class FrienreqFriendsScreenState extends State<FrienreqFriendsScreen> {
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
              addVerticalSpace(32),
              Align(
                alignment: Alignment.topLeft,
                child: GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const Icon(
                      EvaIcons.arrowBackOutline,
                      color: Colors.black,
                    )),
              ),
              addVerticalSpace(24),
              const Text(
                "Friend Request",
                style: BlipFonts.display,
              ),
              addVerticalSpace(32),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextFormField(
                      autofocus: true,
                      showCursor: true,
                      readOnly: false,
                      style: Theme.of(context).textTheme.labelLarge,
                      textAlignVertical: TextAlignVertical.center,
                      key: const Key('destination-field'),
                      decoration: const InputDecoration(
                        prefixIcon: Icon(AkarIcons.search),
                        hintText: "Who are you looking for?",
                      ),
                    ),
                  ),
                ],
              ),
              addVerticalSpace(40),
              Padding(
                padding: EdgeInsets.fromLTRB(0.0, 0.0, 12.0, 0.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CircleAvatar(
                      radius: 30.0,
                      backgroundImage: AssetImage('assets/images/woman.jpeg'),
                    ),
                    addHorizontalSpace(8),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Nethmi Dilini ",
                          style: BlipFonts.labelBold,
                        ),
                        Text(
                          "Student",
                          style: BlipFonts.label,
                        ),
                        // OutlineButton(
                        //   text: "A",
                        //   color: BlipColors.black,
                        //   onPressedAction: () {},
                        // ),
                      ],
                    ),
                    Spacer(),
                    OutlineButton(
                      text: "Accept",
                      color: BlipColors.black,
                      onPressedAction: () {},
                    ),
                    OutlineButton(
                      text: "Reject",
                      color: BlipColors.black,
                      onPressedAction: () {},
                    ),
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
                    addHorizontalSpace(8),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Prabath Silva ",
                          style: BlipFonts.labelBold,
                        ),
                        Text(
                          "Student",
                          style: BlipFonts.label,
                        ),
                      ],
                    ),
                    Spacer(),
                    OutlineButton(
                      text: "Accept",
                      color: BlipColors.black,
                      onPressedAction: () {},
                    ),
                    OutlineButton(
                      text: "Reject",
                      color: BlipColors.black,
                      onPressedAction: () {},
                    ),
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
