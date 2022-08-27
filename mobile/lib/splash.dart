import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/app.dart';
import 'package:mobile/colors.dart';
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
  CurrentUserCubit? userCubit;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    setLoggedInState();
  }

  void setUser() async {
    if (!mounted) {
      return;
    }
    Response response = await getCurrentUser();
    User loggedInUser = User.fromJson(response.data);
    userCubit?.setUser("1", loggedInUser.firstName, loggedInUser.lastName,
        loggedInUser.gender, loggedInUser.email);
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

  @override
  Widget build(BuildContext context) {
    userCubit = BlocProvider.of<CurrentUserCubit>(context);
    return isLoading
        ? const Center(
            child: CircularProgressIndicator(
              color: BlipColors.orange,
            ),
          )
        : AnimatedSplashScreen(
            splashTransition: SplashTransition.fadeTransition,
            backgroundColor: const Color(0xffff8210),
            splash: "assets/images/poolin.gif",
            splashIconSize: 2500,
            nextScreen: isLoggedIn ? const App() : const LoginScreen(),
          );
  }
}
