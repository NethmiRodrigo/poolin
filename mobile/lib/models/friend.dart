import 'dart:math';

int i = 1 + Random().nextInt(70);

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
}
