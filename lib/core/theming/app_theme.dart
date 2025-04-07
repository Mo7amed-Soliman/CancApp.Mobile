import 'package:canc_app/core/theming/app_colors.dart';
import 'package:flutter/material.dart';

var appLightTheme = ThemeData(
  brightness: Brightness.light,
  useMaterial3: true,
  scaffoldBackgroundColor: AppColors.offWhite,
  primaryColor: AppColors.primaryColor,
  colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primaryColor),
  appBarTheme: const AppBarTheme(
    foregroundColor: Colors.white,
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    backgroundColor: Colors.white,
    selectedItemColor: AppColors.primaryColor,
    unselectedItemColor: Colors.grey,
    selectedIconTheme: IconThemeData(color: AppColors.primaryColor),
    unselectedIconTheme: IconThemeData(color: Colors.grey),
    type: BottomNavigationBarType.fixed,
  ),
);
