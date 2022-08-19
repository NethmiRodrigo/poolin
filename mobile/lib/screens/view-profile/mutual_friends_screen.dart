import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:poolin/custom/wide_button.dart';
import 'package:poolin/custom/outline_button.dart';
import 'package:poolin/fonts.dart';
import 'package:poolin/utils/widget_functions.dart';
import '../../../colors.dart';
import 'package:akar_icons_flutter/akar_icons_flutter.dart';

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
                "Mutual Friends",
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
                      autofocus: false,
                      showCursor: false,
                      readOnly: true,
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
                    OutlineButton(
                      text: "SEE PROFILE",
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
                    OutlineButton(
                      text: "SEE PROFILE",
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
