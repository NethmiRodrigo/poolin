import 'package:flutter_bloc/flutter_bloc.dart';

class ActiveRide {
  int seats;
  int price;

  ActiveRide({
    this.seats = 5,
    this.price = 0,
  });

  ActiveRide copyWith({
    int? seats,
    int? price,
  }) {
    return ActiveRide(
      seats: seats ?? this.seats,
      price: price ?? this.price,
    );
  }
}

class ActiveRideCubit extends Cubit<ActiveRide> {
  ActiveRideCubit() : super(ActiveRide());

  void decrementSeats() => emit(state.copyWith(seats: state.seats - 1));
  void incrementPrice(int price) =>
      emit(state.copyWith(price: state.price += price));
  void decrementPrice(int price) =>
      emit(state.copyWith(price: state.price -= price));
}
