import 'package:flutter/material.dart';
import 'package:my_chat/config/colors.dart';

var lightTheme = ThemeData();
var darkTheme = ThemeData(
    brightness: Brightness.dark,
    useMaterial3: true,

    //
    colorScheme: const ColorScheme.dark(
        primary: dPrimaryColor,
        onPrimary: dOnBackgroundColor,
        background: dBackgroundColor,
        onBackground: dOnBackgroundColor,
        primaryContainer: dContainerColor,
        onPrimaryContainer: donContainerColor),

    //
    textTheme: const TextTheme(
      headlineLarge: TextStyle(
          fontSize: 32,
          color: dPrimaryColor,
          fontFamily: "Poppins",
          fontWeight: FontWeight.w800),
      headlineMedium: TextStyle(
          fontSize: 30,
          color: dOnBackgroundColor,
          fontFamily: "Poppins",
          fontWeight: FontWeight.w600),
      headlineSmall: TextStyle(
          fontSize: 20,
          color: dOnBackgroundColor,
          fontFamily: "Poppins",
          fontWeight: FontWeight.w600),
      labelLarge: TextStyle(
          fontSize: 15,
          color: donContainerColor,
          fontFamily: "poppins",
          fontWeight: FontWeight.w400),
      labelSmall: TextStyle(
          fontSize: 12,
          color: donContainerColor,
          fontFamily: "poppins",
          fontWeight: FontWeight.w400),
      labelMedium: TextStyle(
          fontSize: 10,
          color: donContainerColor,
          fontFamily: "poppins",
          fontWeight: FontWeight.w200),
      bodyLarge: TextStyle(
          fontSize: 18,
          color: dOnBackgroundColor,
          fontFamily: "poppins",
          fontWeight: FontWeight.w500),
      bodyMedium: TextStyle(
          fontSize: 15,
          color: dOnBackgroundColor,
          fontFamily: "poppins",
          fontWeight: FontWeight.w500),
    ),
    //
    appBarTheme: AppBarTheme(backgroundColor: dBackgroundColor),

    //
    inputDecorationTheme: InputDecorationTheme(
        border: UnderlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(10)),
        fillColor: dBackgroundColor,
        filled: true));
