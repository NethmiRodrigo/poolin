import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/cubits/active_ride_cubit.dart';

import 'package:mobile/custom/lists/pass_request_list.dart';
import 'package:mobile/custom/lists/ride_request_list.dart';
import 'package:mobile/custom/toggle_to_driver.dart';
import 'package:mobile/custom/ride_countdown.dart';
import 'package:mobile/models/active_ride_offer.dart';
import 'package:mobile/models/passenger_request.dart';
import 'package:mobile/models/ride_request.dart';
import 'package:mobile/models/user_model.dart';
import 'package:mobile/screens/shared/ride/destination_screen.dart';
import 'package:mobile/services/ride_offer_service.dart';
import 'package:mobile/utils/widget_functions.dart';
import 'package:mobile/icons.dart';
import 'package:mobile/fonts.dart';
import '../../colors.dart';

class DriverHomeScreen extends StatefulWidget {
  const DriverHomeScreen({Key? key}) : super(key: key);

  @override
  DriverHomeScreenState createState() {
    return DriverHomeScreenState();
  }
}

class DriverHomeScreenState extends State<DriverHomeScreen> {
  int endTime = DateTime.now().millisecondsSinceEpoch +
      const Duration(days: 1, hours: 2, minutes: 30).inMilliseconds;
  final Map<String, int> stat = {
    'rides': 18,
    'total_earnings': 1500,
    'passengers': 22,
  };
  final List<PassengerRequest> _passRequests = [
    PassengerRequest(
        id: '1',
        rider: 'Nethmi Pathirana',
        date: DateTime.now(),
        profilePicture: 'https://i.pravatar.cc/150?img=47'),
  ];
  final List<RideRequest> _rideRequests = [
    RideRequest(
        id: '1',
        rideID: '00001',
        pickupLocation: 'University of Colombo',
        dropoffLocation: 'Keells Super Dehiwala',
        requestedOn: DateTime.now(),
        driver: User(
          firstName: 'Yadeesha',
          lastName: 'Weerasinghe',
          gender: 'female',
          email: 'yadeesha@gmail.com',
        ),
        profilePicture: "https://i.pravatar.cc/150?img=3"),
    RideRequest(
        id: '2',
        rideID: '00001',
        pickupLocation: 'Town Hall',
        dropoffLocation: 'Mahabuthgamuwa Bus Stop',
        requestedOn: DateTime.now().subtract(const Duration(hours: 5)),
        driver: User(
          firstName: 'Yadeesha',
          lastName: 'Weerasinghe',
          gender: 'female',
          email: 'yadeesha@gmail.com',
        ),
        profilePicture: "https://i.pravatar.cc/150?img=3"),
    RideRequest(
        id: '2',
        rideID: '00001',
        pickupLocation: 'Gampaha Bus Stop',
        dropoffLocation: 'Nugegoda',
        requestedOn: DateTime.now().subtract(const Duration(hours: 5)),
        driver: User(
          firstName: 'Yadeesha',
          lastName: 'Weerasinghe',
          gender: 'female',
          email: 'yadeesha@gmail.com',
        ),
        profilePicture: "https://i.pravatar.cc/150?img=3"),
  ];
  bool isDriving = false; //driver is driving if he currently has a ride

  @override
  void initState() {
    super.initState();
    getOffer();
  }

  void getOffer() async {
    Response response = await getActiveOffer();
    if (response.data["offer"] != null) {
      ActiveRideOffer rideOffer =
          ActiveRideOffer.fromJson(response.data["offer"]);
      ActiveRideCubit activeRideCubit =
          BlocProvider.of<ActiveRideCubit>(context);
      activeRideCubit.setId(rideOffer.id);
      activeRideCubit.setDepartureTime(rideOffer.departureTime);
      DateTime? departureTime = rideOffer.departureTime;
      int endTimeInSeconds = departureTime.millisecondsSinceEpoch;
      setState(() {
        endTime = endTimeInSeconds;
        isDriving = true;
      });
    }
  }

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
            const Align(
              alignment: Alignment.topRight,
              child: ToggleToDriver(false),
            ),
            addVerticalSpace(16),
            const Text(
              'Going somewhere?',
              style: BlipFonts.title,
            ),
            addVerticalSpace(16),
            isDriving
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
                          child: IconButton(
                            icon: const Icon(
                              BlipIcons.arrow_right,
                              size: 20,
                              color: BlipColors.white,
                            ),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => DestinationScreen(),
                                  ));
                            },
                          ),
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
            Text(
              isDriving
                  ? 'Ride requests for your offers'
                  : 'Passenger Ride Requests',
              style: BlipFonts.title,
            ),
            Container(
              height: size.height * 0.3,
              child: isDriving
                  ? PassengerRequestList(_passRequests)
                  : RideRequestList(_rideRequests),
            ),
          ],
        ),
      ),
    );
  }
}
