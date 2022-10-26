import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:poolin/cubits/active_ride_cubit.dart';
import 'package:poolin/cubits/ride_offer_cubit.dart';
import 'package:poolin/models/coordinate_model.dart';
import 'package:poolin/models/ride_role_type.dart';
import 'package:poolin/services/interceptor/dio_service.dart';

final baseURL = '${dotenv.env['API_URL']}/api/ride';

final dio = DioService.getService();

Future<Response> postOffer(RideOffer rideOffer) async {
  Map data = {
    'src': {
      'lat': rideOffer.source.lat,
      'long': rideOffer.source.lang,
      'name': rideOffer.source.name,
    },
    'dest': {
      'lat': rideOffer.destination.lat,
      'long': rideOffer.destination.lang,
      'name': rideOffer.destination.name,
    },
    'distance': rideOffer.distance,
    'seats': rideOffer.seatCount,
    'startTime': rideOffer.startTime.toString(),
    'endTime': rideOffer.startTime
        .add(Duration(minutes: rideOffer.duration))
        .toString(),
  };

  dio.options.baseUrl = baseURL;

  final response = await dio.post('/create-offer', data: data);

  return response;
}

Future<Response> getActiveOffer() async {
  dio.options.baseUrl = baseURL;

  final response = await dio.get('/offer');

  return response;
}

Future<Response> getOfferRequests(int id) async {
  dio.options.baseUrl = baseURL;

  final response = await dio.get('/get/offer/requests/$id');

  return response;
}

Future<List<RideParticipant>> getConfirmedRequests(int id) async {
  dio.options.baseUrl = baseURL;
  List<RideParticipant> partyData = [];

  final response = await dio.get('/get/offer/party/$id');

  if (response.data['requests'].length > 0) {
    for (var req in response.data['requests']) {
      partyData.add(
        RideParticipant(
          id: req['user_id'],
          role: RideRole.rider,
          firstname: req['firstname'],
          lastname: req['lastname'],
          price: double.parse(req['price']),
          pickupTime: DateTime.parse(req['pickupTime']),
          pickupLocation: Coordinate(
            name: req['pickup']['name'],
            lat: req['pickup']['coordinates'][0],
            lang: req['pickup']['coordinates'][1],
          ),
          dropoffLocation: Coordinate(
            name: req['dropoff']['name'],
            lat: req['dropoff']['coordinates'][0],
            lang: req['dropoff']['coordinates'][1],
          ),
          avatar:
              req['avatar'] ?? 'https://i.ibb.co/qgVMXFS/profile-icon-9.png',
        ),
      );
    }
  }
  return partyData;
}

Future<Response> getRequestDetails(int id) async {
  dio.options.baseUrl = baseURL;

  final response = await dio.get('/get/request/$id');

  return response;
}
