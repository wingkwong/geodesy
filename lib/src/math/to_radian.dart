import '../core/core.dart';

/// Angle Conversion Extension
extension AngleConversion on double {
  /// Convert the double value to Radian
  double toRadians() {
    return this * (pi / 180.0);
  }
}
