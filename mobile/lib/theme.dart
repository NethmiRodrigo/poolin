import 'package:flutter/material.dart';

class AppTheme {
  ThemeData themeData = ThemeData(
      primaryColor: const Color(0xffff7115),
      primaryColorDark: const Color(0xff111111),
      shadowColor: const Color(0xffb0b0b0),
      backgroundColor: const Color(0xfff9f9f9),
      hintColor: const Color(0xff3d8262),
      indicatorColor: const Color(0xfff64e4e),
      errorColor: const Color(0xfff64747),
      fontFamily: 'Satoshi',
      textTheme: ThemeData.light().textTheme.copyWith(
            headline1: const TextStyle(
              fontFamily: 'Satoshi',
              fontWeight: FontWeight.bold,
              fontSize: 96,
            ),
            headline2: const TextStyle(
              fontFamily: 'Satoshi',
              fontWeight: FontWeight.bold,
              fontSize: 60,
            ),
            headline3: const TextStyle(
              fontFamily: 'Satoshi',
              fontWeight: FontWeight.bold,
              fontSize: 48,
            ),
            headline4: const TextStyle(
              fontFamily: 'Satoshi',
              fontWeight: FontWeight.bold,
              fontSize: 34,
            ),
            headline5: const TextStyle(
              fontFamily: 'Satoshi',
              fontWeight: FontWeight.bold,
              fontSize: 24,
            ),
            headline6: const TextStyle(
              fontFamily: 'Satoshi',
              fontSize: 20,
            ),
            subtitle1: const TextStyle(
              fontFamily: 'Satoshi',
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
            bodyText1: const TextStyle(
              fontFamily: 'Satoshi',
              fontSize: 16,
            ),
            button: const TextStyle(
              fontFamily: 'Satoshi',
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ));
}
