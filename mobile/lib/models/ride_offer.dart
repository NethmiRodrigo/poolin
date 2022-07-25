import 'dart:convert';

RideOffer userFromJson(String str) => RideOffer.fromJson(json.decode(str));

String userToJson(RideOffer data) => json.encode(data.toJson());

class RideOffer {
  String id;
  String startLocation;
  String destination;
  String profilePicture = 'https://i.pravatar.cc/300';
  DateTime offeredOn;

  RideOffer({
    required this.id,
    required this.startLocation,
    required this.destination,
    required this.offeredOn,
  });

  factory RideOffer.fromJson(Map<String, dynamic> json) => RideOffer(
        id: json["id"],
        startLocation: json["startLocation"],
        destination: json["destination"],
        offeredOn: DateTime.parse(json["offeredOn"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "startLocation": startLocation,
        "destination": destination,
        "offeredOn": offeredOn,
      };
}
