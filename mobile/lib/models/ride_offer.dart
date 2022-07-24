class RideOffer {
  String id;
  String startLocation;
  String destination;
  String profilePicture = 'https://i.pravatar.cc/300';
  DateTime offeredOn;

  RideOffer({
    required this.id,
    required this.startLocation,
    required this.destination,
    required this.offeredOn,
  });
}
