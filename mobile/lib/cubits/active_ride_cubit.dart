import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/models/coordinate_model.dart';
import 'package:mobile/models/ride_role_type.dart';
import 'package:mobile/models/ride_type_model.dart';

class ActiveRide {
  int? id;
  RideType? type;
  String source;
  String destination;
  int seats;
  double price;
  late DateTime? departureTime;
  List<RideParticipant> partyData;

  ActiveRide({
    required this.id,
    required this.type,
    required this.source,
    required this.destination,
    this.seats = 5,
    this.price = 0,
    this.partyData = const [],
    DateTime? departTime,
  }) : departureTime = departTime;

  ActiveRide copyWith({
    int? id,
    RideType? type,
    String? source,
    String? destination,
    int? seats,
    double? price,
    DateTime? departureTime,
    List<RideParticipant>? partyData,
  }) {
    return ActiveRide(
      id: id ?? this.id,
      type: type ?? this.type,
      source: source ?? this.source,
      destination: destination ?? this.destination,
      seats: seats ?? this.seats,
      price: price ?? this.price,
      departTime: departureTime ?? this.departureTime,
      partyData: partyData ?? this.partyData,
    );
  }
}

class RideParticipant {
  int id;
  RideRole role;
  String firstname;
  String lastname;
  String avatar;
  double price;
  DateTime pickupTime;
  Coordinate pickupLocation;
  Coordinate dropoffLocation;

  RideParticipant({
    required this.id,
    required this.role,
    required this.firstname,
    required this.lastname,
    this.avatar = 'https://i.ibb.co/qgVMXFS/profile-icon-9.png',
    required this.price,
    required this.pickupTime,
    required this.pickupLocation,
    required this.dropoffLocation,
  });
}

class ActiveRideCubit extends Cubit<ActiveRide> {
  ActiveRideCubit()
      : super(ActiveRide(
          id: null,
          type: null,
          source: '',
          destination: '',
        ));

  void setId(int id) => emit(state.copyWith(id: id));

  void setType(RideType type) => emit(state.copyWith(type: type));

  void setSource(String source) => emit(state.copyWith(source: source));

  void setDestination(String destination) =>
      emit(state.copyWith(destination: destination));

  int? getId() => state.id;

  double getPrice() => state.price;

  void setDepartureTime(DateTime dateTime) {
    emit(state.copyWith(departureTime: dateTime));
  }

  DateTime getDepartureTime() => state.departureTime ?? DateTime.now();

  int getSeats() => state.seats;

  void decrementSeats() => emit(state.copyWith(seats: state.seats - 1));

  void incrementPrice(int price) =>
      emit(state.copyWith(price: state.price += price));

  void decrementPrice(int price) =>
      emit(state.copyWith(price: state.price -= price));

  void setPrice(double price) => emit(state.copyWith(price: price));

  void setParty(List<RideParticipant> party) =>
      emit(state.copyWith(partyData: party));
}
