import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:poolin/services/interceptor/dio_service.dart';

final baseURL = '${dotenv.env['API_URL']}/api/rate';

final dio = DioService.getService();

Future<Response> rateUser(
  double rating,
  int userId,
  int rideId,
  String role,
  int rateeId,
) async {
  Map data = {
    'rating': rating,
    'ratingBy': userId,
    'ratingFor': rateeId,
    'tripId': rideId,
    'role': role,
  };

  dio.options.baseUrl = baseURL;

  final response = await dio.post('/rate-user', data: data);

  return response;
}
