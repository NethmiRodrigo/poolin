import 'package:dio/dio.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import 'package:poolin/colors.dart';
import 'package:poolin/fonts.dart';
import 'package:poolin/screens/complain/complaint.dart';
import 'package:poolin/services/party_service.dart';
import 'package:poolin/services/rate_service.dart';

import '../../utils/widget_functions.dart';

class RatePassengersScreen extends StatefulWidget {
  const RatePassengersScreen({Key? key}) : super(key: key);

  @override
  State<RatePassengersScreen> createState() => _RatePassengersScreenState();
}

class _RatePassengersScreenState extends State<RatePassengersScreen> {
  var isVisible = false;
  List<dynamic>? party;

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    final response = await getParty();
    print("alohaj");
    party = response.data['users'];

    print(party);
    print("aloha");

    setState(() {
      isVisible = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    const double padding = 16;
    const sidePadding = EdgeInsets.symmetric(horizontal: padding);
    return SafeArea(
      child: Scaffold(
        body: Visibility(
          visible: isVisible,
          replacement: const Center(child: CircularProgressIndicator()),
          child: SizedBox(
            width: size.width,
            height: size.height,
            child: Padding(
              padding: sidePadding,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  addVerticalSpace(96),
                  const Text(
                    "Your ride has been completed!",
                    style: BlipFonts.heading,
                    textAlign: TextAlign.center,
                  ),
                  addVerticalSpace(96),
                  const Text(
                    "Rate the passengers",
                    style: BlipFonts.labelBold,
                  ),
                  Column(
                    children: [
                      for (var user in party!)
                        Column(
                          children: [
                            addVerticalSpace(16),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 24),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      CircleAvatar(
                                        radius: 16,
                                        backgroundImage: NetworkImage(
                                            user["profileImageUri"]),
                                      ),
                                      addHorizontalSpace(8),
                                      Text(
                                          user["firstname"] +
                                              "\n" +
                                              user["lastname"],
                                          style: BlipFonts.outline),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      RatingBar.builder(
                                        initialRating: 3,
                                        minRating: 1,
                                        direction: Axis.horizontal,
                                        allowHalfRating: true,
                                        itemCount: 5,
                                        itemSize: 16,
                                        itemPadding: const EdgeInsets.symmetric(
                                            horizontal: 4.0),
                                        itemBuilder: (context, _) => const Icon(
                                          EvaIcons.star,
                                          size: 8,
                                          color: BlipColors.gold,
                                        ),
                                        onRatingUpdate: (rating) async {
                                          print(user["firstname"]);
                                          Response response = await rateUser(
                                            rating,
                                            1,
                                            3,
                                            "rider",
                                            user["id"],
                                          );
                                        },
                                      ),
                                      IconButton(
                                        onPressed: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      ComplaintScreen(
                                                        name: user[
                                                                "firstname"] +
                                                            " " +
                                                            user["lastname"],
                                                        userId: user["id"],
                                                        avatar: user[
                                                            "profileImageUri"],
                                                      )));
                                        },
                                        icon: const Icon(
                                          EvaIcons.alertCircleOutline,
                                          color: BlipColors.blue,
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                    ],
                  ),
                  const Spacer(),
                  const Text("Skip", style: BlipFonts.outlineBold),
                  addVerticalSpace(48),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
