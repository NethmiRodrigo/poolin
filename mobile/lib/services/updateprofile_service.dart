import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

final baseURL = 'http://${dotenv.env['API_URL']}/api/user/';

Future<http.Response> updateprofile(Map data, String? token) async {

  String body = json.encode(data);
  var url = Uri.parse('$baseURL/update-info');
  var response = await http.post(
    url,
    body: body,
    headers: {
      "Token":token!,
      "Content-Type": "application/json",
      "accept": "application/json",
      "Access-Control-Allow-Origin": "*"
    },
  );

  return response;
}




// Future<http.Response> changePhoneNumber(String number, token) async {
//   Map data = {'mobile': number, 'TOKEN':token};

//   String body = json.encode(data);
//   final url = Uri.parse('$baseURL/change-phone-number');
//   final response = await http.post(
//     url,
//     body: body,
//     headers: {
//       "Token":token!,
//       "Content-Type": "application/json",
//       "accept": "application/json",
//       "Access-Control-Allow-Origin": "*"
//     },
//   );
//   return response;
// }

Future<http.Response> editcheckSMSOTP(
    String otp, String? token) async {
  Map data = {'otp': otp, 'TOKEN': token};

  String body = json.encode(data);
  final url = Uri.parse('$baseURL/verify-updated-mobile');
  final response = await http.post(
    url,
    body: body,
    headers: {
      "Token":token!,
      "Content-Type": "application/json",
      "accept": "application/json",
      "Access-Control-Allow-Origin": "*"
    },
  );
  return response;
}
/////////////////////////////////////////////////////////////////




