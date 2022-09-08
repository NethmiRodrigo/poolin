import 'package:dio/dio.dart';
import 'package:mobile/models/user_model.dart';
import 'package:mobile/screens/request-ride/request_confirmation.dart';
import 'package:mobile/screens/view-profile/mutual_friends_screen.dart';
import 'package:mobile/services/user_service.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:mobile/custom/wide_button.dart';
import 'package:mobile/fonts.dart';
import 'package:mobile/utils/widget_functions.dart';
import '../../../colors.dart';

class DriverProfileScreen extends StatefulWidget {
  final String driverId;
  const DriverProfileScreen(this.driverId, {super.key});

  @override
  DriverProfileScreenState createState() {
    return DriverProfileScreenState();
  }
}

class DriverProfileScreenState extends State<DriverProfileScreen> {
  late User driver;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchProfileinfo();
  }

  void fetchProfileinfo() async {
    Response response = await getUser(widget.driverId);
    if (response.statusCode == 200) {
      setState(() {
        driver = User.fromJson(response.data);
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    const double padding = 16;
    const sidePadding = EdgeInsets.symmetric(horizontal: padding);
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: const CircleAvatar(
            backgroundColor: BlipColors.white,
            child: Icon(Icons.arrow_back, color: BlipColors.black),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(
                value: null,
                semanticsLabel: 'Please wait',
                color: BlipColors.grey,
              ),
            )
          : SizedBox(
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
                    Align(
                      alignment: Alignment.topCenter,
                      child: Stack(
                        alignment: AlignmentDirectional.topCenter,
                        children: [
                          CircleAvatar(
                            radius: 60.0,
                            backgroundImage: NetworkImage(
                              driver.profilePicURL,
                            ),
                          ),
                          const Positioned(
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
                            driver.firstName,
                            style: BlipFonts.title,
                          ),
                          Text(
                            driver.occupation == null
                                ? 'Unknown'
                                : driver.occupation.toString(),
                            style: BlipFonts.label,
                          ),
                        ],
                      ),
                    ),
                    addVerticalSpace(16),
                    Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          border: Border.all(width: 1.0),
                          borderRadius: const BorderRadius.all(Radius.circular(
                                  7) //                 <--- border radius here
                              ),
                        ),
                        child: SizedBox(
                          height: 40,
                          width: 150,
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                const Icon(EvaIcons.star,
                                    color: BlipColors.gold),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      driver.stars.toString(),
                                      style: BlipFonts.labelBold,
                                    ),
                                    const Text(
                                      "Stars",
                                      style: BlipFonts.outline,
                                    )
                                  ],
                                ),
                                const VerticalDivider(
                                  width: 20,
                                  thickness: 1,
                                  indent: 0,
                                  endIndent: 0,
                                  color: Colors.black,
                                ),
                                const Icon(EvaIcons.navigation2,
                                    color: BlipColors.blue),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      driver.totalRatings.toString(),
                                      style: BlipFonts.labelBold,
                                    ),
                                    const Text(
                                      "Rides",
                                      style: BlipFonts.outline,
                                    )
                                  ],
                                )
                              ]),
                        ),
                      ),
                    ),
                    addVerticalSpace(32),
                    const Text(
                      "Know your driver",
                      style: BlipFonts.title,
                    ),
                    addVerticalSpace(16),
                    Text(
                      driver.bio == null ? 'No bio' : driver.bio.toString(),
                      style: BlipFonts.outline,
                    ),
                    addVerticalSpace(32),
                    Row(
                      children: [
                        const Text(
                          "Mutual friends",
                          style: BlipFonts.title,
                        ),
                        const Text(
                          "  (5)",
                          style: BlipFonts.label,
                        ),
                        const Spacer(),
                        IconButton(
                          icon: const Icon(
                            Icons.arrow_forward_ios_outlined,
                            size: 15,
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    const MutualFriendsScreen(),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                    addVerticalSpace(16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          children: const [
                            CircleAvatar(
                              radius: 30.0,
                              backgroundImage: NetworkImage(
                                'https://i.pravatar.cc/300?img=4',
                              ),
                            ),
                            Text(
                              "Dulaj",
                              style: BlipFonts.outline,
                            ),
                          ],
                        ),
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
                    addVerticalSpace(32),
                    WideButton(
                      text: 'Request to join the ride',
                      onPressedAction: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const RequestConfirmation()),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
