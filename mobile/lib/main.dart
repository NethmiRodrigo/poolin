import 'package:flutter/material.dart';
import 'package:mobile/views/EmailOTPScreen.dart';
import 'package:mobile/views/PhoneOTPScreen.dart';
import 'package:mobile/views/registerScreen.dart';

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
      home: PhoneOTPScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
