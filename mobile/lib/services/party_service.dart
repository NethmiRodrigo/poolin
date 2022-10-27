import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:poolin/cubits/matching_rides_cubit.dart';
import 'package:poolin/cubits/ride_request_cubit.dart';
import 'package:poolin/models/coordinate_model.dart';
import 'package:poolin/models/user_model.dart';
import 'package:poolin/services/interceptor/dio_service.dart';

final baseURL = '${dotenv.env['API_URL']}/api/ride';

final dio = DioService.getService();

Future<Response> getParty() async {
  dio.options.baseUrl = baseURL;

  final response = await dio.get('/party');

  return response;
}

Future<Response> getOfferParty(int id) async {
  dio.options.baseUrl = baseURL;

  final response = await dio.get('/get/party/offer/$id');

  return response;
}

Future<Response> getRequestParty(int id) async {
  dio.options.baseUrl = baseURL;

  final response = await dio.get('/get/party/request/$id');

  return response;
}
