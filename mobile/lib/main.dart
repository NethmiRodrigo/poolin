import 'package:flutter/material.dart';
import 'package:mobile/screens/ChangePasswordScreen.dart';
import 'package:mobile/screens/EmailOTPScreen.dart';
import 'package:mobile/screens/RegisterScreen.dart';
import 'package:mobile/screens/EditPersonalDetailsScreen.dart';
import 'package:mobile/screens/EditPhoneNumberOTPScreen.dart';
import 'package:mobile/screens/EditPhoneNumberScreen.dart';
import 'package:mobile/screens/EditProfileScreen.dart';
import 'package:mobile/screens/PersonalDetailsScreen.dart';
import 'package:mobile/screens/EditGenderScreen.dart';
import 'package:mobile/screens/EditBioScreen.dart';
import 'package:mobile/screens/EditDateOfBirthScreen.dart';
import 'package:mobile/screens/testfile.dart';
import 'package:mobile/screens/PhoneNumberScreen.dart';

import './theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Poolin',
      theme: AppTheme().themeData,
      home: EditPhoneNumberOTPScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
