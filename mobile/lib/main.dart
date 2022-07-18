import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:mobile/screens/DriverHomeScreen.dart';
import 'package:mobile/screens/RegisterScreen.dart';
import './theme.dart';

Future<void> main() async {
  await dotenv.load();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  // final storage = const FlutterSecureStorage();
  // String? token;

  // bool _isUserLoggedIn() async {
  //   token = await storage.read(key: 'token');
  //   if (token == null) {
  //     return false;
  //   } else {
  //     return true;
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Poolin',
      theme: AppTheme().themeData,
      // home: const RegisterScreen(),
      home: const DriverHomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
