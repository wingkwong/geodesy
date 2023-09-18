import '../core.dart';

/// A MidPoint Between Two Points class for calculating the midpoint between two points on the
/// Earth's surface
/// specified by their latitude and longitude.
class MidPointBetweenTwoPoints {
  /// Calculates the midpoint between two points on the Earth's surface specified
  /// by their latitude and longitude coordinates.
  ///
  /// [point1] - The first LatLng point.
  ///
  /// [point2] - The second LatLng point.
  ///
  /// Returns a LatLng object representing the midpoint between the two input points.
  static LatLng calculateMidpoint(LatLng point1, LatLng point2) {
    double lat1 = point1.latitude * (pi / 180.0); // Convert degrees to radians
    double lon1 = point1.longitude * (pi / 180.0);
    double lat2 = point2.latitude * (pi / 180.0);
    double lon2 = point2.longitude * (pi / 180.0);

    double midLat = (lat1 + lat2) / 2;
    double midLon = (lon1 + lon2) / 2;

    // Normalize longitude to the range of -π to π radians
    midLon = (midLon + pi) % (2 * pi) - pi;

    // Convert radians back to degrees
    return LatLng(midLat * (180.0 / pi), midLon * (180.0 / pi));
  }
}
