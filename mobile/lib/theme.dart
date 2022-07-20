import 'package:flutter/material.dart';

class AppTheme {
  ThemeData themeData = ThemeData(
      primaryColor: const Color(0xffff7115),
      primaryColorDark: const Color(0xff111111),
      shadowColor: const Color(0xff9E9E9E),
      backgroundColor: Color.fromARGB(255, 247, 246, 246),
      hintColor: const Color(0xff29BF4A),
      indicatorColor: const Color(0xfff64e4e),
      errorColor: const Color(0xfff64747),
      fontFamily: 'Satoshi',
      bottomSheetTheme:
          BottomSheetThemeData(backgroundColor: Colors.transparent),
      inputDecorationTheme: const InputDecorationTheme(
        isDense: true,
        contentPadding: EdgeInsets.fromLTRB(16, 8, 16, 0),
        filled: true,
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        labelStyle: TextStyle(color: Colors.black),
        errorStyle:
            TextStyle(fontFamily: 'Satoshi', fontWeight: FontWeight.w700),
        hintStyle: TextStyle(
            color: Color(0xff9E9E9E),
            fontSize: 16,
            fontFamily: 'Satoshi',
            fontWeight: FontWeight.w300),
      ),
      textTheme: ThemeData.light()
          .textTheme
          .copyWith(
            displayLarge: const TextStyle(
              fontFamily: 'Satoshi',
              fontWeight: FontWeight.w900,
              fontSize: 34,
            ),
            displayMedium: const TextStyle(
              fontFamily: 'Satoshi',
              fontWeight: FontWeight.bold,
              fontSize: 34,
            ),
            displaySmall: const TextStyle(
              fontFamily: 'Satoshi',
              fontWeight: FontWeight.bold,
              fontSize: 24,
            ),
            headlineLarge: const TextStyle(
              fontFamily: 'Satoshi',
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
            headlineMedium: const TextStyle(
              fontFamily: 'Satoshi',
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
            headlineSmall: const TextStyle(
              fontFamily: 'Satoshi',
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
            titleLarge: const TextStyle(
              fontFamily: 'Satoshi',
              fontWeight: FontWeight.bold,
              fontSize: 10,
            ),
            titleMedium: const TextStyle(
              fontFamily: 'Satoshi',
              fontWeight: FontWeight.bold,
              fontSize: 8,
            ),
            labelLarge: const TextStyle(
              fontFamily: 'Satoshi',
              fontSize: 16,
            ),
            labelMedium: const TextStyle(
              fontFamily: 'Satoshi',
              fontSize: 12,
            ),
            labelSmall: const TextStyle(
              fontFamily: 'Satoshi',
              fontSize: 8,
            ),
          )
          .apply(bodyColor: Colors.black, displayColor: Colors.black));
}
