import 'dart:convert';

Friend userFromJson(String str) => Friend.fromJson(json.decode(str));

String userToJson(Friend data) => json.encode(data.toJson());

class Friend {
  String id;
  String firstName;
  String lastName;
  String profilePicture;

  Friend({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.profilePicture,
  });

  factory Friend.fromJson(Map<String, dynamic> json) => Friend(
        id: json["id"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        profilePicture: json["profilePicture"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "firstName": firstName,
        "lastName": lastName,
        "profilePicture": profilePicture
      };
}
