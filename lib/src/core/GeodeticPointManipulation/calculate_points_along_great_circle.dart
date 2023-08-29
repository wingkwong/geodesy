import '../core.dart';

///  Geodetic Point Manipulation - Calculate Point Along Great Circle
class GreatCirclePoint {
  /// calculates a list of points along the great circle arc connecting
  /// the startPoint and endPoint.
  /// It uses linear interpolation to calculate the intermediate points
  /// at equally spaced intervals along the arc.
  static List<LatLng> calculatePointsAlongGreatCircle(
      LatLng startPoint, LatLng endPoint, int numPoints) {
    final List<LatLng> points = <LatLng>[];

    final double startLat =
        startPoint.latitude * (pi / 180.0); // Convert degrees to radians
    final double startLon = startPoint.longitude * (pi / 180.0);
    final double endLat = endPoint.latitude * (pi / 180.0);
    final double endLon = endPoint.longitude * (pi / 180.0);

    final double delta = 1.0 / numPoints;

    for (int i = 0; i <= numPoints; i++) {
      final double t = i * delta;
      double lat = startLat * (1 - t) + endLat * t;
      double lon = startLon * (1 - t) + endLon * t;

      lat = lat * (180.0 / pi); // Convert radians to degrees
      lon = lon * (180.0 / pi);

      points.add(LatLng(lat, lon));
    }

    return points;
  }
}
