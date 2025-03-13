import 'package:canc_app/core/theming/app_colors.dart';
import 'package:flutter/material.dart';

var appLightTheme = ThemeData(
  brightness: Brightness.light,
  scaffoldBackgroundColor: AppColors.offWhite,
  primaryColor: AppColors.primaryColor,
  colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primaryColor),
  appBarTheme: const AppBarTheme(
    foregroundColor: Colors.white,
  ),
  useMaterial3: true,
);
