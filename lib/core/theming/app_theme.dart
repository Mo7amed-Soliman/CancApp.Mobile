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
  timePickerTheme: TimePickerThemeData(
    backgroundColor: AppColors.offWhite,
    dialHandColor: AppColors.primaryColor,
    hourMinuteColor: AppColors.primaryColor.withValues(alpha: 0.1),
    hourMinuteTextColor: AppColors.primaryColor,
    dialTextColor: AppColors.darkGray,
    entryModeIconColor: AppColors.primaryColor,
    dayPeriodColor: AppColors.primaryColor.withValues(alpha: 0.1),
    dayPeriodTextColor: AppColors.primaryColor,
    dialBackgroundColor: Colors.grey[50],
    confirmButtonStyle: TextButton.styleFrom(
      backgroundColor: AppColors.primaryColor,
      foregroundColor: Colors.white,
    ),
    cancelButtonStyle: TextButton.styleFrom(
      backgroundColor: Colors.white,
      foregroundColor: AppColors.red,
    ),
  ),
  datePickerTheme: DatePickerThemeData(
    backgroundColor: AppColors.offWhite,
    headerBackgroundColor: AppColors.primaryColor,
    headerForegroundColor: AppColors.offWhite,
    confirmButtonStyle: TextButton.styleFrom(
      backgroundColor: AppColors.primaryColor,
      foregroundColor: Colors.white,
    ),
    cancelButtonStyle: TextButton.styleFrom(
      backgroundColor: Colors.white,
      foregroundColor: AppColors.red,
    ),
  ),
);
