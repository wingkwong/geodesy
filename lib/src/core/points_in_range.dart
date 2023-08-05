import 'core.dart';

/// Get a list of [LatLng] points within a distance from
/// a given point
/// Distance is in meters
List<LatLng> pInRange(LatLng point, List<LatLng> pointsToCheck, num distance) {
  final geoFencedPoints = <LatLng>[];
  for (final LatLng p in pointsToCheck) {
    if (dBetweenTwoGeoPoints(point, p) <= distance) {
      geoFencedPoints.add(p);
    }
  }
  return geoFencedPoints;
}
