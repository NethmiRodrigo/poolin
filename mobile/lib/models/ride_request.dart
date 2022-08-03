import 'dart:convert';

import 'package:mobile/models/request_status_type.dart';
import 'package:mobile/models/ride_type_model.dart';

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
  String userID;
  String rideID;

  RideRequest({
    required this.id,
    required this.pickupLocation,
    required this.dropoffLocation,
    required this.requestedOn,
    this.status = StatusType.pending,
    DateTime? pickupTime,
    DateTime? dropoffTime,
    this.userID = '',
    this.rideID = '',
  })  : this.pickupTime = pickupTime ?? DateTime.now(),
        this.dropoffTime = dropoffTime ?? DateTime.now();

  factory RideRequest.fromJson(Map<String, dynamic> json) => RideRequest(
        id: json["id"],
        status: json["status"],
        pickupLocation: json["startLocation"],
        dropoffLocation: json["destination"],
        requestedOn: DateTime.parse(json["requestedOn"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "startLocation": pickupLocation,
        "destination": dropoffLocation,
        "requestedOn": requestedOn,
      };
}
