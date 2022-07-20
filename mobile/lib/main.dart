import 'package:flutter/material.dart';
import 'package:mobile/screens/RegisterScreen.dart';
import 'package:mobile/screens/RideOfferDestinationScreen.dart';
import 'package:mobile/screens/RideOfferSourceScreen.dart';
import 'package:mobile/screens/RideRequestDestinationScreen.dart';
import 'package:mobile/screens/RideRequestDetailsScreen.dart';

import './theme.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<void> main() async {
  await dotenv.load();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Poolin',
      theme: AppTheme().themeData,
      home: RideRequestDestinationScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
