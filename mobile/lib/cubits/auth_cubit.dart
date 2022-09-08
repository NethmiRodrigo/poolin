import 'package:flutter_bloc/flutter_bloc.dart';

class AuthState {
  bool isLoggedIn;

  AuthState({this.isLoggedIn = false});

  AuthState copyWith({required bool isLoggedIn}) {
    return AuthState(isLoggedIn: isLoggedIn);
  }
}

class AuthStateCubit extends Cubit<AuthState> {
  AuthStateCubit() : super(AuthState());
  void setLoggedIn(bool isLoggedIn) =>
      emit(state.copyWith(isLoggedIn: isLoggedIn));

  bool getLoggedInStatus() => state.isLoggedIn;
}
