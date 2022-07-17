import 'dart:convert';
import 'package:http/http.dart' as http;

Future<http.Response> login(String email, pass) async {
  Map data = {
    'email': email,
    'password': pass,
  };

  String body = json.encode(data);
  var url = Uri.parse('http://localhost:5000/api/auth/login');
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
