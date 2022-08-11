import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:mobile/cubits/ride_offer_cubit.dart';
import 'package:mobile/cubits/ride_request_cubit.dart';
import 'package:mobile/models/coordinate_model.dart';

import '../constants/constants.dart' as constants;
import '../utils/helper_functions.dart';

final baseURL = '${dotenv.env['API_URL']}/api/ride';
final _storage = const FlutterSecureStorage();

Future<http.Response> postRequest(RideRequest rideRequest) async {
  Map data = {
    'src': rideRequest.source,
    'dest': rideRequest.destination,
    'distance': rideRequest.distance,
    'startTime': rideRequest.startTime.toString(),
    'window': rideRequest.window,
    'offers': rideRequest.offers,
    'price': rideRequest.price != 0 ? rideRequest.price : null,
    'duration': rideRequest.duration,
    'email': 'beth@email',
  };

  String body = json.encode(data);
  prettyPrintJson(body);
  var url = Uri.parse('$baseURL/post-requests');
  var response = await http.post(
    url,
    body: body,
    headers: constants.header,
  );

  return response;
}
