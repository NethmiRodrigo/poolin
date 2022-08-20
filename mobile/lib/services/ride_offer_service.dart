import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mobile/cubits/ride_offer_cubit.dart';
import 'package:mobile/services/interceptor/dio_service.dart';

final baseURL = '${dotenv.env['API_URL']}/api/ride';

final dio = DioService.getService();

const _storage = FlutterSecureStorage();

Future<Response> postOffer(RideOffer rideOffer) async {
  String? email = await _storage.read(key: 'KEY_EMAIL');

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
    'email': email,
    'ppkm': rideOffer.ppkm,
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

Future<Response> getConfirmedRequests(int id) async {
  dio.options.baseUrl = baseURL;

  final response = await dio.get('/get/offer/party/$id');

  return response;
}
