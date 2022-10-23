import 'package:flutter/material.dart';
import 'package:poolin/custom/cards/ride_offer_card.dart';
import 'package:poolin/custom/cards/ride_request_card.dart';
import 'package:poolin/fonts.dart';

import 'package:poolin/models/ride_offer.dart';
import 'package:poolin/models/ride_request.dart';

class CompletedRidesList extends StatelessWidget {
  final List<RideRequest> completedRideRequests;
  final List<RideOffer> completedRideOffers;
  late List completedRides;

  CompletedRidesList(this.completedRideRequests, this.completedRideOffers,
      {Key? key})
      : super(key: key) {
    combineList();
  }

  void combineList() {
    completedRides = [...completedRideRequests, ...completedRideOffers];
    completedRides.shuffle();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          for (var item in completedRides)
            (item is RideOffer)
                ? RideOfferCard(item)
                : (item is RideRequest)
                    ? RideRequestCard(item)
                    : const Expanded(
                        child: Center(
                          child: Text(
                            'No completed rides yet',
                            style: BlipFonts.heading,
                          ),
                        ),
                      )
        ],
      ),
    );
  }
}
