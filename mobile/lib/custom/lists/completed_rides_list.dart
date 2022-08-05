import 'package:flutter/material.dart';
import 'package:mobile/custom/cards/ride_offer_card.dart';
import 'package:mobile/custom/cards/ride_request_card.dart';
import 'package:mobile/fonts.dart';

import 'package:mobile/models/ride_offer.dart';
import 'package:mobile/models/ride_request.dart';

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
                    : Container()
        ],
      ),
    );
  }
}