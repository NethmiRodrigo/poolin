import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mobile/cubits/ride_offer_cubit.dart';
import 'package:mobile/models/ride_type_model.dart';
import 'package:mobile/screens/home/rider_home.dart';
import 'package:mobile/screens/offer-ride/ride_offer_details_screen.dart';
import 'package:mobile/screens/request-ride/ride_offer_results_screen.dart';
import 'package:mobile/screens/request-ride/ride_request_details_screen.dart';
import 'package:mobile/screens/shared/ride/destination_screen.dart';
import 'package:mobile/screens/view-profile/driver_profile_screen.dart';
import 'package:mobile/screens/view-profile/mutual_friends_screen.dart';

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
    return BlocProvider(
      create: (_) => RideOfferCubit(),
      child: MaterialApp(
        title: 'Poolin',
        theme: AppTheme().themeData,
        home: DriverProfileScreen(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
