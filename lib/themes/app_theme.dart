// lib/themes/app_theme.dart

import 'package:flutter/material.dart';

import 'colors.dart';

ThemeData lightTheme = ThemeData(
  appBarTheme: const AppBarTheme(
    backgroundColor: LightColors.gray1,
  ),
  colorScheme: const ColorScheme(
    onPrimary: CommonColors.onWhite, //required
    onSecondary: CommonColors.onWhite, //required
    primary: Color(0xFF3F51B5), // point color1
    primaryContainer: LightColors.indigo2, // point color2
    secondary: LightColors.blue, // point color3
    background: LightColors.gray1, // app backgound
    surface: LightColors.gray2, // card background
    outline: LightColors.gray3, // card line or divider
    surfaceVariant: LightColors.gray4, // disabled
    onSurface: LightColors.gray5, // text3
    onSurfaceVariant: LightColors.gray6, //text2
    onBackground: LightColors.important, //text1
    error: CommonColors.red, // danger
    tertiary: CommonColors.yellow, // normal
    tertiaryContainer: CommonColors.green, // safe

    onError: LightColors.basic, //no use
    brightness: Brightness.light,
  ),
  textTheme: const TextTheme().apply(
    bodyColor: LightColors.gray6,
    displayColor: LightColors.gray6,
  ),
);

ThemeData darkTheme = ThemeData(
  appBarTheme: const AppBarTheme(
    backgroundColor: DarkColors.gray1,
  ),
  colorScheme: const ColorScheme(
    onPrimary: CommonColors.onWhite, //required
    onSecondary: CommonColors.onWhite, //required
    primary: DarkColors.indigo1, // point color1
    primaryContainer: DarkColors.indigo2, // point color2
    secondary: DarkColors.blue, // point color3
    background: DarkColors.gray1, // app backgound
    surface: DarkColors.gray2, // card background
    outline: DarkColors.gray3, // card line or divider
    surfaceVariant: DarkColors.gray4, // disabled
    onSurface: DarkColors.important, //text3
    onSurfaceVariant: DarkColors.gray6, // text2
    onBackground: DarkColors.important, //text1
    error: CommonColors.red, // danger
    tertiary: CommonColors.yellow, // normal
    tertiaryContainer: CommonColors.green, // safe

    onError: DarkColors.basic, // no use
    brightness: Brightness.light,
  ),
  textTheme: const TextTheme(
          // displayLarge: TextStyle(color: DarkColors.gray6),
          // displayMedium: TextStyle(color: DarkColors.gray6),
          // displaySmall: TextStyle(color: DarkColors.gray6),
          // headlineLarge: TextStyle(color: DarkColors.gray6),
          // headlineMedium: TextStyle(color: DarkColors.gray6),
          // headlineSmall: TextStyle(color: DarkColors.gray6),
          // titleLarge: TextStyle(color: DarkColors.gray6),
          // titleMedium: TextStyle(color: DarkColors.gray6),
          // titleSmall: TextStyle(color: DarkColors.gray6),
          // bodyLarge: TextStyle(color: DarkColors.gray6),
          // bodyMedium: TextStyle(color: DarkColors.gray6),
          // bodySmall: TextStyle(color: DarkColors.gray6),
          // labelLarge: TextStyle(color: DarkColors.gray6),
          // labelMedium: TextStyle(color: DarkColors.gray6),
          // labelSmall: TextStyle(color: DarkColors.gray6),
          )
      .apply(
    bodyColor: DarkColors.gray6,
    displayColor: DarkColors.gray6,
  ),
);
