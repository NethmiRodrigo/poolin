import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mobile/models/User.dart';

Future<http.Response> register(String email, pass, conpass) async {
  Map data = {
    'email': email,
    'password': pass,
    'confirmPassword': conpass,
  };

  String body = json.encode(data);
  var url = Uri.parse('http://localhost:5001/api/auth/verify-credentials');
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
  var url = Uri.parse('http://localhost:5001/api/auth/verify-email-otp');
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

Future<http.Response> checkSMSOTP(String otp, mobile, email) async {
  Map data = {'otp': otp, 'email': otp, 'mobile': otp};
  print(data);

  String body = json.encode(data);
  var url = Uri.parse('http://localhost:5001/api/auth/verify-sms-otp');
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

Future<http.Response> submitPhoneNumber(String number, email) async {
  Map data = {'mobile': number, 'email': email};
  print(data);

  String body = json.encode(data);
  var url = Uri.parse('http://localhost:5001/api/auth/verify-mobile-num');
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

Future<http.Response> submitPersonalDetails(
    String fname, lname, gender, email) async {
  User user =
      User(firstName: fname, lastName: lname, gender: gender, email: email);

  Map<String, dynamic> body = user.toJson();
  var url = Uri.parse('http://localhost:5001/api/auth/verify-user-info');
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
