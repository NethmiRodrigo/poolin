import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mobile/screens/current-ride/start_ride.dart';
import 'package:mobile/cubits/active_ride_cubit.dart';
import 'package:mobile/cubits/ride_offer_cubit.dart';
import 'package:mobile/screens/current-ride/track_driver.dart';
import 'package:mobile/screens/home/driver_home.dart';
import 'package:mobile/screens/view-ride-requests/view_ride_requests_screen.dart';

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
      ],
      child: MaterialApp(
        title: 'Poolin',
        theme: AppTheme().themeData,
        home: const ViewRideRequestsScreen(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
