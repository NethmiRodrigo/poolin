import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:mobile/custom/HomeToggle.dart';
import 'package:mobile/custom/RideCountDown.dart';
import 'package:mobile/models/friend.dart';
import 'package:mobile/models/passenger_request.dart';
import 'package:mobile/models/ride_offer.dart';
import 'package:mobile/models/ride_request.dart';
import 'package:mobile/utils/widget_functions.dart';
import 'package:mobile/widgets/close_friends_list.dart';
import 'package:mobile/widgets/pass_request_list.dart';
import 'package:mobile/custom/custom_icons_icons.dart';
import 'package:mobile/fonts.dart';
import 'package:mobile/widgets/ride_offer_list.dart';
import 'package:mobile/widgets/ride_request_list.dart';
import '../colors.dart';

class RiderHomeScreen extends StatefulWidget {
  const RiderHomeScreen({Key? key}) : super(key: key);

  @override
  State<RiderHomeScreen> createState() => _RiderHomeScreenState();
}

class _RiderHomeScreenState extends State<RiderHomeScreen> {
  final _storage = const FlutterSecureStorage();
  int endTime = DateTime.now().millisecondsSinceEpoch +
      const Duration(days: 1, hours: 2, minutes: 30).inMilliseconds;

  final List<RideOffer> _rideOffers = [
    RideOffer(
      id: '1',
      startLocation: 'Town Hall',
      destination: 'Fort Railway Station',
      offeredOn: DateTime.now(),
    ),
    RideOffer(
      id: '2',
      startLocation: 'Negambo town',
      destination: 'Baththaramulla',
      offeredOn: DateTime.now().subtract(const Duration(hours: 5)),
    ),
    RideOffer(
      id: '2',
      startLocation: 'Negambo town',
      destination: 'Baththaramulla',
      offeredOn: DateTime.now().subtract(const Duration(minutes: 15)),
    ),
    RideOffer(
      id: '2',
      startLocation: 'Negambo town',
      destination: 'Baththaramulla',
      offeredOn: DateTime.now().subtract(const Duration(minutes: 15)),
    ),
  ];
  final List<Friend> _friends = [
    Friend(
      id: '1',
      firstName: 'John',
      lastName: 'Doe',
    ),
    Friend(
      id: '2',
      firstName: 'James',
      lastName: 'Anderson',
    ),
  ];
  bool isRiding = false; //driver is riding if he currently has a ride

  @override
  Widget build(BuildContext context) {
    const double padding = 16;
    final Size size = MediaQuery.of(context).size;
    const sidePadding = EdgeInsets.symmetric(horizontal: padding);

    return Scaffold(
      body: SingleChildScrollView(
        padding: sidePadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            addVerticalSpace(48),
            Align(
              alignment: Alignment.topRight,
              child: HomeToggle(),
            ),
            addVerticalSpace(16),
            const Text(
              'Looking for a ride?',
              style: BlipFonts.title,
            ),
            addVerticalSpace(16),
            isRiding
                ? RideCountDown(endTime)
                : Container(
                    width: size.width,
                    padding: const EdgeInsets.all(16),
                    height: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: BlipColors.orange,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          'See who else is travelling your way',
                          style: BlipFonts.labelBold
                              .merge(const TextStyle(color: BlipColors.white)),
                        ),
                        Container(
                          alignment: Alignment.bottomRight,
                          child: const Icon(CustomIcons.arrow_right,
                              size: 20, color: BlipColors.white),
                        )
                      ],
                    ),
                  ),
            addVerticalSpace(24),
            const Text(
              'Find out where your friends are headed',
              style: BlipFonts.title,
            ),
            // Container(
            //   width: size.width,
            //   height: size.height * 0.1,
            //   child: CloseFriendsList(_friends),
            // ),
            addVerticalSpace(24),
            const Text(
              'Ride offers',
              style: BlipFonts.title,
            ),
            Container(
              height: size.height * 0.4,
              child: RideOfferList(_rideOffers),
            ),
          ],
        ),
      ),
    );
  }
}
