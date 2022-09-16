import 'package:flutter/material.dart';
import 'package:mobile/colors.dart';
import 'package:mobile/custom/lists/cancelled_rides_list.dart';
import 'package:mobile/custom/lists/completed_rides_list.dart';
import 'package:mobile/custom/lists/upcoming_rides_list.dart';
import 'package:mobile/data.dart';
import 'package:mobile/fonts.dart';
import 'package:mobile/models/ride_offer.dart';
import 'package:mobile/models/ride_request.dart';
import 'package:mobile/utils/widget_functions.dart';

class RideHistory extends StatefulWidget {
  const RideHistory({Key? key}) : super(key: key);

  @override
  State<RideHistory> createState() => _RideHistoryState();
}

class _RideHistoryState extends State<RideHistory> {
  final RideRequest sampleRideRequest = TestData.testRideRequest;
  final RideOffer sampleRideOffer = TestData.testRideOffer;

  final List<RideRequest> sampleRideRequestsList =
      TestData.testRideRequestsList;
  final List<RideOffer> sampleRideOffersList = TestData.testRideOffersList;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    const double padding = 16;
    const sidePadding = EdgeInsets.symmetric(horizontal: padding);

    return Scaffold(
        body: Padding(
      padding: sidePadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          addVerticalSpace(size.height * 0.07),
          const Text(
            'Ride History',
            style: BlipFonts.title,
          ),
          addVerticalSpace(size.height * 0.02),
          DefaultTabController(
            length: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const TabBar(
                  labelColor: BlipColors.black,
                  indicatorColor: BlipColors.orange,
                  unselectedLabelColor: BlipColors.black,
                  labelStyle: BlipFonts.outlineBold,
                  tabs: [
                    Tab(text: 'Upcoming'),
                    Tab(text: 'Completed'),
                    Tab(text: 'Cancelled'),
                  ],
                ),
                Container(
                  height: size.height * 0.75,
                  decoration: const BoxDecoration(
                      border: Border(
                          top:
                              BorderSide(color: BlipColors.black, width: 1.0))),
                  child: TabBarView(
                    children: [
                      UpcomingRidesList(sampleRideRequest, sampleRideOffer),
                      CompletedRidesList(
                          sampleRideRequestsList, sampleRideOffersList),
                      CancelledRidesList(
                          sampleRideRequestsList, sampleRideOffersList),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    ));
  }
}
