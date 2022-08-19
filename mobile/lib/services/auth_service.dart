import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:poolin/services/interceptor/dio_service.dart';

final baseURL = '${dotenv.env['API_URL']}/api/auth';

final dio = DioService.getService();

Future<Response> getCurrentUser() async {
  dio.options.baseUrl = baseURL;

  final response = await dio.get('/me');

  if (response.statusCode == 200) {
    return response;
  } else {
    throw Exception('Failed to get current user');
  }
}
