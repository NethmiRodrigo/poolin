class RideRequest {
  String id;
  String startLocation;
  String destination;
  String profilePicture = 'https://i.pravatar.cc/300';
  DateTime requestedOn;

  RideRequest({
    required this.id,
    required this.startLocation,
    required this.destination,
    required this.requestedOn,
  });
}
