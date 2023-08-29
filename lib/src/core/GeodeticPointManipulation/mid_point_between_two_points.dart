import '../core.dart';

///  Geodetic Point Manipulation - Midpoint between two points
class MidPointBetweenTwoPoints {
  /// Calculate the midpoint between two points on the Earth's surface
  /// (specified by their latitude and longitude),
  static LatLng calculateMidpoint(LatLng point1, LatLng point2) {
    double lat1 = point1.latitude * (pi / 180.0); // Convert degrees to radians
    double lon1 = point1.longitude * (pi / 180.0);
    double lat2 = point2.latitude * (pi / 180.0);
    double lon2 = point2.longitude * (pi / 180.0);

    double midLat = (lat1 + lat2) / 2;
    double midLon = (lon1 + lon2) / 2;

    midLon = (midLon + pi) % (2 * pi) - pi; // Normalize to -π to π radians

    return LatLng(midLat * (180.0 / pi),
        midLon * (180.0 / pi)); // Convert radians to degrees
  }
}
