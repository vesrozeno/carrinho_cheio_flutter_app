import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppTheme {
  AppTheme._();

  static const String _fontFamily = 'Montserrat';

  static TextStyle _textStyle({
    required double size,
    required FontWeight weight,
    required Color color,
  }) {
    return TextStyle(
      fontFamily: _fontFamily,
      fontSize: size,
      fontWeight: weight,
      color: color,
    );
  }

  static TextTheme _buildTextTheme(Color color) {
    return TextTheme(
      displayLarge: _textStyle(
        size: 32,
        weight: FontWeight.w700,
        color: color,
      ),
      displayMedium: _textStyle(
        size: 28,
        weight: FontWeight.w700,
        color: color,
      ),
      displaySmall: _textStyle(
        size: 24,
        weight: FontWeight.w700,
        color: color,
      ),
      headlineMedium: _textStyle(
        size: 20,
        weight: FontWeight.w600,
        color: color,
      ),
      headlineSmall: _textStyle(
        size: 18,
        weight: FontWeight.w600,
        color: color,
      ),
      titleLarge: _textStyle(
        size: 16,
        weight: FontWeight.w600,
        color: color,
      ),
      titleMedium: _textStyle(
        size: 14,
        weight: FontWeight.w500,
        color: color,
      ),
      titleSmall: _textStyle(
        size: 12,
        weight: FontWeight.w500,
        color: color,
      ),
      bodyLarge: _textStyle(
        size: 16,
        weight: FontWeight.w400,
        color: color,
      ),
      bodyMedium: _textStyle(
        size: 14,
        weight: FontWeight.w400,
        color: color,
      ),
      bodySmall: _textStyle(
        size: 12,
        weight: FontWeight.w400,
        color: color,
      ),
      labelLarge: _textStyle(
        size: 14,
        weight: FontWeight.w500,
        color: color,
      ),
      labelMedium: _textStyle(
        size: 12,
        weight: FontWeight.w500,
        color: color,
      ),
      labelSmall: _textStyle(
        size: 10,
        weight: FontWeight.w500,
        color: color,
      ),
    );
  }

  static final ThemeData light = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    fontFamily: _fontFamily,
    textTheme: _buildTextTheme(AppColors.black),

    colorScheme: const ColorScheme.light(
      primary: AppColors.primary,
      secondary: AppColors.primary,
      surface: AppColors.backgroundLight,
      error: AppColors.primary,
    ),

    scaffoldBackgroundColor: AppColors.backgroundLight,
    canvasColor: AppColors.backgroundLight,
    cardColor: AppColors.white,

    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.primary,
      foregroundColor: AppColors.white,
      centerTitle: true,
      titleTextStyle: TextStyle(
        fontFamily: _fontFamily,
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: AppColors.white,
      ),
    ),

    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: AppColors.primary,
      foregroundColor: AppColors.white,
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.white,
        textStyle: const TextStyle(
          fontFamily: _fontFamily,
          fontSize: 14,
          fontWeight: FontWeight.w600,
        ),
      ),
    ),

    inputDecorationTheme: const InputDecorationTheme(
      labelStyle: TextStyle(
        fontFamily: _fontFamily,
        fontSize: 14,
        color: AppColors.black,
      ),
      hintStyle: TextStyle(
        fontFamily: _fontFamily,
        fontSize: 14,
        color: AppColors.grey,
      ),
    ),
  );

  static final ThemeData dark = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    fontFamily: _fontFamily,
    textTheme: _buildTextTheme(AppColors.white),

    colorScheme: const ColorScheme.dark(
      primary: AppColors.primary,
      secondary: AppColors.cardDark,
      surface: AppColors.backgroundDark,
      error: AppColors.white,
    ),

    scaffoldBackgroundColor: AppColors.backgroundDark,
    canvasColor: AppColors.backgroundDark,
    cardColor: AppColors.cardDark,

    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.cardDark,
      foregroundColor: AppColors.white,
      centerTitle: true,
      titleTextStyle: TextStyle(
        fontFamily: _fontFamily,
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: AppColors.white,
      ),
    ),

    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: AppColors.primary,
      foregroundColor: AppColors.white,
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.white,
        textStyle: const TextStyle(
          fontFamily: _fontFamily,
          fontSize: 14,
          fontWeight: FontWeight.w600,
        ),
      ),
    ),

    inputDecorationTheme: const InputDecorationTheme(
      labelStyle: TextStyle(
        fontFamily: _fontFamily,
        fontSize: 14,
        color: AppColors.white,
      ),
      hintStyle: TextStyle(
        fontFamily: _fontFamily,
        fontSize: 14,
        color: AppColors.grey,
      ),
    ),
  );
}
