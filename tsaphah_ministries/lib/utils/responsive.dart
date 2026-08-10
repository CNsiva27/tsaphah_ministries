import 'package:flutter/material.dart';

/// Simple breakpoint helper used across the app to switch between
/// mobile / tablet / desktop layouts.
class Responsive {
  Responsive._();

  static const double mobileMax = 600;
  static const double tabletMax = 900;
  static const double desktopMax = 1200;

  static bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < mobileMax;

  static bool isTablet(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    return w >= mobileMax && w < tabletMax;
  }

  static bool isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width >= tabletMax;

  /// Number of gallery columns based on current width.
  static int galleryColumns(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    if (w < mobileMax) return 2;
    if (w < tabletMax) return 3;
    if (w < desktopMax) return 4;
    return 5;
  }

  /// Clamp content width on very large screens so text doesn't
  /// stretch edge-to-edge.
  static double contentMaxWidth(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    return w > 1180 ? 1180 : w;
  }
}
