import 'dart:convert';

ActiveRideOffer offerFromJson(String str) =>
    ActiveRideOffer.fromJson(json.decode(str));

String offerToJson(ActiveRideOffer data) => json.encode(data.toJson());

class ActiveRideOffer {
  late int id;
  late String source;
  late String destination;
  late DateTime departureTime;
  late DateTime arrivalTime;
  late String status;
  late double distance;
  late int pricePerKm;
  late int seats;

  ActiveRideOffer({
    required this.id,
    required this.source,
    required this.destination,
    required this.departureTime,
    required this.arrivalTime,
    required this.status,
    required this.distance,
    required this.pricePerKm,
    required this.seats,
  });

  factory ActiveRideOffer.fromJson(Map<String, dynamic> json) {
    return ActiveRideOffer(
        id: json["id"],
        source: json["from"],
        destination: json["to"],
        departureTime: DateTime.parse(json["departureTime"]),
        arrivalTime: DateTime.parse(json["arrivalTime"]),
        status: json["status"],
        distance: double.parse(json["distance"]),
        pricePerKm: json["pricePerKm"],
        seats: json['seats']);
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "from": source,
        "to": destination,
        "departureTime": departureTime,
        "arrivalTime": arrivalTime,
        "status": status,
        "pricePerKm": pricePerKm,
        "seats": seats,
        "distance": distance,
      };
}
