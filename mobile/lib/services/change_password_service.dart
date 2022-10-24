import 'dart:convert';
import 'package:http/http.dart' as http;
// import 'package:poolin/models/User.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

final baseURL = 'http://${dotenv.env['API_URL']}/api/user/';

Future<http.Response> changepassword(
    String currentpass, newpass, confirmpass, String? token) async {
  Map data = {
    'currentPassword': currentpass,
    'newPassword': newpass,
    'confirmPassword': confirmpass,
  };

  String body = json.encode(data);
  final url = Uri.parse('$baseURL/change-password');
  final response = await http.post(
    url,
    body: body,
    headers: {
      "Token": token!,
      "Content-Type": "application/json",
      "accept": "application/json",
      "Access-Control-Allow-Origin": "*"
    },
  );

  return response;
}
