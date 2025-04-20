import 'package:flutter/material.dart';

/// Model for quick action items in the home screen
class QuickActionItemModel {
  /// The icon to display for the quick action
  final IconData icon;

  /// The title of the quick action
  final String title;

  /// The color theme for the quick action
  final Color color;

  /// Creates a quick action item model
  const QuickActionItemModel({
    required this.icon,
    required this.title,
    required this.color,
  });
}
