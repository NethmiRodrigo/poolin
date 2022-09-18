import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/cubits/active_ride_cubit.dart';
import 'package:mobile/custom/cards/home_screen_card.dart';

import 'package:mobile/custom/lists/pass_request_list.dart';
import 'package:mobile/custom/toggle_to_driver.dart';
import 'package:mobile/custom/ride_countdown.dart';
import 'package:mobile/models/active_ride_offer.dart';
import 'package:mobile/models/passenger_request.dart';
import 'package:mobile/models/ride_type_model.dart';
import 'package:mobile/screens/shared/ride/destination_screen.dart';
import 'package:mobile/services/ride_offer_service.dart';
import 'package:mobile/utils/widget_functions.dart';
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
  late ActiveRideCubit activeRideCubit;
  final Map<String, int> stat = {
    'rides': 18,
    'total_earnings': 1500,
    'passengers': 22,
  };
  List<PassengerRequest> _passRequests = [];
  late List<dynamic> pendingRequests;
  bool isDriving = false; //driver is driving if he currently has a ride
  bool isLoading = true;

  @override
  void initState() {
    activeRideCubit = BlocProvider.of<ActiveRideCubit>(context);
    super.initState();
    getOffer();
  }

  void getOffer() async {
    Response response = await getActiveOffer();
    if (response.data["offer"] != null) {
      ActiveRideOffer rideOffer =
          ActiveRideOffer.fromJson(response.data["offer"]);
      activeRideCubit.setId(rideOffer.id);
      activeRideCubit.setDepartureTime(rideOffer.departureTime);
      DateTime? departureTime = rideOffer.departureTime;
      int endTimeInSeconds = departureTime.millisecondsSinceEpoch;

      final requestData = await getOfferRequests(rideOffer.id);
      pendingRequests = requestData.data['requests'];
      List<PassengerRequest> passengerRequests = [];

      if (pendingRequests.isNotEmpty) {
        for (var request in pendingRequests) {
          passengerRequests.add(PassengerRequest(
              id: request['requestid'].toString(),
              rider: request['fname'],
              date: DateTime.now(),
              profilePicture:
                  request['avatar'] ?? 'https://i.pravatar.cc/150?img=47'));
        }
      }

      setState(() {
        endTime = endTimeInSeconds;
        isDriving = true;
        _passRequests = passengerRequests;
        isLoading = false;
      });
    } else {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    const double padding = 16;
    final Size size = MediaQuery.of(context).size;
    const sidePadding = EdgeInsets.symmetric(horizontal: padding);
    activeRideCubit = BlocProvider.of<ActiveRideCubit>(context);
    return Scaffold(
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(
                color: BlipColors.orange,
              ),
            )
          : SingleChildScrollView(
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
                  isDriving
                      ? RideCountDown(endTime)
                      : HomeScreenCard(
                          text: 'Offer a ride and get paid',
                          route: DestinationScreen(
                            rideType: RideType.offer,
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
                          Text(stat['rides'].toString(),
                              style: BlipFonts.title),
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
                                      ..merge(const TextStyle(
                                          color: BlipColors.black)))
                              ])),
                          const Text('Total earnings', style: BlipFonts.outline)
                        ],
                      ),
                      Column(
                        children: [
                          Text(stat['passengers'].toString(),
                              style: BlipFonts.title),
                          const Text('Passengers', style: BlipFonts.outline)
                        ],
                      ),
                    ],
                  ),
                  addVerticalSpace(24),
                  if (isDriving)
                    const Text(
                      'Ride Requests',
                      style: BlipFonts.title,
                    ),
                  SizedBox(
                    height: size.height * 0.3,
                    child: PassengerRequestList(_passRequests),
                  ),
                ],
              ),
            ),
    );
  }
}