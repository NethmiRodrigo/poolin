import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

final baseURL = 'http://${dotenv.env['API_URL']}/api/auth/';



Future<http.Response> updateprofile(Map data, String? token) async {

  String body = json.encode(data);
  var url = Uri.parse('$baseURL/me');
  var response = await http.get(
    url,
    headers: {
      "Token":token!,
      "Content-Type": "application/json",
      "accept": "application/json",
      "Access-Control-Allow-Origin": "*"
    },
  );

  return response;
}






