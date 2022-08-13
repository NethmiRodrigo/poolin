import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:mobile/cubits/ride_offer_cubit.dart';
import 'package:mobile/models/coordinate_model.dart';

import '../constants/constants.dart' as constants;
import '../utils/helper_functions.dart';

final baseURL = '${dotenv.env['API_URL']}/api/ride';
final _storage = const FlutterSecureStorage();

Future<http.Response> postOffer(RideOffer rideOffer) async {
  Map data = {
    'src': rideOffer.source,
    'dest': rideOffer.destination,
    'ppkm': rideOffer.ppkm,
    'distance': rideOffer.distance,
    'seats': rideOffer.seatCount,
    'startTime': rideOffer.startTime.toString(),
    'endTime': rideOffer.startTime
        .add(Duration(minutes: rideOffer.duration))
        .toString(),
    'userId': 1,
  };

  String body = json.encode(data);
  prettyPrintJson(body);
  var url = Uri.parse('$baseURL/create-offer');
  var response = await http.post(
    url,
    body: body,
    headers: constants.header,
  );

  return response;
}

Future<http.Response> getActiveOffer() async {
  var url = Uri.parse('$baseURL/get/offer/requests/1');
  var response = await http.get(
    url,
    headers: constants.header,
  );

  return response;
}

Future<http.Response> getOfferRequests() async {
  var url = Uri.parse('$baseURL/get/offer/requests/1');
  var response = await http.get(
    url,
    headers: constants.header,
  );

  return response;
}

Future<http.Response> getConfirmedRequests() async {
  var url = Uri.parse('$baseURL/get/offer/party/1');
  var response = await http.get(
    url,
    headers: constants.header,
  );

  return response;
}
