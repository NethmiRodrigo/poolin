class UserLocation {
  UserLocation({
    required this.lat,
    required this.long,
    required this.username,
    required this.type,
    this.distance = 0,
    this.isReached = false,
  });

  double lat;
  double long;
  String username;
  int distance;
  LocType type;
  bool isReached;
}

enum LocType { pickup, dropoff, start, end }
