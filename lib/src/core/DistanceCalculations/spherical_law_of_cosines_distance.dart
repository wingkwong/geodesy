import '../core.dart';

/// A Spherical Law Of Cosines class for calculating the distance between two geographical points
/// using the Spherical Law of Cosines formula.
class SphericalLawOfCosines {
  /// Calculates the distance between two geographic points using the
  /// Spherical Law of Cosines formula and the Earth's radius.
  ///
  /// The Spherical Law of Cosines formula provides a more accurate
  /// method for calculating distances between two points on the Earth's
  /// surface, taking into account the curvature of the Earth.
  ///
  /// [point1] - The first LatLng object representing the latitude and
  ///            longitude coordinates of the first point.
  ///
  /// [point2] - The second LatLng object representing the latitude and
  ///            longitude coordinates of the second point.
  ///
  /// Returns the distance between the two points in meters, calculated
  /// using the Spherical Law of Cosines formula.
  static double sphericalLawOfCosinesDistance(LatLng point1, LatLng point2) {
    // Mean Earth radius in meters.
    const double radius = 6371000.0;

    if (point1.latitude == point2.latitude &&
        ((point2.longitude - point1.longitude) % 360 == 0 ||
            point1.latitude.abs() == 90)) {
      return 0;
    }

    // Convert latitude and longitude values to radians.
    double lat1 = (point1.latitude).toRadians();
    double lon1 = (point1.longitude).toRadians();
    double lat2 = (point2.latitude).toRadians();
    double lon2 = (point2.longitude).toRadians();

    // Calculate the difference in longitude.
    double deltaLon = lon2 - lon1;

    // Calculate the distance using the Spherical Law of Cosines formula.
    final cosAngle =
        sin(lat1) * sin(lat2) + cos(lat1) * cos(lat2) * cos(deltaLon);
    // Floating-point rounding can put the cosine just outside [-1, 1].
    double distance = acos(cosAngle.clamp(-1.0, 1.0)) * radius;

    return distance;
  }
}
