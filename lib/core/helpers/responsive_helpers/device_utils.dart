import 'package:canc_app/core/helpers/responsive_helpers/size_helper_extension.dart';
import 'package:flutter/material.dart';

enum DeviceType { mobile, tablet, desktop }

class DeviceUtils {
  // Screen breakpoint constants
  static const double _mobileBreakpoint = 600;
  static const double _tabletBreakpoint = 1200;

  // -- Device Type Detection --
  /// Determines device type based on screen width
  static DeviceType _getDeviceType(BuildContext context) {
    final width = context.screenWidth;
    if (width < _mobileBreakpoint) return DeviceType.mobile;
    if (width < _tabletBreakpoint) return DeviceType.tablet;
    return DeviceType.desktop;
  }

  /// Checks if device is mobile (screen width < 600)
  static bool isMobile(BuildContext context) =>
      _getDeviceType(context) == DeviceType.mobile;

  /// Checks if device is tablet (600 ≤ screen width < 1200)
  static bool isTablet(BuildContext context) =>
      _getDeviceType(context) == DeviceType.tablet;

  /// Checks if device is desktop (screen width ≥ 1200)
  static bool isDesktop(BuildContext context) =>
      _getDeviceType(context) == DeviceType.desktop;

  // -- Responsive Value Resolution --
  /// Returns value based on device type with fallback support
  ///
  /// Usage:
  /// ```dart
  /// DeviceUtils.valueDecider(
  ///   context,
  ///   onMobile: MobileView(),
  ///   onTablet: TabletView(),
  ///   onDesktop: DesktopView(),
  ///   fallback: DefaultView(),
  /// )
  /// ```
  static T valueDecider<T>(
    BuildContext context, {
    required T onMobile,
    T? onTablet,
    T? onDesktop,
    T? fallback,
  }) {
    switch (_getDeviceType(context)) {
      case DeviceType.mobile:
        return onMobile;
      case DeviceType.tablet:
        return onTablet ?? fallback ?? onMobile;
      case DeviceType.desktop:
        return onDesktop ?? fallback ?? onMobile;
    }
  }
}
