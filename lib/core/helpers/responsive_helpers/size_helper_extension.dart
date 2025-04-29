import 'dart:math';

import 'package:canc_app/core/helpers/responsive_helpers/device_utils.dart';
import 'package:canc_app/core/helpers/responsive_helpers/size_provider.dart';
import 'package:flutter/material.dart';

extension SizeHelperExtension on BuildContext {
  // Clamping configuration constants
  static const double _kMinScaleClamp = 0.8;
  static const double _kMaxScaleClamp = 1.42;

  // -- Orientation Detection --
  /// Checks if device is in landscape orientation
  bool get isLandscape =>
      MediaQuery.of(this).orientation == Orientation.landscape;

  // -- Screen Dimensions --
  /// Returns screen width adjusted for orientation
  double get screenWidth => isLandscape
      ? MediaQuery.of(this).size.height
      : MediaQuery.of(this).size.width;

  /// Returns screen height adjusted for orientation
  double get screenHeight => isLandscape
      ? MediaQuery.of(this).size.width
      : MediaQuery.of(this).size.height;

  // -- Size Provider Access --
  /// Gets the nearest SizeProvider instance
  SizeProvider get sizeProvider => SizeProvider.of(this);

  // -- Scaling Factors --
  /// Width scaling ratio (current width / base width)
  double get widthScale => sizeProvider.width / sizeProvider.baseSize.width;

  /// Height scaling ratio (current height / base height)
  double get heightScale => sizeProvider.height / sizeProvider.baseSize.height;

  /// Minimum scaling factor between width and height ratios
  double get minScaleFactor => min(widthScale, heightScale);

  // -- Responsive Sizing Methods --
  /// Scales width relative to base design width with device-specific adjustments
  double setWidth(num width) => _scaleAndClamp(
        value: width,
        scaleFactor: _deviceSpecificWidthScale(),
      );

  /// Scales height relative to base design height with device-specific adjustments
  double setHeight(num height) => _scaleAndClamp(
        value: height,
        scaleFactor: _deviceSpecificHeightScale(),
      );

  /// Scales size using minimum of width/height ratios (maintains proportions)
  double setMinSize(num size) => size * minScaleFactor;

  /// Responsive font sizing with width-based scaling and clamping
  double setSp(num fontSize) => _scaleAndClamp(
        value: fontSize,
        scaleFactor: _deviceSpecificWidthScale(),
      );

  // -- Private Helpers --
  double _deviceSpecificWidthScale() {
    if (DeviceUtils.isMobile(this)) return widthScale * 0.85;
    if (DeviceUtils.isTablet(this)) return widthScale * 0.85;
    if (DeviceUtils.isDesktop(this)) return widthScale * 0.9;
    return widthScale;
  }

  double _deviceSpecificHeightScale() {
    if (DeviceUtils.isMobile(this)) return heightScale;
    if (DeviceUtils.isTablet(this)) return heightScale * 1.1;
    if (DeviceUtils.isDesktop(this)) return heightScale;
    return heightScale;
  }

  double _scaleAndClamp({
    required num value, // 10
    required double scaleFactor, // 2
  }) {
    final scaledValue = value * scaleFactor; // 20
    final lowerLimit = value * _kMinScaleClamp; // 10 *0.8 = 8
    final upperLimit = value * _kMaxScaleClamp; // 10 * 1.4 = 14
    return scaledValue.clamp(lowerLimit, upperLimit); // 14
  }
}
