import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:mobile/custom/outline_button.dart';
import 'package:mobile/fonts.dart';
import 'package:mobile/screens/view-profile/rider_profile_screen.dart';
import 'package:mobile/utils/widget_functions.dart';
import '../../../colors.dart';
import 'package:akar_icons_flutter/akar_icons_flutter.dart';

class MutualFriendsScreen extends StatefulWidget {
  MutualFriendsScreen({super.key, required this.friends});

  List<dynamic> friends;

  @override
  MutualFriendsScreenState createState() {
    return MutualFriendsScreenState();
  }
}

class MutualFriendsScreenState extends State<MutualFriendsScreen> {
  @override
  Widget build(BuildContext context) {
    print(widget.friends);
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
                  ),
                ),
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
              if (widget.friends.isNotEmpty)
                SizedBox(
                  height: size.height * 0.12,
                  child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemBuilder: (ctx, index) {
                      return Padding(
                        padding: const EdgeInsets.fromLTRB(0.0, 0.0, 12.0, 0.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            const CircleAvatar(
                              radius: 30.0,
                              backgroundImage:
                                  AssetImage('assets/images/user.jpg'),
                            ),
                            addHorizontalSpace(16),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  widget.friends[index]['firstname'] ??
                                      "First Name",
                                  style: BlipFonts.labelBold,
                                ),
                                const Text(
                                  "Student",
                                  style: BlipFonts.label,
                                ),
                              ],
                            ),
                            const Spacer(),
                            OutlineButton(
                              text: "SEE PROFILE",
                              color: BlipColors.black,
                              onPressedAction: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => RiderProfileScreen(
                                        id: widget.friends[index]["id"]),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      );
                    },
                    itemCount: widget.friends.length,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
