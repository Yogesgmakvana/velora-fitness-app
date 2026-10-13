import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

class AppTheme {
  AppTheme._();

  static ThemeData get darkTheme {
    return ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: AppColors.background,
      primaryColor: AppColors.primaryNeon,
      colorScheme: const ColorScheme.dark(
        primary: AppColors.primaryNeon,
        surface: AppColors.cardBackground,
      ),
      fontFamily: 'sans-serif',
      useMaterial3: true,
    );
  }
}
