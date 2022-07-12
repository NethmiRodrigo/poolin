import 'dart:convert';

Person personFromJson(String str) => Person.fromJson(json.decode(str));

String personToJson(Person data) => json.encode(data.toJson());

class Person {
  String? firstName;
  String? lastName;
  String? gender;

  Person({
    this.firstName,
    this.lastName,
    this.gender,
  });

  factory Person.fromJson(Map<String, dynamic> json) => Person(
        firstName: json["firstName"],
        lastName: json["lastName"],
        gender: json["gender"],
      );

  Map<String, dynamic> toJson() => {
        "firstName": firstName,
        "lastName": lastName,
        "gender": gender,
      };
}
