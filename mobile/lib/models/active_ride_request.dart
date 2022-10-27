import 'package:poolin/models/coordinate_model.dart';

class ActiveRideRequest {
  late int id;
  late Coordinate source;
  late Coordinate destination;
  late DateTime departureTime;
  late double distance;
  late double price;

  ActiveRideRequest({
    required this.id,
    required this.source,
    required this.destination,
    required this.departureTime,
    required this.distance,
    required this.price,
  });

  factory ActiveRideRequest.fromJson(Map<String, dynamic> json) {
    return ActiveRideRequest(
      id: json["id"],
      source: Coordinate(
          name: json["source"]["name"],
          lat: json["source"]["coordinates"][0],
          lang: json["source"]["coordinates"][1]),
      destination: Coordinate(
          name: json["destination"]["name"],
          lat: json["destination"]["coordinates"][0],
          lang: json["destination"]["coordinates"][1]),
      departureTime: DateTime.parse(json["departureTime"]),
      distance: double.parse(json["distance"]),
      price: double.parse(json["price"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "from": source,
        "to": destination,
        "departureTime": departureTime,
        "distance": distance,
      };
}
