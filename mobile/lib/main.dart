import 'package:flutter/material.dart';
import 'package:mobile/screens/login/login_screen.dart';
import 'package:mobile/screens/register/register_screen.dart';
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
      home: const LoginScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
