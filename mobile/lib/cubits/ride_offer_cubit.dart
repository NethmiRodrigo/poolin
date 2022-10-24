import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poolin/models/coordinate_model.dart';

class RideOfferCubit extends Cubit<RideOffer> {
  RideOfferCubit()
      : super(RideOffer(
          source: Coordinate(),
          destination: Coordinate(),
          startTime: DateTime.now(),
        ));

  void setSource(Coordinate source) => emit(state.copyWith(source: source));

  void setDestination(Coordinate destination) =>
      emit(state.copyWith(destination: destination));

  void setDistance(double distance) => emit(state.copyWith(distance: distance));

  void setSeatCount(int seatCount) =>
      emit(state.copyWith(seatCount: seatCount));

  void setStartTime(DateTime startTime) =>
      emit(state.copyWith(startTime: startTime));

  void setDuration(int duration) => emit(state.copyWith(duration: duration));

  void setPerKilometerPrice(int ppkm) => emit(state.copyWith(ppkm: ppkm));
}

//class for information
class RideOffer {
  Coordinate source;
  Coordinate destination;
  int seatCount;
  int ppkm;
  DateTime startTime;
  int duration;
  double distance;

//set defaults for constructor
  RideOffer({
    required this.source,
    required this.startTime,
    required this.destination,
    this.duration = 0,
    this.seatCount = 0,
    this.ppkm = 0,
    this.distance = 0,
  });

//for modification
  RideOffer copyWith(
      {Coordinate? source,
      Coordinate? destination,
      int? seatCount,
      double? distance,
      int? ppkm,
      DateTime? startTime,
      int? duration,
      DateTime? endTime}) {
    return RideOffer(
        source: source ?? this.source,
        destination: destination ?? this.destination,
        seatCount: seatCount ?? this.seatCount,
        ppkm: ppkm ?? this.ppkm,
        distance: distance ?? this.distance,
        duration: duration ?? this.duration,
        startTime: startTime ?? this.startTime);
  }
}
