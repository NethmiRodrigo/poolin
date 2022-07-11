import 'dart:convert';
import 'package:http/http.dart' as http;

register(String email, contact, pass, conpass) async {
  Map data = {
    'Email': email,
    'Mobile': contact,
    'Password': pass,
    'RetypePassword': conpass,
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
