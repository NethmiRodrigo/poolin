import 'package:flutter/material.dart';
import 'package:poolin/custom/cards/ride_offer_card.dart';
import 'package:poolin/custom/cards/ride_request_card.dart';
import 'package:poolin/fonts.dart';

import 'package:poolin/models/ride_offer.dart';
import 'package:poolin/models/ride_request.dart';

class CancelledRidesList extends StatelessWidget {
  final List<RideRequest> cancelledRideRequests;
  final List<RideOffer> cancelledRideOffers;
  late List cancelledRides;

  CancelledRidesList(this.cancelledRideRequests, this.cancelledRideOffers,
      {Key? key})
      : super(key: key) {
    combineList();
  }

  void combineList() {
    cancelledRides = [...cancelledRideRequests, ...cancelledRideOffers];
    cancelledRides.length = cancelledRides.length - 5;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          for (var item in cancelledRides)
            (item is RideOffer)
                ? RideOfferCard(item)
                : (item is RideRequest)
                    ? RideRequestCard(item)
                    : const Expanded(
                        child: Center(
                          child: Text(
                            'No cancelled rides yet',
                            style: BlipFonts.heading,
                          ),
                        ),
                      )
        ],
      ),
    );
  }
}
