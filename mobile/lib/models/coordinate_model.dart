//     final coordinate = coordinateFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

Coordinate coordinateFromJson(String str) =>
    Coordinate.fromJson(json.decode(str));

String coordinateToJson(Coordinate data) => json.encode(data.toJson());

class Coordinate {
  Coordinate({
    this.lat = "",
    this.lang = "",
    this.name = "",
  });

  String lat;
  String lang;
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
