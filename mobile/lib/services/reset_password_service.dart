import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

import '../constants/constants.dart' as constants;

final baseURL = '${dotenv.env['API_URL']}/api/auth/';

Future<http.Response> submitEmail(String email) async {
  Map data = {
    'email': email,
  };

  String body = json.encode(data);
  var url = Uri.parse('$baseURL/send-reset-password-email');
  var response = await http.post(
    url,
    body: body,
    headers: constants.header,
  );

  return response;
}

Future<http.Response> checkEmailOTP(String otp, String email) async {
  Map data = {'email': email, 'otp': otp};

  String body = json.encode(data);
  var url = Uri.parse('$baseURL/verify-password-otp');
  var response = await http.post(url, body: body, headers: constants.header);
  return response;
}

Future<http.Response> resetPassword(
    String email, String pass, String confirmPass, String otp) async {
  Map data = {
    'email': email,
    'password': pass,
    'confirmPassword': confirmPass,
    'otp': otp,
  };

  String body = json.encode(data);
  var url = Uri.parse('$baseURL/reset-password');
  var response = await http.post(
    url,
    body: body,
    headers: constants.header,
  );

  return response;
}
