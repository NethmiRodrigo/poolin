import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:poolin/models/coordinate_model.dart';

String? apiKey = dotenv.env['MAPS_API_KEY'];
const baseURL =
    'https://maps.googleapis.com/maps/api/distancematrix/json?units=imperial&origins=';

Future<Response> getDistanceAndTime(Coordinate src, Coordinate dest) async {
  Dio dio = Dio();

  Response response = await dio.get(
      "$baseURL${src.lat},${src.lang}&destinations=${dest.lat},${dest.lang}&key=$apiKey");

  return response;
}
