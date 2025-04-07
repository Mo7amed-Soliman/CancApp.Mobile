import 'package:flutter/material.dart';

/// Model for navigation items in the bottom navigation bar
class NavigationItemModel {
  /// The icon to display when the item is not selected
  final IconData icon;

  /// The icon to display when the item is selected
  final IconData activeIcon;

  /// The label text for the navigation item
  final String label;

  /// Creates a navigation item model
  const NavigationItemModel({
    required this.icon,
    required this.activeIcon,
    required this.label,
  });
}
