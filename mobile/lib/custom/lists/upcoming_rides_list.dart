import 'package:flutter/material.dart';
import 'package:mobile/custom/cards/ride_offer_card.dart';
import 'package:mobile/custom/cards/ride_request_card.dart';
import 'package:mobile/fonts.dart';

import 'package:mobile/models/ride_offer.dart';
import 'package:mobile/models/ride_request.dart';
import 'package:mobile/models/user_model.dart';
import 'package:mobile/models/vehicle_type.dart';
import 'package:mobile/utils/widget_functions.dart';

class UpcomingRidesList extends StatelessWidget {
  const UpcomingRidesList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final RideRequest upcomingRideRequest = RideRequest(
        id: '1',
        rideID: '00001',
        pickupLocation: 'University of Colombo School of Computing',
        dropoffLocation: 'Fort Railway station',
        pickupTime: DateTime.now().add(const Duration(hours: 3, minutes: 15)),
        dropoffTime: DateTime.now().add(const Duration(hours: 3, minutes: 45)),
        totalDistance: 10,
        rideFare: 1500,
        requestedOn: DateTime.now().subtract(const Duration(hours: 1)),
        rider: User(
          firstName: 'Yadeesha',
          lastName: 'Weerasinghe',
          gender: 'female',
          email: 'yadeesha@gmail.com',
          stars: 4.5,
          totalRatings: 250,
        ));

    final RideOffer upcomingRideOffer = RideOffer(
        id: '00001',
        startLocation: 'University of Colombo School of Computing',
        destination: 'Fort Police station',
        rideDate: DateTime.now().add(const Duration(days: 1, hours: 3)),
        offeredOn: DateTime.now().subtract(const Duration(days: 3, hours: 1)),
        estimatedArrivalTime: DateTime.now(),
        totalDistance: 10,
        totalEarnings: 2500,
        driver: User(
          firstName: 'Yadeesha',
          lastName: 'Weerasinghe',
          gender: 'female',
          email: 'yadeesha@gmail.com',
          stars: 4.5,
          totalRatings: 250,
          vehicleType: VehicleType.car,
          VehicleNum: 'YAC9131',
        ),
        requests: [
          RideRequest(
            id: '1',
            rideID: '00001',
            pickupLocation: 'No 27, Suwarapola, Piliyandala',
            dropoffLocation: 'University of Colombo School of Computing',
            pickupTime:
                DateTime.now().add(const Duration(hours: 3, minutes: 15)),
            dropoffTime:
                DateTime.now().add(const Duration(hours: 3, minutes: 45)),
            totalDistance: 10,
            rideFare: 1500,
            requestedOn: DateTime.now().subtract(const Duration(hours: 1)),
            rider: User(
              firstName: 'Yadeesha',
              lastName: 'Weerasinghe',
              gender: 'female',
              email: 'yadeesha@gmail.com',
              stars: 4.2,
              totalRatings: 250,
            ),
          ),
          RideRequest(
            id: '1',
            rideID: '00001',
            pickupLocation: 'No 27, Suwarapola, Piliyandala',
            dropoffLocation: 'University of Colombo School of Computing',
            pickupTime:
                DateTime.now().add(const Duration(hours: 3, minutes: 15)),
            dropoffTime:
                DateTime.now().add(const Duration(hours: 3, minutes: 45)),
            totalDistance: 10,
            rideFare: 1500,
            requestedOn: DateTime.now().subtract(const Duration(hours: 1)),
            rider: User(
              firstName: 'Nethmi',
              lastName: 'pathirana',
              gender: 'female',
              email: 'yadeesha@gmail.com',
              stars: 4.5,
              totalRatings: 250,
            ),
          ),
        ]);

    return SingleChildScrollView(
      child: Column(
        children: [
          upcomingRideRequest != null
              ? RideRequestCard(upcomingRideRequest, upcomingRideOffer)
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
