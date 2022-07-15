import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mobile/models/User.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

final baseURL = 'http://${dotenv.env['API_URL']}/api/auth/';

Future<http.Response> register(String email, pass, conpass) async {
  Map data = {
    'email': email,
    'password': pass,
    'confirmPassword': conpass,
  };

  String body = json.encode(data);
  final url = Uri.parse('$baseURL/verify-credentials');
  final response = await http.post(
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

  String body = json.encode(data);
  final url = Uri.parse('$baseURL/verify-email-otp');
  final response = await http.post(
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

Future<http.Response> checkSMSOTP(String otp, mobile, email) async {
  Map data = {'otp': otp, 'email': otp, 'mobile': otp};

  String body = json.encode(data);
  final url = Uri.parse('$baseURL/verify-sms-otp');
  final response = await http.post(
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

Future<http.Response> submitPhoneNumber(String number, email) async {
  Map data = {'mobile': number, 'email': email};

  String body = json.encode(data);
  final url = Uri.parse('$baseURL/verify-mobile-num');
  final response = await http.post(
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

Future<http.Response> submitPersonalDetails(
    String fname, lname, gender, email) async {
  User user =
      User(firstName: fname, lastName: lname, gender: gender, email: email);

  String body = userToJson(user);
  final url = Uri.parse('$baseURL/verify-user-info');
  final response = await http.post(
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
