import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mobile/models/user_model.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../constants/constants.dart' as constants;

final baseURL = '${dotenv.env['API_URL']}/api/auth';

Future<http.Response> register(
    String email, String pass, String confirmPassword) async {
  Map data = {
    'email': email,
    'password': pass,
    'confirmPassword': confirmPassword,
  };

  String body = json.encode(data);
  final url = Uri.parse('$baseURL/verify-credentials');
  final response = await http.post(
    url,
    body: body,
    headers: constants.header,
  );

  return response;
}

Future<http.Response> checkEmailOTP(String otp, String email) async {
  Map data = {'email': email, 'otp': otp};

  String body = json.encode(data);
  final url = Uri.parse('$baseURL/verify-email-otp');
  final response = await http.post(
    url,
    body: body,
    headers: constants.header,
  );
  return response;
}

Future<http.Response> checkSMSOTP(
    String otp, String mobile, String email) async {
  Map data = {'otp': otp, 'email': email, 'mobile': mobile};

  String body = json.encode(data);
  final url = Uri.parse('$baseURL/verify-sms-otp');
  final response = await http.post(
    url,
    body: body,
    headers: constants.header,
  );
  return response;
}

Future<http.Response> submitPhoneNumber(String number, String email) async {
  Map data = {'mobile': number, 'email': email};

  String body = json.encode(data);
  final url = Uri.parse('$baseURL/verify-mobile-num');
  final response = await http.post(
    url,
    body: body,
    headers: constants.header,
  );
  return response;
}

Future<http.Response> submitPersonalDetails(
    String fname, String lname, String gender, String email) async {
  User user =
      User(firstName: fname, lastName: lname, gender: gender, email: email);

  String body = userToJson(user);
  final url = Uri.parse('$baseURL/verify-user-info');
  final response = await http.post(
    url,
    body: body,
    headers: constants.header,
  );
  return response;
}
