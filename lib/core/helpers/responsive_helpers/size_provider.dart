import 'package:flutter/material.dart';

/// A responsive layout InheritedWidget that provides screen sizing information
/// to descendant widgets in the tree.
///
/// Maintains reference to both the original design size (baseSize) and current
/// screen dimensions, enabling proportional scaling of UI elements.
class SizeProvider extends InheritedWidget {
  /// The reference design size used for proportional scaling calculations
  /// (typically based on the design mockup dimensions)
  final Size baseSize;

  /// Current screen width in logical pixels
  final double width;

  /// Current screen height in logical pixels
  final double height;

  const SizeProvider({
    super.key,
    required super.child,
    required this.baseSize,
    required this.width,
    required this.height,
  });
  // Returns the nearest SizeProvider instance in the widget hierarchy
  static SizeProvider of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<SizeProvider>()!;

  /// Determines whether widgets depending on the sizing data
  /// should be notified of changes
  ///
  /// Notifies when:
  /// - Base design size changes
  /// - Screen width changes
  /// - Screen height changes
  /// - Child widget changes
  @override
  bool updateShouldNotify(SizeProvider oldWidget) =>
      baseSize != oldWidget.baseSize ||
      width != oldWidget.width ||
      height != oldWidget.height ||
      child != oldWidget.child;
}
