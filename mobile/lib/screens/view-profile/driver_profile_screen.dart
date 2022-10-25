import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poolin/cubits/ride_request_cubit.dart';
import 'package:poolin/models/user_model.dart';
import 'package:poolin/screens/view-profile/mutual_friends_screen.dart';
import 'package:poolin/screens/view-ride-offers/view_ride_offers_screen.dart';
import 'package:poolin/services/user_service.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:poolin/custom/wide_button.dart';
import 'package:poolin/fonts.dart';
import 'package:poolin/utils/widget_functions.dart';
import '../../../colors.dart';

class DriverProfileScreen extends StatefulWidget {
  final int driverId;
  const DriverProfileScreen(this.driverId, {super.key});

  @override
  DriverProfileScreenState createState() {
    return DriverProfileScreenState();
  }
}

class DriverProfileScreenState extends State<DriverProfileScreen> {
  late User driver;
  bool isLoading = true;
  List<dynamic> friends = [];

  @override
  void initState() {
    super.initState();
    fetchProfileinfo();
  }

  void fetchProfileinfo() async {
    Response response = await getUserDetails(widget.driverId);
    if (response.statusCode == 200) {
      setState(() {
        friends = response.data['mutuals'];
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
    final RideRequestCubit reqCubit =
        BlocProvider.of<RideRequestCubit>(context);

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: BlipColors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(
                color: BlipColors.orange,
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
                    addVerticalSpace(80),
                    Align(
                      alignment: Alignment.topCenter,
                      child: Stack(
                        alignment: AlignmentDirectional.topCenter,
                        children: [
                          CircleAvatar(
                            radius: 60.0,
                            backgroundColor: BlipColors.lightGrey,
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
                          borderRadius:
                              const BorderRadius.all(Radius.circular(7)),
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
                                builder: (context) => MutualFriendsScreen(
                                  friends: friends,
                                ),
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
                        if (friends.isNotEmpty)
                          for (var friend in friends)
                            Column(
                              children: [
                                CircleAvatar(
                                  radius: 30.0,
                                  backgroundImage:
                                      friend['profileImageUri'] != null
                                          ? NetworkImage(
                                              friend['profileImageUri'],
                                            )
                                          : const NetworkImage(
                                              'https://i.pravatar.cc/300?img=4',
                                            ),
                                ),
                                Text(
                                  friend['firstname'],
                                  style: BlipFonts.outline,
                                ),
                              ],
                            ),
                      ],
                    ),
                    addVerticalSpace(32),
                  ],
                ),
              ),
            ),
    );
  }
}
