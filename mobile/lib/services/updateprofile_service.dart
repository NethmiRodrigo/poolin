import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

final baseURL = 'http://${dotenv.env['API_URL']}/api/user/';

Future<http.Response> editfullname(Map data, String? token) async {

  String body = json.encode(data);
  var url = Uri.parse('$baseURL/update-info');
  var response = await http.post(
    url,
    body: body,
    headers: {
      //Token here
      "Content-Type": "application/json",
      "accept": "application/json",
      "Access-Control-Allow-Origin": "*"
    },
  );

  return response;
}

Future<http.Response> editbio(String bio, String? token) async {
  Map data = {
    'bio': bio,
    'TOKEN': token
  };

  String body = json.encode(data);
  var url = Uri.parse('$baseURL/update-info');
  var response = await http.post(
    url,
    body: body,
    headers: {
      //TOKEN
      "Content-Type": "application/json",
      "accept": "application/json",
      "Access-Control-Allow-Origin": "*"
    },
  );

  return response;
}

Future<http.Response> editoccupation(String occupation) async {
  Map data = {
    'occupation': occupation,
  };

  String body = json.encode(data);
  var url = Uri.parse('$baseURL/edit-occupation');
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

//Persional Information
Future<http.Response> editgender( String gender, String? token) async {
  Map data = {'gender': gender,'TOKEN':token};

  String body = json.encode(data);
  final url = Uri.parse('$baseURL/update-info');
  final response = await http.post(
    url,
    body: body,
    headers: {
      //token
      "Content-Type": "application/json",
      "accept": "application/json",
      "Access-Control-Allow-Origin": "*"
    },
  );
  return response;
}


Future<http.Response> changePhoneNumber(String number, token) async {
  Map data = {'mobile': number, 'TOKEN':token};

  String body = json.encode(data);
  final url = Uri.parse('$baseURL/change-phone-number');
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

Future<http.Response> editcheckSMSOTP(
    String otp, String mobile, String? token) async {
  Map data = {'otp': otp, 'TOKEN': token, 'mobile': mobile};

  String body = json.encode(data);
  final url = Uri.parse('$baseURL/verify-updated-mobile');
  final response = await http.post(
    url,
    body: body,
    headers: {
      "Token":"eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjp7ImlkIjoxLCJlbWFpbCI6InRlc3Q4QHN0dS51Y3NjLmNtYi5hYy5sayIsIm1vYmlsZSI6Iis5NDcxMzI4NDU2MCIsImZpcnN0bmFtZSI6IkltZXNoIiwibGFzdG5hbWUiOiJVZGFyYSIsImdlbmRlciI6Im1hbGUiLCJwYXNzd29yZCI6IiQyYiQwOCRRNXYwZjlGZVZKWG11OWZYdi45N00uVElCMjc0Z3B5akZ2bWg0cTBZMnA3SXlZYzguL25CTyIsImNyZWF0ZWRBdCI6IjIwMjItMDctMjZUMTY6MDY6MjQuNjgxWiIsInVwZGF0ZWRBdCI6IjIwMjItMDctMjZUMTY6MDc6MTQuMjUzWiJ9LCJpYXQiOjE2NTg4NTE2Nzh9.jodN1T6uDzbLo3MLsLHGabQ-cuZxOE1fOCAKaQaSMAk",
      "Content-Type": "application/json",
      "accept": "application/json",
      "Access-Control-Allow-Origin": "*"
    },
  );
  return response;
}
/////////////////////////////////////////////////////////////////
Future<http.Response> editdateofbirth(String date) async {
  Map data = {'date': date};

  String body = json.encode(data);
  final url = Uri.parse('$baseURL/edit-date-of-birth');
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



