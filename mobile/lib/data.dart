import 'package:mobile/models/ride_offer.dart';
import 'package:mobile/models/ride_request.dart';
import 'package:mobile/models/user_model.dart';
import 'package:mobile/models/vehicle_type.dart';

class TestData {
  static RideRequest testRideRequest = RideRequest(
      id: '1',
      rideID: '00001',
      pickupLocation: 'University of Colombo School of Computing',
      dropoffLocation: 'Fort Railway station',
      pickupTime: DateTime.now().add(const Duration(hours: 3, minutes: 15)),
      dropoffTime: DateTime.now().add(const Duration(hours: 3, minutes: 45)),
      totalDistance: 10,
      rideFare: 1500,
      requestedOn: DateTime.now().subtract(const Duration(hours: 1)),
      driver: User(
          firstName: 'Yadeesha',
          lastName: 'Weerasinghe',
          gender: 'female',
          email: 'yadeesha@gmail.com',
          stars: 4.5,
          totalRatings: 250,
          VehicleNum: 'ABC0988',
          vehicleType: VehicleType.car),
      profilePicture: 'https://i.pravatar.cc/300?img=1');

  static RideOffer testRideOffer = RideOffer(
      id: '00001',
      startLocation: 'University of Colombo School of Computing',
      destination: 'Fort Police station',
      rideDate: DateTime.now().add(const Duration(days: 1, hours: 3)),
      offeredOn: DateTime.now().subtract(const Duration(days: 3, hours: 1)),
      estimatedArrivalTime: DateTime.now(),
      totalDistance: 10,
      totalEarnings: 2500,
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
            driver: User(
              firstName: 'Yadeesha',
              lastName: 'Weerasinghe',
              gender: 'female',
              email: 'yadeesha@gmail.com',
              stars: 4.2,
              totalRatings: 250,
            ),
            profilePicture: 'https://i.pravatar.cc/300?img=1'),
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
            driver: User(
              firstName: 'Nethmi',
              lastName: 'pathirana',
              gender: 'female',
              email: 'yadeesha@gmail.com',
              stars: 4.5,
              totalRatings: 250,
            ),
            profilePicture: 'https://i.pravatar.cc/300?img=1'),
      ]);

  static List<RideRequest> testRideRequestsList = [
    testRideRequest,
    testRideRequest,
    testRideRequest,
  ];

  static List<RideOffer> testRideOffersList = [
    testRideOffer,
    testRideOffer,
    testRideOffer,
  ];
}
