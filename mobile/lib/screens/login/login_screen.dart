import 'package:dio/dio.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:poolin/app.dart';
import 'package:poolin/cubits/active_ride_cubit.dart';
import 'package:poolin/cubits/auth_cubit.dart';
import 'package:poolin/custom/wide_button.dart';
import 'package:poolin/models/active_ride_offer.dart';
import 'package:poolin/models/ride_type_model.dart';
import 'package:poolin/screens/forgot-password/forgot_password_screen.dart';
import 'package:poolin/services/login_service.dart';
import 'package:poolin/services/ride_offer_service.dart';
import 'package:poolin/utils/widget_functions.dart';

import '../../colors.dart';
import '../../fonts.dart';
import '../register/register_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  LoginScreenState createState() {
    return LoginScreenState();
  }
}

class LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _pass = TextEditingController();
  late ActiveRideCubit activeRideCubit;
  late AuthStateCubit authState;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    activeRideCubit = BlocProvider.of<ActiveRideCubit>(context);
    authState = BlocProvider.of<AuthStateCubit>(context);
  }

  Future<bool> getActiveRide() async {
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
    return true;
  }

  Future<bool> handleLogin(String email, String password) async {
    setState(() {
      isLoading = true;
    });

    Response response = await login(_email.text, _pass.text);

    if (response.statusCode == 200) {
      authState.setLoggedIn(true);
      bool result = await getActiveRide();
      if (result) {
        setState(() {
          isLoading = false;
        });
      }
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    const double padding = 16;
    const sidePadding = EdgeInsets.symmetric(horizontal: padding);

    // Build a Form widget using the _formKey created above.
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(
                color: BlipColors.orange,
              ),
            )
          : SizedBox(
              width: size.width,
              height: size.height,
              child: Padding(
                padding: sidePadding,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    addVerticalSpace(44),
                    Image.asset('assets/images/logo.png', height: 24),
                    const Text(
                      "Let's sign \nyou back in",
                      style: BlipFonts.display,
                      textAlign: TextAlign.left,
                    ),
                    addVerticalSpace(48),
                    Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextFormField(
                            style: Theme.of(context).textTheme.labelLarge,
                            controller: _email,
                            decoration: const InputDecoration(
                              prefixIcon: Icon(Icons.email_outlined),
                              hintText: 'Enter University Email',
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Email is required';
                              }

                              return null;
                            },
                          ),
                          addVerticalSpace(24),
                          TextFormField(
                            style: Theme.of(context).textTheme.labelLarge,
                            controller: _pass,
                            obscureText: true,
                            decoration: const InputDecoration(
                              prefixIcon: Icon(Icons.lock),
                              hintText: 'Enter password',
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Password is required';
                              } else if (value.length < 8) {
                                return 'Password length must be atleast 8 characters';
                              }
                              return null;
                            },
                          ),
                          addVerticalSpace(10),
                          Align(
                            alignment: Alignment.topRight,
                            child: RichText(
                              text: TextSpan(
                                  text: 'Forgot password?',
                                  style: BlipFonts.outlineBold.merge(
                                    const TextStyle(color: BlipColors.orange),
                                  ),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const ForgotPasswordScreen()),
                                      );
                                    }),
                            ),
                          ),
                          addVerticalSpace(32),
                          WideButton(
                              text: 'Sign in',
                              onPressedAction: () async {
                                if (_formKey.currentState!.validate()) {
                                  bool res = await handleLogin(_email.text, _pass.text);
                                  if (res && !isLoading) {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => const App()),
                                    );
                                  }
                                }
                              }),
                          addVerticalSpace(16),
                          Center(
                            child: RichText(
                              text: TextSpan(children: [
                                TextSpan(
                                  text: 'Not a member? ',
                                  style: BlipFonts.outline.merge(
                                      const TextStyle(color: BlipColors.black)),
                                ),
                                TextSpan(
                                    text: 'Sign Up',
                                    style: BlipFonts.outlineBold.merge(
                                      const TextStyle(color: BlipColors.orange),
                                    ),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const RegisterScreen()),
                                        );
                                      }),
                              ]),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
