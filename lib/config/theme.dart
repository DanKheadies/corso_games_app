import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Color black = const Color(0xFF0b0b0b);
Color white = const Color(0xFFf9f9f9);

ThemeData lightTheme() {
  return ThemeData.light().copyWith(
    primaryColor: const Color(0xFFc0416f),
    colorScheme: const ColorScheme.light().copyWith(
      primary: const Color(0xFFc0416f),
      secondary: const Color(0xFFff7d81),
      tertiary: const Color(0xFF669966),
      background: white,
      surface: black,
      error: const Color(0xaaFF0000),
      brightness: Brightness.light,
      onPrimary: const Color(0xFFc0416f),
      onSecondary: const Color(0xFFff7d81),
      onTertiary: const Color(0xFF669966),
      onError: const Color(0xFFffffff),
      onBackground: black,
      onSurface: white,
    ),
    scaffoldBackgroundColor: const Color(0xFFfff8e1),
    snackBarTheme: SnackBarThemeData(
      backgroundColor: black,
    ),
    iconTheme: IconThemeData(
      // color: Color(0xFFc0416f),
      color: white,
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.transparent,
      iconTheme: IconThemeData(
        // color: Color(0xFFc0416f),
        color: white,
      ),
      // systemOverlayStyle: SystemUiOverlayStyle.light,
    ),
    // textTheme: const TextTheme(
    //   titleLarge: TextStyle(
    //     color: Color(0xFF1e272e),
    //   ),
    //   titleMedium: TextStyle(
    //     color: Color(0xFF1e272e),
    //   ),
    //   titleSmall: TextStyle(
    //     color: Color(0xFF1e272e),
    //   ),
    //   bodyLarge: TextStyle(
    //     color: Color(0xFF1e272e),
    //   ),
    //   bodyMedium: TextStyle(
    //     color: Color(0xFF1e272e),
    //   ),
    //   bodySmall: TextStyle(
    //     color: Color(0xFF1e272e),
    //   ),
    // ),
  );
}

ThemeData darkTheme() {
  return ThemeData.dark().copyWith(
    primaryColor: const Color(0xFFc0416f),
    colorScheme: const ColorScheme.light().copyWith(
      primary: const Color(0xFFc0416f),
      secondary: const Color(0xFFb3585a),
      tertiary: const Color(0xFF456445),
      background: black,
      surface: white,
      error: const Color(0xaaFF0000),
      brightness: Brightness.dark,
      onPrimary: const Color(0xFFc0416f),
      onSecondary: const Color(0xFFff7d81),
      onTertiary: const Color(0xFF669966),
      onError: const Color(0xFF000000),
      onBackground: white,
      onSurface: black,
    ),
    scaffoldBackgroundColor: const Color(0xFF1a1a1a),
    snackBarTheme: SnackBarThemeData(
      backgroundColor: white,
    ),
    iconTheme: IconThemeData(
      color: black,
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.transparent,
      iconTheme: IconThemeData(
        color: black,
      ),
      // systemOverlayStyle: SystemUiOverlayStyle.dark,
    ),
    // textTheme: const TextTheme(
    //   titleLarge: TextStyle(
    //     color: Color(0xFFa4c0cc),
    //   ),
    //   titleMedium: TextStyle(
    //     color: Color(0xFFa4c0cc),
    //   ),
    //   titleSmall: TextStyle(
    //     color: Color(0xFFa4c0cc),
    //   ),
    //   bodyLarge: TextStyle(
    //     color: Color(0xFFa4c0cc),
    //   ),
    //   bodyMedium: TextStyle(
    //     color: Color(0xFFa4c0cc),
    //   ),
    //   bodySmall: TextStyle(
    //     color: Color(0xFFa4c0cc),
    //   ),
    // ),
  );
}
