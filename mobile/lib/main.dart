import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:poolin/cubits/active_ride_cubit.dart';
import 'package:poolin/cubits/auth_cubit.dart';
import 'package:poolin/cubits/current_user_cubit.dart';
import 'package:poolin/cubits/matching_rides_cubit.dart';

import 'package:poolin/cubits/ride_offer_cubit.dart';
import 'package:poolin/cubits/ride_request_cubit.dart';
import 'package:poolin/screens/request-ride/rider_ride_visibility_screen.dart';
import 'package:poolin/screens/ride-visibility/ride_visibility.dart';
import 'package:poolin/screens/user/profile/user_profile_screen.dart';
import 'package:poolin/splash.dart';
import 'package:poolin/theme.dart';

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
        BlocProvider<RideRequestCubit>(
          create: (context) => RideRequestCubit(),
        ),
        BlocProvider<CurrentUserCubit>(
          create: (context) => CurrentUserCubit(),
        ),
        BlocProvider<MatchingOffersCubit>(
          create: (context) => MatchingOffersCubit(),
        ),
        BlocProvider<AuthStateCubit>(
          create: (context) => AuthStateCubit(),
        ),
      ],
      child: MaterialApp(
        title: 'Poolin',
        theme: AppTheme().themeData,
        home: const RideVisibilityScreen(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
