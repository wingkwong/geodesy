import '../core/core.dart';

/// Angle Conversion Extension
extension RadianConversion on num {
  /// Convert the double value to Radian
  double toRadians() {
    return this * (pi / 180.0);
  }
}
