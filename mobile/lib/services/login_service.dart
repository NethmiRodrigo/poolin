import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:dio/dio.dart';

import 'package:poolin/services/interceptor/dio_service.dart';
import 'package:poolin/services/interceptor/save_cookie.dart';

final baseURL = '${dotenv.env['API_URL']}/api/auth/';

final dio = DioService.getService();

Future<Response> login(String email, pass) async {
  Map data = {
    'email': email,
    'password': pass,
  };

  dio.options.baseUrl = baseURL;

  final response = await dio.post('/login', data: data);

  final cookies = response.headers.map['set-cookie'];
  if (cookies!.isNotEmpty) {
    final authToken = cookies[0].split(';')[0].split('=')[1];

    bool result = await saveCookie(authToken);

    if (!result) {
      print('Could not save cookie');
    }
  }

  return response;
}
