import 'dart:convert';

RideRequest userFromJson(String str) => RideRequest.fromJson(json.decode(str));

String userToJson(RideRequest data) => json.encode(data.toJson());

class RideRequest {
  String id;
  String startLocation;
  String destination;
  String profilePicture = 'https://i.pravatar.cc/300';
  DateTime requestedOn;

  RideRequest({
    required this.id,
    required this.startLocation,
    required this.destination,
    required this.requestedOn,
  });

  factory RideRequest.fromJson(Map<String, dynamic> json) => RideRequest(
        id: json["id"],
        startLocation: json["startLocation"],
        destination: json["destination"],
        requestedOn: DateTime.parse(json["requestedOn"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "startLocation": startLocation,
        "destination": destination,
        "requestedOn": requestedOn,
      };
}
