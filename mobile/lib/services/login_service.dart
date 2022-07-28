import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

import '../constants/constants.dart' as constants;

final baseURL = '${dotenv.env['API_URL']}/api/auth/';

Future<http.Response> login(String email, pass) async {
  Map data = {
    'email': email,
    'password': pass,
  };

  String body = json.encode(data);
  var url = Uri.parse('$baseURL/login');
  var response = await http.post(
    url,
    body: body,
    headers: constants.header,
  );

  return response;
}
