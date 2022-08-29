import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mobile/cubits/ride_request_cubit.dart';
import 'package:mobile/services/interceptor/dio_service.dart';

final baseURL = '${dotenv.env['API_URL']}/api/ride';
const _storage = FlutterSecureStorage();

final dio = DioService.getService();

Future<Response> postRequest(RideRequest rideRequest) async {
  String? email = await _storage.read(key: 'KEY_EMAIL');

  Map data = {
    'src': rideRequest.source,
    'dest': rideRequest.destination,
    'distance': rideRequest.distance,
    'startTime': rideRequest.startTime.toString(),
    'window': rideRequest.window,
    'offers': rideRequest.offerIDs,
    'price': rideRequest.price != 0 ? rideRequest.price : null,
    'duration': rideRequest.duration,
    'email': 'beth@email',
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
