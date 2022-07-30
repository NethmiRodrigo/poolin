import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:mobile/models/coordinate_model.dart';

import '../constants/constants.dart' as constants;

final baseURL = '${dotenv.env['API_URL']}/api/ride/';

Future<http.Response> postOffer(
    Coordinate source,
    Coordinate destination,
    int duration,
    int seatCount,
    int distance,
    DateTime startTime,
    int ppkm) async {
  Map data = {
    'src': coordinateToJson(source),
    'dest': coordinateToJson(destination),
    'ppkm': ppkm,
    'seats': seatCount,
    'startTime': startTime,
    'endTime': startTime.add(Duration(minutes: duration)),
    'userId': 1,
  };

  String body = json.encode(data);
  var url = Uri.parse('$baseURL/create-offer');
  var response = await http.post(
    url,
    body: body,
    headers: constants.header,
  );

  return response;
}
