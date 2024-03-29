import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:poolin/custom/backward_button.dart';
import 'package:poolin/custom/wide_button.dart';
import 'package:poolin/fonts.dart';
import 'package:poolin/screens/view-profile/mutual_friends_screen.dart';
import 'package:poolin/services/user_service.dart';
import 'package:poolin/utils/widget_functions.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../../colors.dart';

class RiderProfileScreen extends StatefulWidget {
  const RiderProfileScreen({super.key, required this.id});

  final id;

  @override
  RiderProfileScreenState createState() {
    return RiderProfileScreenState();
  }
}

class RiderProfileScreenState extends State<RiderProfileScreen> {
  Map<String, dynamic> userDetails = {};

  @override
  void initState() {
    getUser();
    super.initState();
  }

  void getUser() async {
    Response response = await getUserDetails(widget.id);
    setState(() {
      userDetails = response.data;
    });
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    const double padding = 16;
    const sidePadding = EdgeInsets.symmetric(horizontal: padding);
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
              Align(
                alignment: Alignment.topCenter,
                child: Stack(
                  alignment: AlignmentDirectional.topCenter,
                  children: const [
                    CircleAvatar(
                      radius: 60.0,
                      backgroundImage: NetworkImage(
                        'https://i.pravatar.cc/300?img=3',
                      ),
                    ),
                    Positioned(
                      right: 10.0,
                      bottom: 0.0,
                      child: Icon(
                        PhosphorIcons.circleWavyCheckFill,
                        color: BlipColors.orange,
                      ),
                    ),
                  ],
                ),
              ),
              Align(
                alignment: Alignment.topCenter,
                child: Column(
                  children: [
                    Text(
                      userDetails['firstname'] ?? "FirstName",
                      style: BlipFonts.title,
                    ),
                    const Text(
                      "Student",
                      style: BlipFonts.label,
                    ),
                  ],
                ),
              ),
              addVerticalSpace(40),
              const Text(
                "About",
                style: BlipFonts.title,
              ),
              addVerticalSpace(16),
              Text(
                userDetails['bio'] ?? "This user does not have a bio yet",
                style: BlipFonts.outline,
              ),
              addVerticalSpace(32),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    "Mutual friends",
                    style: BlipFonts.title,
                  ),
                  if (userDetails["mutuals"] != null)
                    if (userDetails["mutuals"].length > 0)
                      Text(
                        " (${userDetails["mutuals"].length.toString()})",
                        style: BlipFonts.label,
                      ),
                  const Spacer(),
                  if (userDetails["mutuals"] != null)
                    if (userDetails["mutuals"].length > 0)
                      IconButton(
                        icon: const Icon(
                          Icons.arrow_forward_ios_outlined,
                          size: 15,
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: ((context) => MutualFriendsScreen(
                                    friends: userDetails["mutuals"],
                                  )),
                            ),
                          );
                        },
                      ),
                ],
              ),
              addVerticalSpace(16),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  if (userDetails["mutuals"] != null)
                    if (userDetails["mutuals"].length > 0)
                      SizedBox(
                        height: size.height * 0.12,
                        child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (ctx, index) {
                            return Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8),
                              child: Column(
                                children: [
                                  const CircleAvatar(
                                    radius: 30.0,
                                    backgroundImage:
                                        AssetImage('assets/images/user.jpg'),
                                  ),
                                  Text(
                                    userDetails["mutuals"][index]['firstname'],
                                    style: BlipFonts.outline,
                                  ),
                                ],
                              ),
                            );
                          },
                          itemCount: userDetails["mutuals"].length < 4
                              ? userDetails["mutuals"].length
                              : 4,
                        ),
                      ),
                  if (userDetails["mutuals"] == null ||
                      userDetails["mutuals"].length == 0)
                    const Text(
                      "You have no friends in common",
                      style: BlipFonts.outline,
                    ),
                ],
              ),
              addVerticalSpace(32),
              WideButton(text: 'Send friend request', onPressedAction: () {}),
            ],
          ),
        ),
      ),
    );
  }
}
