import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mobile/screens/EditProfileScreen.dart';
import 'package:mobile/screens/UploadDocumentScreen.dart';
import 'package:mobile/screens/register/register_screen.dart';

import './theme.dart';

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
      home: EditProfileScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
