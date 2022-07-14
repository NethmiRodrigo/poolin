import 'dart:convert';
import 'package:http/http.dart' as http;

Future<http.Response> ForgotPasswordSubmitEmail(String email) async {
  Map data = {
    'email': email,
  };

  String body = json.encode(data);
  var url =
      Uri.parse('http://localhost:5000/api/auth/send-reset-password-email');
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
  var url = Uri.parse('http://localhost:5000/api/auth/verify-password-otp');
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

Future<http.Response> ResendOTP(email) async {
  Map data = {
    'email': email,
  };

  String body = json.encode(data);
  var url = Uri.parse('http://localhost:5000/api/auth/resend-email-otp');
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

Future<http.Response> ResetPassword(email, pass, conpass, otp) async {
  Map data = {
    'email': email,
    'password': pass,
    'confirmPassword': conpass,
    'otp': otp,
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
