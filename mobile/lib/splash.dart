import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:poolin/app.dart';
import 'package:poolin/screens/login/login_screen.dart';
import 'package:poolin/services/interceptor/is_loggedin.dart';

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

  void setLoggedInState() async {
    bool value = await isUserLoggedIn();
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
