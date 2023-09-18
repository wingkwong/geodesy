import '../core.dart';

/// A Great Circle Point class for calculating points along the great circle arc
/// connecting two LatLng points.
class GreatCirclePoint {
  /// Calculates a list of points along the great circle arc connecting
  /// the [startPoint] and [endPoint].
  ///
  /// It uses linear interpolation to calculate intermediate points at equally
  /// spaced intervals along the arc.
  ///
  /// [startPoint] - The starting LatLng point of the great circle arc.
  ///
  /// [endPoint] - The ending LatLng point of the great circle arc.
  ///
  /// [numPoints] - The number of points to calculate along the arc, including
  ///               the start and end points.
  ///
  /// Returns a list of LatLng points representing points along the great circle arc.
  static List<LatLng> calculatePointsAlongGreatCircle(
      LatLng startPoint, LatLng endPoint, int numPoints) {
    final List<LatLng> points = <LatLng>[];

    // Convert degrees to radians
    final double startLat = startPoint.latitude * (pi / 180.0);
    final double startLon = startPoint.longitude * (pi / 180.0);
    final double endLat = endPoint.latitude * (pi / 180.0);
    final double endLon = endPoint.longitude * (pi / 180.0);

    final double delta = 1.0 / numPoints;

    for (int i = 0; i <= numPoints; i++) {
      final double t = i * delta;
      double lat = startLat * (1 - t) + endLat * t;
      double lon = startLon * (1 - t) + endLon * t;

      // Convert radians back to degrees
      lat = lat * (180.0 / pi);
      lon = lon * (180.0 / pi);

      points.add(LatLng(lat, lon));
    }

    return points;
  }
}
