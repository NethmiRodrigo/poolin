import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mobile/cubits/active_ride_cubit.dart';
import 'package:mobile/cubits/current_user_cubit.dart';
import 'package:mobile/cubits/ride_offer_cubit.dart';
import 'package:mobile/screens/friends/close_friends.dart';
import 'package:mobile/screens/friends/mutual_friends.dart';
import 'package:mobile/screens/friends/mutual_friendsnew.dart';
import 'package:mobile/screens/offer-ride/offer_details_card.dart';
import 'package:mobile/screens/offer-ride/ride_offer_details_screen.dart';
import 'package:mobile/screens/request-ride/ride_request_details_screen.dart';
import 'package:mobile/screens/ride_visibility/ride_visibility.dart';
import 'package:mobile/screens/notification/view_notification.dart';
import 'package:mobile/screens/offer-ride/driver_ride_visibility_screen.dart';
import 'package:mobile/screens/request-ride/rider_ride_visibility_screen.dart';
import 'package:mobile/screens/shared/ride/search_screen.dart';
import 'package:mobile/screens/user-profile-details/ride_visibility.dart';
import 'package:mobile/screens/user-profile-details/vehical_information.dart';
import 'package:mobile/screens/user-profile-details/vehical_informationdescri.dart';
import 'package:mobile/screens/user/profile/user_profile_screen.dart';
import 'package:mobile/screens/view-profile/mutual_friends_screen.dart';
import 'package:mobile/screens/view-ride-offers/view_offer_details_screen.dart';
import 'package:mobile/splash.dart';

import './theme.dart';

import 'package:mobile/theme.dart';

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
        home: const CloseFriendsScreen(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
