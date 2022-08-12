import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mobile/cubits/active_ride_cubit.dart';
import 'package:mobile/cubits/current_user_cubit.dart';
import 'package:mobile/cubits/ride_offer_cubit.dart';
import 'package:mobile/screens/home/rider_home.dart';
import 'package:mobile/screens/login/login_screen.dart';
import 'package:mobile/screens/offer-ride/ride_offer_details_screen.dart';
import 'package:mobile/screens/register/register_screen.dart';
import 'package:mobile/screens/shared/ride/destination_screen.dart';
import 'package:mobile/screens/view-ride-offers/view_ride_offers_screen.dart';

import './theme.dart';

Future<void> main() async {
  await dotenv.load();
  if (defaultTargetPlatform == TargetPlatform.android) {
    AndroidGoogleMapsFlutter.useAndroidViewSurface = true;
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<RideOfferCubit>(
          create: (context) => RideOfferCubit(),
        ),
        BlocProvider<ActiveRideCubit>(
          create: (context) => ActiveRideCubit(),
        ),
        BlocProvider<CurrentUserCubit>(
          create: (context) => CurrentUserCubit(),
        ),
      ],
      child: MaterialApp(
        title: 'Poolin',
        theme: AppTheme().themeData,
        home: AnimatedSplashScreen(
            splashTransition: SplashTransition.fadeTransition,
            backgroundColor: const Color(0xffff8210),
            splash: "assets/images/poolin.gif",
            splashIconSize: 2500,
            nextScreen: RiderHomeScreen()),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
