import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/models/coordinate_model.dart';
import 'package:mobile/models/user_model.dart';

class MatchingOffersCubit extends Cubit<MatchingOffersList> {
  MatchingOffersCubit()
      : super(MatchingOffersList(offers: []));

      void addOffer(MatchedOffer offer) => emit(state.copyWith(offers: [...state.offers, offer]));

      void clearOffers() => emit(MatchingOffersList(offers: []));
}

class MatchingOffersList {
  List<MatchedOffer> offers;

  MatchingOffersList({required this.offers});

  MatchingOffersList copyWith({List<MatchedOffer>? offers}) {
    return MatchingOffersList(offers: offers ?? this.offers);
  }
}

//class for information
class MatchedOffer {
  int id;
  User driver;
  int availableSeats;
  double pricePerKM;
  double distance;
  DateTime startTime;
  Coordinate source;
  Coordinate destination;

//set defaults for constructor
  MatchedOffer({
    required this.id,
    required this.startTime,
    required this.source,
    required this.destination,
    this.availableSeats = 1,
    this.pricePerKM = 250.0,
    this.distance = 0.0,
    required this.driver,
  });

//for modification
  MatchedOffer copyWith({
    int? id,
    User? driver,
    int? availableSeats,
    double? pricePerKM,
    double? distance,
    DateTime? startTime,
    Coordinate? source,
    Coordinate? destination,
  }) {
    return MatchedOffer(
      id: id ?? this.id,
      driver: driver ?? this.driver,
      availableSeats: availableSeats ?? this.availableSeats,
      pricePerKM: pricePerKM ?? this.pricePerKM,
      distance: distance ?? this.distance,
      startTime: startTime ?? this.startTime,
      source: source ?? this.source,
      destination: destination ?? this.destination,
    );
  }
}
