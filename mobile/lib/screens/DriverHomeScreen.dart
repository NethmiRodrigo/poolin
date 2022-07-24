import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:mobile/custom/HomeToggle.dart';
import 'package:mobile/custom/RideCountDown.dart';
import 'package:mobile/models/passenger_request.dart';
import 'package:mobile/models/ride_request.dart';
import 'package:mobile/utils/widget_functions.dart';
import 'package:mobile/widgets/pass_request_list.dart';
import 'package:mobile/custom/custom_icons_icons.dart';
import 'package:mobile/fonts.dart';
import 'package:mobile/widgets/ride_request_list.dart';
import '../colors.dart';

class DriverHomeScreen extends StatefulWidget {
  const DriverHomeScreen({Key? key}) : super(key: key);

  @override
  DriverHomeScreenState createState() {
    return DriverHomeScreenState();
  }
}

class DriverHomeScreenState extends State<DriverHomeScreen> {
  final _storage = const FlutterSecureStorage();
  int endTime = DateTime.now().millisecondsSinceEpoch +
      const Duration(days: 1, hours: 2, minutes: 30).inMilliseconds;
  final Map<String, int> stat = {
    'rides': 18,
    'total_earnings': 1500,
    'passengers': 22,
  };
  final List<PassengerRequests> _passRequests = [
    PassengerRequests(
      id: '1',
      rider: 'John Doe',
      date: DateTime.now(),
    ),
    PassengerRequests(
      id: '3',
      rider: 'James Doe',
      date: DateTime.now().subtract(const Duration(hours: 5)),
    ),
    PassengerRequests(
      id: '3',
      rider: 'James Doe',
      date: DateTime.now().subtract(const Duration(hours: 5)),
    ),
  ];
  final List<RideRequest> _rideRequests = [
    RideRequest(
      id: '1',
      startLocation: 'University of Colombo',
      destination: 'Keells Super Dehiwala',
      requestedOn: DateTime.now(),
    ),
    RideRequest(
      id: '2',
      startLocation: 'Faculty of Science',
      destination: 'Keells Super Dehiwala',
      requestedOn: DateTime.now().subtract(const Duration(hours: 5)),
    ),
    RideRequest(
      id: '2',
      startLocation: 'Faculty of Science',
      destination: 'Keells Super Dehiwala',
      requestedOn: DateTime.now().subtract(const Duration(hours: 5)),
    ),
  ];
  bool isRiding = true; //driver is riding if he currently has a ride

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
              'Going somewhere?',
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
                          'Offer a ride to someone and get paid',
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
              'This month’s stats',
              style: BlipFonts.title,
            ),
            addVerticalSpace(16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    Text(stat['rides'].toString(), style: BlipFonts.title),
                    const Text('Rides', style: BlipFonts.outline)
                  ],
                ),
                Column(
                  children: [
                    RichText(
                        text: TextSpan(
                            text: 'LKR',
                            style: BlipFonts.outline.merge(
                                const TextStyle(color: BlipColors.black)),
                            children: [
                          TextSpan(
                              text: stat['total_earnings'].toString(),
                              style: BlipFonts.title
                                ..merge(
                                    const TextStyle(color: BlipColors.black)))
                        ])),
                    const Text('Total earnings', style: BlipFonts.outline)
                  ],
                ),
                Column(
                  children: [
                    Text(stat['passengers'].toString(), style: BlipFonts.title),
                    const Text('Passengers', style: BlipFonts.outline)
                  ],
                ),
              ],
            ),
            addVerticalSpace(24),
            const Text(
              'Ride requests',
              style: BlipFonts.title,
            ),
            Container(
              height: size.height * 0.3,
              child: isRiding
                  ? PassengerRequestList(_passRequests)
                  : RideRequestList(_rideRequests),
            ),
          ],
        ),
      ),
    );
  }
}
