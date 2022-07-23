class PassengerRequests {
  String id;
  String rider;
  String profilePicture = 'https://i.pravatar.cc/300';
  DateTime date;

  PassengerRequests({
    required this.id,
    required this.rider,
    required this.date,
  });
}
