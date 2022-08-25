import 'dart:convert';

import 'package:mobile/models/request_status_type.dart';
import 'package:mobile/models/ride_type_model.dart';
import 'package:mobile/models/user_model.dart';

RideRequest userFromJson(String str) => RideRequest.fromJson(json.decode(str));

String userToJson(RideRequest data) => json.encode(data.toJson());

class RideRequest {
  String id;
  RideType type = RideType.request;
  StatusType status;
  String pickupLocation;
  String dropoffLocation;
  String profilePicture = 'https://i.pravatar.cc/300';
  DateTime requestedOn;
  DateTime pickupTime;
  DateTime dropoffTime;
  double totalDistance;
  double rideFare;
  User driver;
  String rideID;

  RideRequest({
    required this.id,
    required this.rideID,
    required this.driver,
    required this.pickupLocation,
    required this.dropoffLocation,
    required this.requestedOn,
    this.status = StatusType.pending,
    this.totalDistance = 0.0,
    this.rideFare = 0.00,
    DateTime? pickupTime,
    DateTime? dropoffTime,
  })  : pickupTime = pickupTime ?? DateTime.now(),
        dropoffTime = dropoffTime ?? DateTime.now();

  factory RideRequest.fromJson(Map<String, dynamic> json) => RideRequest(
        id: json["id"],
        rideID: json["rideID"],
        driver: json["rider"],
        status: json["status"],
        pickupLocation: json["startLocation"],
        dropoffLocation: json["destination"],
        requestedOn: DateTime.parse(json["requestedOn"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "rideID": rideID,
        "rider": driver,
        "startLocation": pickupLocation,
        "destination": dropoffLocation,
        "requestedOn": requestedOn,
      };
}
