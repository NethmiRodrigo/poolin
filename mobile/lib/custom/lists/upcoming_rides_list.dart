import 'package:flutter/material.dart';
import 'package:mobile/custom/cards/ride_offer_card.dart';
import 'package:mobile/custom/cards/ride_request_card.dart';
import 'package:mobile/fonts.dart';

import 'package:mobile/models/ride_offer.dart';
import 'package:mobile/models/ride_request.dart';

class UpcomingRidesList extends StatelessWidget {
  final RideRequest upcomingRideRequest;
  final RideOffer upcomingRideOffer;

  const UpcomingRidesList(this.upcomingRideRequest, this.upcomingRideOffer,
      {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          upcomingRideRequest != null
              ? RideRequestCard(upcomingRideRequest)
              : Container(),
          upcomingRideOffer != null
              ? RideOfferCard(upcomingRideOffer)
              : const Expanded(
                  child: Center(
                    child: Text(
                      'No rides scheduled yet',
                      style: BlipFonts.heading,
                    ),
                  ),
                )
        ],
      ),
    );
  }
}
