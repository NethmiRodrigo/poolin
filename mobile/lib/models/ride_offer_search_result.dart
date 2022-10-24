import 'package:poolin/models/coordinate_model.dart';
import 'package:poolin/models/user_model.dart';

class RideOfferSearchResult {
  String id;
  User driver;
  int availableSeats;
  double pricePerKM;
  double distance;
  DateTime startTime;
  Coordinate source;
  Coordinate destination;

  RideOfferSearchResult({
    required this.id,
    this.availableSeats = 1,
    this.pricePerKM = 250.0,
    this.distance = 0.0,
    required this.startTime,
    required this.source,
    required this.destination,
    required this.driver,
  });
}
