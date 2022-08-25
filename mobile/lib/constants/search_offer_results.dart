import 'package:mobile/models/coordinate_model.dart';
import 'package:mobile/models/ride_offer_search_result.dart';
import 'package:mobile/models/user_model.dart';
import 'package:mobile/models/vehicle_type.dart';

List<RideOfferSearchResult> results = [
  RideOfferSearchResult(
    id: '1',
    pricePerKM: 250,
    source: Coordinate(
      lat: 6.8020479945843455,
      lang: 79.92257819476119,
      name: 'Piliyandala',
    ),
    destination: Coordinate(
      lat: 6.86731844231596,
      lang: 79.89928252668591,
      name: 'Nugegoda',
    ),
    startTime: DateTime.now().add(const Duration(days: 1)),
    driver: User(
      email: 'yadee@gmail.com',
      firstName: 'Yadeesha',
      lastName: 'Weerasinghe',
      gender: 'female',
      stars: 4.5,
      totalRatings: 158,
      profilePicURL: 'https://i.pravatar.cc/300?img=2',
      vehicleType: VehicleType.car,
      vehicleModel: 'Lexus Primio',
    ),
  ),
  RideOfferSearchResult(
    id: '2',
    pricePerKM: 1500,
    source: Coordinate(
      lat: 6.902217985155494,
      lang: 79.86108014056458,
      name: 'University of Colombo School of Computing',
    ),
    destination: Coordinate(
      lat: 6.916745836053613,
      lang: 79.86378380712223,
      name: 'Town Hall',
    ),
    startTime: DateTime.now().add(const Duration(days: 5, hours: 2)),
    driver: User(
        email: 'yadee@gmail.com',
        firstName: 'Yadeesha',
        lastName: 'Weerasinghe',
        gender: 'female',
        stars: 4.5,
        totalRatings: 158,
        profilePicURL: 'https://i.pravatar.cc/300?img=1',
        vehicleModel: 'Nissan Sedan'),
  ),
  RideOfferSearchResult(
    id: '3',
    pricePerKM: 2500,
    source: Coordinate(
      lat: 6.03297517570785,
      lang: 80.21389450600029,
      name: 'Galle Dutch Fort',
    ),
    destination: Coordinate(
      lat: 6.889915422473051,
      lang: 79.86507860472133,
      name: 'Trend Tower',
    ),
    startTime: DateTime.now().add(const Duration(hours: 18)),
    driver: User(
      email: 'azma@gmail.com',
      firstName: 'Azma',
      lastName: 'Imtiaz',
      gender: 'female',
      stars: 4.5,
      totalRatings: 158,
      profilePicURL: 'https://i.pravatar.cc/300?img=5',
      vehicleModel: 'Toyota Premium',
    ),
  ),
  RideOfferSearchResult(
    id: '4',
    pricePerKM: 500,
    source: Coordinate(
      lat: 0.0,
      lang: 0.0,
      name: 'University of Colombo School of Computing',
    ),
    destination: Coordinate(
      lat: 0.0,
      lang: 0.0,
      name: 'Town Hall',
    ),
    startTime: DateTime.now().add(const Duration(days: 1)),
    driver: User(
      email: 'yadee@gmail.com',
      firstName: 'Yadeesha',
      lastName: 'Weerasinghe',
      gender: 'female',
      stars: 4.5,
      totalRatings: 158,
      profilePicURL: 'https://i.pravatar.cc/300?img=8',
      vehicleModel: 'Nissan Sedan',
    ),
  ),
  RideOfferSearchResult(
    id: '5',
    pricePerKM: 2500,
    source: Coordinate(
      lat: 0.0,
      lang: 0.0,
      name: 'University of Colombo School of Computing',
    ),
    destination: Coordinate(
      lat: 0.0,
      lang: 0.0,
      name: 'Town Hall',
    ),
    startTime: DateTime.now().add(const Duration(days: 1)),
    driver: User(
      email: 'yadee@gmail.com',
      firstName: 'Yadeesha',
      lastName: 'Weerasinghe',
      gender: 'female',
      stars: 4.5,
      totalRatings: 158,
      profilePicURL: 'https://i.pravatar.cc/300?img=1',
    ),
  ),
  RideOfferSearchResult(
    id: '6',
    pricePerKM: 5200,
    source: Coordinate(
      lat: 0.0,
      lang: 0.0,
      name: 'University of Colombo School of Computing',
    ),
    destination: Coordinate(
      lat: 0.0,
      lang: 0.0,
      name: 'Town Hall',
    ),
    startTime: DateTime.now().add(const Duration(days: 1)),
    driver: User(
      email: 'yadee@gmail.com',
      firstName: 'Yadeesha',
      lastName: 'Weerasinghe',
      gender: 'female',
      stars: 4.5,
      totalRatings: 158,
      profilePicURL: 'https://i.pravatar.cc/300?img=1',
    ),
  ),
];
