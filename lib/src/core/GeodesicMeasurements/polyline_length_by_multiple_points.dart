import '../core.dart';

/// A PolyLine class for calculating the length of a polyline formed by connecting
/// multiple points.
class PolyLine {
  /// Calculates the length of a polyline by summing the distances between
  /// consecutive points using the Haversine distance formula.
  ///
  /// [polyLinePoints] - A list of LatLng points representing the vertices of the
  ///                    polyline, ordered in the sequence they are connected.
  ///
  /// Returns the total length of the polyline in meters.
  static double calculatePolyLineLength(List<LatLng> polyLinePoints) {
    final Distance distance = const Distance();
    double length = 0.0;

    for (int i = 0; i < polyLinePoints.length - 1; i++) {
      length += distance(polyLinePoints[i], polyLinePoints[i + 1]);
    }

    return length;
  }
}
