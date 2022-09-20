import 'dart:convert';

Coordinate coordinateFromJson(String str) =>
    Coordinate.fromJson(json.decode(str));

String coordinateToJson(Coordinate data) => json.encode(data.toJson());

class Coordinate {
  Coordinate({
    this.lat = 0,
    this.lang = 0,
    this.name = "",
  });

  double lat;
  double lang;
  String name;

  factory Coordinate.fromJson(Map<String, dynamic> json) => Coordinate(
        lat: json["lat"],
        lang: json["lang"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "lat": lat,
        "lang": lang,
        "name": name,
      };
}
