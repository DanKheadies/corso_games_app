import 'package:flutter/material.dart';

Color cgBlack = const Color(0xFF0b0b0b);
Color cgBlack2 = const Color(0xFF1a1a1a); // 0xFF151515
Color cgGreen1 = const Color(0xFF669966);
Color cgGreen2 = const Color(0xFF456445);
Color cgPink1 = const Color(0xFFff7d81); // 0xFFff7d81 // 0xFFF57D81
Color cgPink2 = const Color(0xFFb3585a);
Color cgRedViolet = const Color(0xFFc0416f);
Color cgWhite = const Color(0xFFf9f9f9);
Color cgYellow = const Color(0xFFfff8e1); // 0xFFfff8e1 // 0xFFFEF7CC

ThemeData lightTheme() {
  return ThemeData.light().copyWith(
    primaryColor: cgRedViolet,
    colorScheme: const ColorScheme.light().copyWith(
      primary: cgRedViolet,
      secondary: cgPink1,
      tertiary: cgGreen1,
      // background: cgWhite,
      surface: cgBlack,
      error: const Color(0xaaFF0000),
      brightness: Brightness.light,
      onPrimary: cgRedViolet,
      onSecondary: cgPink2,
      onTertiary: cgGreen2,
      onError: const Color(0xFFffffff),
      // onBackground: cgBlack,
      onSurface: cgWhite,
    ),
    scaffoldBackgroundColor: cgYellow,
    snackBarTheme: SnackBarThemeData(
      backgroundColor: cgBlack,
    ),
    iconTheme: IconThemeData(
      color: cgWhite,
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.transparent,
      iconTheme: IconThemeData(
        color: cgWhite,
      ),
    ),
  );
}

ThemeData darkTheme() {
  return ThemeData.dark().copyWith(
    primaryColor: cgRedViolet,
    colorScheme: const ColorScheme.light().copyWith(
      primary: cgRedViolet,
      secondary: cgPink2,
      tertiary: cgGreen2,
      // background: cgBlack,
      surface: cgWhite,
      error: const Color(0xaaFF0000),
      brightness: Brightness.dark,
      onPrimary: cgRedViolet,
      onSecondary: cgPink1,
      onTertiary: cgGreen1,
      onError: const Color(0xFF000000),
      // onBackground: cgWhite,
      onSurface: cgBlack,
    ),
    scaffoldBackgroundColor: cgBlack2,
    snackBarTheme: SnackBarThemeData(
      backgroundColor: cgWhite,
    ),
    iconTheme: IconThemeData(
      color: cgBlack,
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.transparent,
      iconTheme: IconThemeData(
        color: cgBlack,
      ),
    ),
  );
}
