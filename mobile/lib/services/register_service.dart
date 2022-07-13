import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mobile/models/Person.dart';

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

Future<http.Response> checkOTP(String otp, service) async {
  Map data = {
    'otp': otp,
  };
  print(data);

  String body = json.encode(data);
  var url = Uri.parse('https://example.com/whatsit/create');
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

Future<http.Response> submitPhoneNumber(String number, String email) async {
  Map data = {'mobile': number, 'email': email};
  print(data);

  String body = json.encode(data);
  var url = Uri.parse('https://example.com/whatsit/create');
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

Future<http.Response> submitPersonalDetails(String fname, lname, gender) async {
  Person person = Person(firstName: fname, lastName: lname, gender: gender);

  Map<String, dynamic> body = person.toJson();
  var url = Uri.parse('https://example.com/whatsit/create');
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
