import 'dart:convert';

import 'package:mobile/models/ride_type_model.dart';

RideOffer userFromJson(String str) => RideOffer.fromJson(json.decode(str));

String userToJson(RideOffer data) => json.encode(data.toJson());

class RideOffer {
  String id;
  RideType type = RideType.offer;
  String startLocation;
  String destination;
  String profilePicture = 'https://i.pravatar.cc/300';
  double totalDistance;
  double totalCharge;
  DateTime rideDate;
  DateTime offeredOn;
  DateTime estimatedArrivalTime;

  RideOffer({
    required this.id,
    required this.startLocation,
    required this.destination,
    required this.rideDate,
    required this.offeredOn,
    required this.estimatedArrivalTime,
    this.totalDistance = 0.0,
    this.totalCharge = 0.0,
  });

  factory RideOffer.fromJson(Map<String, dynamic> json) => RideOffer(
        id: json["id"],
        startLocation: json["startLocation"],
        destination: json["destination"],
        offeredOn: DateTime.parse(json["offeredOn"]),
        rideDate: DateTime.parse(json["offeredOn"]),
        estimatedArrivalTime: DateTime.parse(json["offeredOn"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "startLocation": startLocation,
        "destination": destination,
        "offeredOn": offeredOn,
        "rideDate": rideDate,
        "estimatedArrivalTime": estimatedArrivalTime,
      };
}
