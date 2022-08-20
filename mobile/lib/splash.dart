import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/app.dart';
import 'package:mobile/cubits/current_user_cubit.dart';
import 'package:mobile/models/user_model.dart';
import 'package:mobile/screens/login/login_screen.dart';
import 'package:mobile/services/auth_service.dart';
import 'package:mobile/services/interceptor/is_loggedin.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool isLoggedIn = false;

  @override
  void initState() {
    super.initState();
    setLoggedInState();
  }

  void setUser() async {
    if (mounted) {
      Response response = await getCurrentUser();
      User loggedInUser = User.fromJson(response.data);
      CurrentUserCubit userCubit = BlocProvider.of<CurrentUserCubit>(context);
      userCubit.setFirstName(loggedInUser.firstName);
      userCubit.setLastName(loggedInUser.lastName);
      userCubit.setEmail(loggedInUser.email);
      userCubit.setGender(loggedInUser.gender);
      userCubit.setStars(loggedInUser.stars);
      userCubit.setProfilePic(loggedInUser.profilePicURL);
      userCubit.setIsVerified(loggedInUser.isVerified);
    }
  }

  void setLoggedInState() async {
    bool value = await isUserLoggedIn();
    if (value) {
      setUser();
    }
    setState(() {
      isLoggedIn = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splashTransition: SplashTransition.fadeTransition,
      backgroundColor: const Color(0xffff8210),
      splash: "assets/images/poolin.gif",
      splashIconSize: 2500,
      nextScreen: isLoggedIn ? const App() : const LoginScreen(),
    );
  }
}
