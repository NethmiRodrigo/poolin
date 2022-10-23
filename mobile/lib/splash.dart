import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poolin/app.dart';
import 'package:poolin/cubits/current_user_cubit.dart';
import 'package:poolin/models/user_model.dart';
import 'package:poolin/screens/login/login_screen.dart';
import 'package:poolin/services/auth_service.dart';
import 'package:poolin/services/interceptor/is_loggedin.dart';

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
        loggedInUser.gender, loggedInUser.email.toString());
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
    final CurrentUserCubit userCubit =
        BlocProvider.of<CurrentUserCubit>(context);

    void setUser() async {
      Response response = await getCurrentUser();
      if (response.statusCode == 200) {
        userCubit.setId(response.data['id'].toString());
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
