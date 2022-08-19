import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/models/coordinate_model.dart';

class RideRequestCubit extends Cubit<RideRequest> {
  RideRequestCubit()
      : super(RideRequest(
          source: Coordinate(),
          destination: Coordinate(),
          startTime: DateTime.now(),
        ));

  void setSource(Coordinate source) => emit(state.copyWith(source: source));

  void setDestination(Coordinate destination) =>
      emit(state.copyWith(destination: destination));

  void setDistance(double distance) => emit(state.copyWith(distance: distance));

  void setStartTime(DateTime startTime) =>
      emit(state.copyWith(startTime: startTime));

  void setWindow(int window) => emit(state.copyWith(window: window));

  void setDuration(int duration) => emit(state.copyWith(duration: duration));
  void setPrice(double price) => emit(state.copyWith(price: price));
  void setOffers(List offers) => emit(state.copyWith(offers: offers));
}

//class for information
class RideRequest {
  Coordinate source;
  Coordinate destination;

  DateTime startTime;
  List offers;
  int window;
  int duration;
  double distance;
  double price;

//set defaults for constructor
  RideRequest({
    required this.source,
    required this.startTime,
    required this.destination,
    this.window = 0,
    this.offers = const [],
    this.duration = 0,
    this.distance = 0,
    this.price = 0,
  });

//for modification
  RideRequest copyWith(
      {Coordinate? source,
      Coordinate? destination,
      double? distance,
      DateTime? startTime,
      int? window,
      int? duration,
      List? offers,
      double? price,
      DateTime? endTime}) {
    return RideRequest(
        source: source ?? this.source,
        destination: destination ?? this.destination,
        distance: distance ?? this.distance,
        window: window ?? this.window,
        duration: duration ?? this.duration,
        offers: offers ?? this.offers,
        price: price ?? this.price,
        startTime: startTime ?? this.startTime);
  }
}
