import '../core.dart';

/// PolyLine Class Calculate the length of a polyLine formed by
/// connecting multiple points
class PolyLine {
  /// Calculate the distance between consecutive points using the distance
  /// method from the Distance class. The distances are accumulated
  /// to calculate the total length of the polyLine.

  static double calculatePolyLineLength(List<LatLng> polyLinePoints) {
    final Distance distance = const Distance();
    double length = 0.0;

    for (int i = 0; i < polyLinePoints.length - 1; i++) {
      length += distance(polyLinePoints[i], polyLinePoints[i + 1]);
    }

    return length;
  }
}
