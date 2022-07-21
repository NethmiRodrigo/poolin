import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mobile/models/User.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

final baseURL = 'http://${dotenv.env['API_URL']}/api/auth/';

Future<http.Response> changepassword(String currentpass, newpass, confirmpass) async {
  Map data = {
    'currentPassword': currentpass,
    'newPassword': newpass,
    'confirmPassword': confirmpass,
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

