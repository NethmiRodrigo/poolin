import 'package:dio/dio.dart';
import 'package:poolin/models/user_model.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:poolin/services/interceptor/dio_service.dart';

final baseURL = '${dotenv.env['API_URL']}/api/auth';

final dio = DioService.getService();

Future<Response> register(
  String email,
  String pass,
  String confirmPassword,
) async {
  Map data = {
    'email': email,
    'password': pass,
    'confirmPassword': confirmPassword,
  };

  dio.options.baseUrl = baseURL;

  final response = await dio.post('/verify-credentials', data: data);
  print(response.data);

  return response;
}

Future<Response> checkEmailOTP(String otp, String email) async {
  Map data = {'email': email, 'otp': otp};

  dio.options.baseUrl = baseURL;

  final response = await dio.post('/verify-email-otp', data: data);

  return response;
}

Future<Response> checkSMSOTP(String otp, String mobile, String email) async {
  Map data = {'otp': otp, 'email': email, 'mobile': mobile};

  dio.options.baseUrl = baseURL;

  final response = await dio.post('/verify-sms-otp', data: data);

  return response;
}

Future<Response> submitPhoneNumber(String number, String email) async {
  Map data = {'mobile': number, 'email': email};

  dio.options.baseUrl = baseURL;

  final response = await dio.post('/verify-mobile-num', data: data);

  print(response.data);

  return response;
}

Future<Response> submitPersonalDetails(
    String fname, String lname, String gender, String email) async {
  User user =
      User(firstName: fname, lastName: lname, gender: gender, email: email);

  dio.options.baseUrl = baseURL;

  final response = await dio.post('/verify-user-info', data: user);

  return response;
}
