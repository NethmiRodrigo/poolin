import 'dart:convert';

PassengerRequest userFromJson(String str) =>
    PassengerRequest.fromJson(json.decode(str));

String userToJson(PassengerRequest data) => json.encode(data.toJson());

class PassengerRequest {
  String id;
  String rider;
  String profilePicture;
  DateTime date;

  PassengerRequest({
    required this.id,
    required this.rider,
    required this.date,
    required this.profilePicture,
  });

  factory PassengerRequest.fromJson(Map<String, dynamic> json) =>
      PassengerRequest(
          id: json["id"],
          rider: json["rider"],
          date: DateTime.parse(json["date"]),
          profilePicture: json["profilePicture"]);

  Map<String, dynamic> toJson() => {
        "id": id,
        "rider": rider,
        "date": date,
      };
}
