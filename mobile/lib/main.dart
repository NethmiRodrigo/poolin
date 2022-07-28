import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mobile/models/ride_type_model.dart';
import 'package:mobile/screens/forgot-password/email_sent_screen.dart';
import 'package:mobile/screens/forgot-password/forgot_password_screen.dart';
import 'package:mobile/screens/forgot-password/reset_password_screen.dart';
import 'package:mobile/screens/forgot-password/verify_email_otp_screen.dart';
import 'package:mobile/screens/login/login_screen.dart';
import 'package:mobile/screens/register/email_otp_screen.dart';
import 'package:mobile/screens/register/personal_details_screen.dart';
import 'package:mobile/screens/register/phone_number_screen.dart';
import 'package:mobile/screens/register/phone_otp_screen.dart';
import 'package:mobile/screens/register/register_screen.dart';

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
      home: PersonalDetailsScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
