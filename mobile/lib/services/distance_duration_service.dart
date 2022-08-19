import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:poolin/models/coordinate_model.dart';

import '../constants/constants.dart' as constants;

String? apiKey = dotenv.env['MAPS_API_KEY'];
const baseURL =
    'https://maps.googleapis.com/maps/api/distancematrix/json?units=imperial&origins=';

Future<Response> getDistanceAndTime(Coordinate src, Coordinate dest) async {
  // var url = Uri.parse(
  //     "$baseURL${src.lat},${src.lang}&destinations=${dest.lat},${dest.lang}&key=$apiKey");
  // print(url);
  // var response = await http.get(url);

  Dio dio = Dio();

  Response response = await dio.get(
      "$baseURL${src.lat},${src.lang}&destinations=${dest.lat},${dest.lang}&key=$apiKey");

  return response;
}
