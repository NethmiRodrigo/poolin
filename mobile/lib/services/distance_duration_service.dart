import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:mobile/models/coordinate_model.dart';

import '../constants/constants.dart' as constants;

String? apiKey = dotenv.env['MAPS_API_KEY'];
const baseURL =
    'https://maps.googleapis.com/maps/api/distancematrix/json?units=imperial&origins=';

Future<http.Response> getDistanceAndTime(
    Coordinate src, Coordinate dest) async {
  var url = Uri.parse(
      "$baseURL${src.lat},${src.lang}&destinations=${dest.lat},${dest.lang}&key=$apiKey");
  print(url);
  var response = await http.get(url);

  return response;
}
