import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mobile/blocs/application_bloc.dart';
import 'package:mobile/screens/login/login_screen.dart';
import 'package:mobile/screens/offer-ride/ride_offer_details_screen.dart';
import 'package:mobile/screens/request-ride/ride_request_destination_screen.dart';
import 'package:mobile/screens/request-ride/ride_request_source_screen.dart';
import 'package:mobile/screens/view-ride-requests/reserve_request_screen.dart';
import 'package:mobile/screens/view-ride-requests/view_ride_requests_screen.dart';

import 'package:provider/provider.dart';

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
    return ChangeNotifierProvider(
      create: (context) => ApplicationBloc(),
      child: MaterialApp(
        title: 'Poolin',
        theme: AppTheme().themeData,
        home: ViewRideRequestsScreen(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
