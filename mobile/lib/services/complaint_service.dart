import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:poolin/services/interceptor/dio_service.dart';

final baseURL = '${dotenv.env['API_URL']}/api/complaints';

final dio = DioService.getService();

Future<Response> reportUser(
  String description,
  int userId,
  int rideId,
  int complaineeId,
) async {
  Map data = {
    'complaint': description,
    'complaintByUserId': userId,
    'complaintForUserId': complaineeId,
    'tripId': rideId,
  };

  dio.options.baseUrl = baseURL;

  final response = await dio.post('/report-user', data: data);

  return response;
}
