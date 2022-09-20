import 'dart:convert';
import 'package:mobile/models/vehicle_type.dart';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  int id;
  String firstName;
  String lastName;
  String gender;
  String? email;
  double stars;
  int totalRatings;
  VehicleType vehicleType;
  String vehicleNum;
  String vehicleModel;
  String profilePicURL;
  String? bio;
  String? occupation;
  DateTime? dateOfBirth;
  DateTime? smsOTPSentAt;
  int? smsOTP;
  String? mobileVerified;
  bool isVerified;
  String role;
  DateTime? createdAt;
  DateTime? updatedAt;
  User({
    this.id = 0,
    required this.firstName,
    required this.lastName,
    this.gender = 'unknown',
    this.email,
    this.stars = 0.0,
    this.totalRatings = 0,
    this.vehicleNum = 'ABX 1233',
    this.vehicleType = VehicleType.na,
    this.vehicleModel = 'Unknown',
    this.profilePicURL =
        'https://www.freeiconspng.com/uploads/profile-icon-9.png',
    this.bio,
    this.occupation,
    this.dateOfBirth,
    this.smsOTP,
    this.smsOTPSentAt,
    this.mobileVerified,
    this.isVerified = false,
    this.role = 'user',
    this.createdAt,
    this.updatedAt,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        firstName: json["firstname"],
        lastName: json["lastname"],
        gender: json["gender"],
        email: json["email"],
        profilePicURL: json["profileImageUri"] ??
            'https://www.freeiconspng.com/uploads/profile-icon-9.png',
        bio: json["bio"],
        occupation: json["occupation"],
        dateOfBirth: json["dateOfBirth"] != null
            ? DateTime.parse(json["dateOfBirth"])
            : null,
        smsOTP: json["smsOTP"],
        smsOTPSentAt: json["smsOTPSentAt"] != null
            ? DateTime.parse(json["smsOTPSentAt"])
            : null,
        mobileVerified: json["mobileVerified"],
        isVerified: json["mobileVerified"] == 'true',
        role: json["role"] ?? 'user',
        createdAt: json["createdAt"] != null
            ? DateTime.parse(json["createdAt"])
            : null,
        updatedAt: json["updatedAt"] != null
            ? DateTime.parse(json["updatedAt"])
            : null,
        stars: json["stars"] != null ? double.parse(json["stars"]) : 0.0,
        totalRatings: json["totalRatings"] ?? 0,
        vehicleType: json['vehicleType'] == 'na'
            ? VehicleType.na
            : json['vehicleType'] == 'car'
                ? VehicleType.car
                : json['vehicleType'] == 'van'
                    ? VehicleType.van
                    : VehicleType.bike,
        vehicleModel: json['vehicleModel'] ?? 'Unknown',
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
