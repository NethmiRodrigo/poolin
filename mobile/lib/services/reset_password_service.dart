import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

final baseURL = 'http://${dotenv.env['API_URL']}/api/auth/';

Future<http.Response> submitEmail(String email) async {
  Map data = {
    'email': email,
  };

  String body = json.encode(data);
  var url = Uri.parse('$baseURL/send-reset-password-email');
  var response = await http.post(
    url,
    body: body,
    headers: {
      "Content-Type": "application/json",
      "accept": "application/json",
      "Access-Control-Allow-Origin": "*"
    },
  );

  return response;
}

Future<http.Response> checkEmailOTP(String otp, email) async {
  Map data = {'email': email, 'otp': otp};
  print(data);

  String body = json.encode(data);
  var url = Uri.parse('$baseURL/verify-password-otp');
  var response = await http.post(
    url,
    body: body,
    headers: {
      "Content-Type": "application/json",
      "accept": "application/json",
      "Access-Control-Allow-Origin": "*"
    },
  );
  return response;
}

Future<http.Response> resetPassword(email, pass, conpass, otp) async {
  Map data = {
    'email': email,
    'password': pass,
    'confirmPassword': conpass,
    'otp': otp,
  };

  String body = json.encode(data);
  var url = Uri.parse('$baseURL/reset-password');
  var response = await http.post(
    url,
    body: body,
    headers: {
      "Content-Type": "application/json",
      "accept": "application/json",
      "Access-Control-Allow-Origin": "*"
    },
  );

  return response;
}
