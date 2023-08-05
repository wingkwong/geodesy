import 'core.dart';

///
class PointRange {
  /// Get a list of [LatLng] points within a distance from
  /// a given point
  /// Distance is in meters
  static List<LatLng> pointInRange(
      LatLng point, List<LatLng> pointsToCheck, num distance) {
    final geoFencedPoints = <LatLng>[];
    for (final LatLng p in pointsToCheck) {
      if (GeoPoints.distanceBetweenTwoGeoPoints(point, p) <= distance) {
        geoFencedPoints.add(p);
      }
    }
    return geoFencedPoints;
  }
}
