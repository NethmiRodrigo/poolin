import 'dart:convert';
import 'package:http/http.dart' as http;

Future<http.Response> register(String email, pass, conpass) async {
  Map data = {
    'email': email,
    'password': pass,
    'confirmPassword': conpass,
  };
  print(data);

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
  print(response.body);
  print(response.statusCode);
  return response;
}

checkOTP(String otp) async {
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
  print(response.body);
  print(response.statusCode);
  if (response.statusCode == 200) {
    //Or put here your next screen using Navigator.push() method
    print('success');
  } else {
    print('error');
  }
}
