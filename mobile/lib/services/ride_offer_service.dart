import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:mobile/cubits/ride_offer_cubit.dart';
import 'package:mobile/models/coordinate_model.dart';

import '../constants/constants.dart' as constants;

final baseURL = '${dotenv.env['API_URL']}/api/ride/';

Future<http.Response> postOffer(RideOffer rideOffer) async {
  Map data = {
    'src': coordinateToJson(rideOffer.source),
    'dest': coordinateToJson(rideOffer.destination),
    'ppkm': rideOffer.ppkm,
    'seats': rideOffer.seatCount,
    'startTime': rideOffer.startTime,
    'endTime': rideOffer.startTime.add(Duration(minutes: rideOffer.duration)),
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
