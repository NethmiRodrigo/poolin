import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:poolin/cubits/ride_offer_cubit.dart';
import 'package:poolin/services/interceptor/dio_service.dart';

final baseURL = '${dotenv.env['API_URL']}/api/ride';
const _storage = FlutterSecureStorage();

final dio = DioService.getService();

Future<Response> postRequest(RideOffer rideOffer) async {
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

Future<Response> acceptRequest(offerId, requestId) async {
  dio.options.baseUrl = baseURL;

  Map data = {'offer': offerId, 'request': requestId};

  final response = await dio.post('/request/accept', data: data);

  return response;
}
