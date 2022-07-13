import 'package:flutter/material.dart';
import 'package:mobile/screens/EmailOTPScreen.dart';

import 'package:mobile/screens/RegisterScreen.dart';

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
      home: const EmailOTPScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
