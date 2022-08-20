import 'package:flutter_bloc/flutter_bloc.dart';

class ActiveRide {
  var today = DateTime.now();
  int seats;
  int price;
  int id;
  late DateTime? departureTime;

  ActiveRide({
    this.id = 1,
    this.seats = 5,
    this.price = 0,
    DateTime? departTime,
  }) : departureTime = departTime;

  ActiveRide copyWith(
      {int? seats, int? price, int? id, DateTime? departureTime}) {
    return ActiveRide(
        seats: seats ?? this.seats,
        price: price ?? this.price,
        id: id ?? this.id,
        departTime: departureTime ?? this.departureTime);
  }
}

class ActiveRideCubit extends Cubit<ActiveRide> {
  ActiveRideCubit() : super(ActiveRide());

  void setId(int id) => emit(state.copyWith(id: id));

  int getId() => state.id;

  void setDepartureTime(DateTime dateTime) {
    emit(state.copyWith(departureTime: dateTime));
  }

  DateTime getDepartureTime() => state.departureTime ?? DateTime.now();

  void decrementSeats() => emit(state.copyWith(seats: state.seats - 1));

  void incrementPrice(int price) =>
      emit(state.copyWith(price: state.price += price));

  void decrementPrice(int price) =>
      emit(state.copyWith(price: state.price -= price));

  void setPrice(int price) => emit(state.copyWith(price: price));
}
