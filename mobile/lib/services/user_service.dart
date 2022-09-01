import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mobile/services/interceptor/dio_service.dart';

final baseURL = '${dotenv.env['API_URL']}/api/user';

final dio = DioService.getService();

Future<Response> getUser(String id) async {
  dio.options.baseUrl = baseURL;

  final response = await dio.get('/get/$id');

  if (response.statusCode == 200) {
    return response;
  } else {
    throw Exception('Failed to get user');
  }
}
