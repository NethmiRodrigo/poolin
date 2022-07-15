import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  String firstName;
  String lastName;
  String gender;
  String email;
  User({
    required this.firstName,
    required this.lastName,
    required this.gender,
    required this.email,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        firstName: json["firstName"],
        lastName: json["lastName"],
        gender: json["gender"],
        email: json["email"],
      );

  Map<String, dynamic> toJson() => {
        "firstName": firstName,
        "lastName": lastName,
        "gender": gender,
        "email": email,
      };
}
