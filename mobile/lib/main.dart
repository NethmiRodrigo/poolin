import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mobile/screens/current-ride/driver_nav.dart';
import 'package:mobile/screens/current-ride/start_ride.dart';
import 'package:mobile/screens/current-ride/track_driver.dart';

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
    return MaterialApp(
      title: 'Poolin',
      theme: AppTheme().themeData,
      home: const TrackDriver(),
      debugShowCheckedModeBanner: false,
    );
  }
}
