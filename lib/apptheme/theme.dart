import 'package:flutter/material.dart';
import 'package:guomobile/constant/colors.dart';

class AppTheme {
  AppTheme._();

  static final ThemeData lightMode = ThemeData(
    scaffoldBackgroundColor: guocolor.background,
    canvasColor: guocolor.background,
    cardColor: guocolor.white,
    cardTheme: const CardTheme(shadowColor: guocolor.offWhite),
    accentColor: guocolor.primaryColor,
    dividerColor: guocolor.secondary3,
    fontFamily: "OpenSans",
    visualDensity: VisualDensity.adaptivePlatformDensity,
    textTheme: const TextTheme(
      bodyText1: TextStyle(
          letterSpacing: -0.25, fontSize: 14, fontWeight: FontWeight.w400),
      bodyText2: TextStyle(
          letterSpacing: -0.25, fontSize: 16, fontWeight: FontWeight.w400),
    ).apply(bodyColor: guocolor.black.withOpacity(.9), displayColor: guocolor.secondary3),
    appBarTheme: const AppBarTheme(
        color: guocolor.background,
        iconTheme: IconThemeData(color: guocolor.primaryColor)),
    colorScheme: const ColorScheme.light(
        onPrimary: guocolor.white,
        primary: guocolor.primaryColor,
        secondary: guocolor.primaryColor,
        error: guocolor.accentColorDark),
    iconTheme: const IconThemeData(
      color: guocolor.primaryColor,
    ),
  );

  static final ThemeData darkMode = ThemeData(
    scaffoldBackgroundColor: guocolor.black,
    canvasColor: guocolor.black,
    accentColor: guocolor.white,
    fontFamily: "Futura",
    visualDensity: VisualDensity.adaptivePlatformDensity,
    textTheme: const TextTheme(
      bodyText1: TextStyle(
          letterSpacing: -0.25, fontSize: 14, fontWeight: FontWeight.w400),
      bodyText2: TextStyle(
          letterSpacing: -0.25, fontSize: 16, fontWeight: FontWeight.w400),
    ).apply(bodyColor: guocolor.white, displayColor: guocolor.secondary3),

  );
}
