import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mobile/cubits/ride_request_cubit.dart';
import 'package:mobile/models/coordinate_model.dart';
import 'package:mobile/models/ride_offer_search_result.dart';
import 'package:mobile/models/user_model.dart';
import 'package:mobile/models/vehicle_type.dart';
import 'package:mobile/services/interceptor/dio_service.dart';

final baseURL = '${dotenv.env['API_URL']}/api/ride';
const _storage = FlutterSecureStorage();

final dio = DioService.getService();

Future<Response> postRequest(RideRequest rideRequest, String userID) async {
  Map data = {
    'userID': userID,
    'src': rideRequest.source,
    'dest': rideRequest.destination,
    'distance': rideRequest.distance,
    'startTime': rideRequest.startTime.toString(),
    'window': rideRequest.window,
    'offers': rideRequest.offerIDs,
    'price': rideRequest.price != 0 ? rideRequest.price : null,
    'duration': rideRequest.duration,
  };

  dio.options.baseUrl = baseURL;

  final response = await dio.post('/post-requests', data: data);

  return response;
}

Future<Response> getActiveRequest() async {
  dio.options.baseUrl = baseURL;

  final response = await dio.get('/get/offer/requests/1');

  return response;
}

Future<Response> getOfferRequests() async {
  dio.options.baseUrl = baseURL;

  final response = await dio.get('/get/offer/requests/1');

  return response;
}

Future<List<RideOfferSearchResult>> getAvailableOffers(
    RideRequest rideRequest) async {
  dio.options.baseUrl = baseURL;

  List<RideOfferSearchResult> rideOffers = [];

  final response = await dio.get(
    '/get/matching-requests',
    queryParameters: {
      'srcLat': rideRequest.source.lat,
      'srcLong': rideRequest.source.lang,
      'destLat': rideRequest.destination.lat,
      'destLong': rideRequest.destination.lang,
      'startTime': rideRequest.startTime,
      'window': rideRequest.window,
    },
  );

  if (response.statusCode == 200) {
    response.data.offers.forEach((offer) {
      rideOffers.add(RideOfferSearchResult(
        id: offer.id,
        startTime: offer.startTime,
        pricePerKM: offer.pricePerKm,
        source: Coordinate(
          lat: offer.source.coordinates[0],
          lang: offer.source.coordinates[1],
          name: offer.source.name,
        ),
        destination: Coordinate(
          lat: offer.destination.coordinates[0],
          lang: offer.destination.coordinates[1],
          name: offer.destination.name,
        ),
        driver: User(
          id: offer.driver.id,
          firstName: offer.driver.firstname,
          lastName: offer.driver.lastname,
          isVerified: offer.driver.isVerified,
          gender: offer.driver.gender,
          email: offer.driver.email,
          stars: offer.driver.stars,
          totalRatings: offer.driver.totalRatings,
          profilePicURL: offer.driver.profileImageUri,
          bio: offer.driver.bio,
          occupation: offer.driver.occupation,
          vehicleType: offer.driver.vehicleType == 'na'
              ? VehicleType.na
              : offer.driver.vehicleType == 'car'
                  ? VehicleType.car
                  : offer.driver.vehicleType == 'van'
                      ? VehicleType.van
                      : VehicleType.bike,
          vehicleModel: offer.driver.vehicleModel,
        ),
      ));
    });
  }

  return rideOffers;
}
