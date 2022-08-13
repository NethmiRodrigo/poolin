import 'dart:convert';
import 'package:mobile/models/vehicle_type.dart';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  String id;
  String firstName;
  String lastName;
  String gender;
  String email;
  double stars;
  int totalRatings;
  VehicleType vehicleType;
  String VehicleNum;
String profilePicture;
  User({
    this.id = '000',
    required this.firstName,
    required this.lastName,
    required this.gender,
    required this.email,
    this.stars = 0.0,
    this.totalRatings = 0,
    this.VehicleNum = '',
    this.profilePicture = '',
    this.vehicleType = VehicleType.na,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        firstName: json["firstName"],
        lastName: json["lastName"],
        gender: json["gender"],
        email: json["email"],
        stars: double.parse(json["stars"]),
        totalRatings: int.parse(json["totalRatings"]),
      );

  Map<String, dynamic> toJson() => {
        "firstName": firstName,
        "lastName": lastName,
        "gender": gender,
        "email": email,
        "stars": stars,
        "totalRatings": totalRatings,
      };
}
