import '../core.dart';

/// A Point Range class for working with geographical points and ranges.
class PointRange {
  /// Get a list of [LatLng] points within a specified distance from a given point.
  ///
  /// This function takes a central point, a list of points to check, and a distance
  /// (in meters) to determine which points from the list fall within the specified
  /// range.
  ///
  /// [point] - The central [LatLng] point from which the distance is measured.
  ///
  /// [pointsToCheck] - A list of [LatLng] points to be checked for proximity to the
  ///                   central point.
  ///
  /// [distance] - The maximum distance (in meters) within which points are considered
  ///              to be within range of the central point.
  ///
  /// Returns a list of [LatLng] points that are within the specified distance from
  /// the central point.
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
