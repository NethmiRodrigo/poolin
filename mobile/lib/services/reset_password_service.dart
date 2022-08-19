import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'interceptor/dio_service.dart';

final baseURL = '${dotenv.env['API_URL']}/api/auth/';

final dio = DioService.getService();

Future<Response> submitEmail(String email) async {
  Map data = {
    'email': email,
  };

  dio.options.baseUrl = baseURL;

  final response = await dio.post('/send-reset-password-email', data: data);

  return response;
}

Future<Response> checkEmailOTP(String otp, String email) async {
  Map data = {'email': email, 'otp': otp};

  dio.options.baseUrl = baseURL;

  final response = await dio.post('/verify-password-otp', data: data);

  return response;
}

Future<Response> resetPassword(
    String email, String pass, String confirmPass, String otp) async {
  Map data = {
    'email': email,
    'password': pass,
    'confirmPassword': confirmPass,
    'otp': otp,
  };

  dio.options.baseUrl = baseURL;

  final response = await dio.post('/reset-password', data: data);

  return response;
}
