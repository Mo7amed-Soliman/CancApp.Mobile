import 'package:flutter/material.dart';

class AppColors {
  const AppColors._();

  // grays
  static const Color lightGray = Color(0xFFF5F5F5);
  static const Color mediumGray = Color(0xFFB2B2B2);
  static const Color darkGray = Color(0xFF263238);
  static const Color grayish = Color(0xFF676666);

  // primary
  static const Color primaryColor = Color(0xFF00A79D);
  static const Color darkTeal = Color(0xFF02635D);
  static const Color lightTeal = Color(0xFF03C5B9);

  // gradients
  static const List<Color> primaryGradient = [
    darkTeal,
    lightTeal,
  ];

  // background
  static const Color offWhite = Color(0xFFFCFCFC);

  // for specific users
  static const Color deepBlue = Color(0xFF074799);
  static const Color purple = Color(0xFF7E5CAD);
  static const Color mintGreen = Color(0xFF16C47F);
  static const Color red = Color(0xFFFB4141);
  static const Color orange = Color(0xFFFF9D23);
}
