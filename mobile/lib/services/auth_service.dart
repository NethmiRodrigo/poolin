import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:poolin/services/interceptor/dio_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

void logout() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.remove('cookie');
  await prefs.clear();
}
