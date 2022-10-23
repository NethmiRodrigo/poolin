import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:poolin/app.dart';
import 'package:poolin/cubits/active_ride_cubit.dart';
import 'package:poolin/cubits/current_user_cubit.dart';
import 'package:poolin/models/active_ride_offer.dart';
import 'package:poolin/models/ride_type_model.dart';
import 'package:poolin/models/user_model.dart';
import 'package:poolin/screens/login/login_screen.dart';
import 'package:poolin/services/auth_service.dart';
import 'package:poolin/services/interceptor/is_loggedin.dart';
import 'package:poolin/services/ride_offer_service.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late ActiveRideCubit activeRideCubit;
  bool isLoggedIn = false;
  CurrentUserCubit? userCubit;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    activeRideCubit = BlocProvider.of<ActiveRideCubit>(context);
    setLoggedInState();
  }

  void setUser() async {
    if (!mounted) {
      return;
    }
    Response response = await getCurrentUser();
    User loggedInUser = User.fromJson(response.data);
    userCubit?.setUser(
      loggedInUser.id,
      loggedInUser.firstName,
      loggedInUser.lastName,
      loggedInUser.gender,
      loggedInUser.email.toString(),
    );
    getActiveRide();
  }

  void setLoggedInState() async {
    bool value = await isUserLoggedIn();
    if (value) {
      setUser();
    }
    setState(() {
      isLoading = false;
      isLoggedIn = value;
    });
  }

  void getActiveRide() async {
    Response response = await getActiveOffer();
    if (response.data["offer"] != null) {
      ActiveRideOffer rideOffer =
          ActiveRideOffer.fromJson(response.data["offer"]);
      activeRideCubit.setId(rideOffer.id);
      activeRideCubit.setType(RideType.offer);
      activeRideCubit.setSource(rideOffer.source);
      activeRideCubit.setDestination(rideOffer.destination);
      activeRideCubit.setDepartureTime(rideOffer.departureTime);
    }
  }

  @override
  Widget build(BuildContext context) {
    final CurrentUserCubit userCubit =
        BlocProvider.of<CurrentUserCubit>(context);

    void setUser() async {
      Response response = await getCurrentUser();
      if (response.statusCode == 200) {
        userCubit.setId(response.data['id']);
        userCubit.setFirstName(response.data['firstname']);
        userCubit.setLastName(response.data['lastname']);
        userCubit.setEmail(response.data['email']);
        userCubit.setGender(response.data['gender']);
        if (response.data['profileImageUri'] != null) {
          userCubit.setProfilePic(response.data['profileImageUri']);
        }
      }
    }

    if (isLoggedIn) {
      setUser();
    }

    return AnimatedSplashScreen(
      splashTransition: SplashTransition.fadeTransition,
      backgroundColor: const Color(0xffff8210),
      splash: "assets/images/poolin.gif",
      splashIconSize: 2500,
      nextScreen: isLoggedIn ? const App() : const LoginScreen(),
    );
  }
}
