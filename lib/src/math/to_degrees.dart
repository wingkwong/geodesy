import '../core/core.dart';

/// Degree Conversion Extension
extension DegreeConversion on num {
  /// Convert Value to Degree
  double toDegrees() {
    return this.toDouble() * (180.0 / pi);
  }
}
