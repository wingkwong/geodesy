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
  /// Returns the distance between the two points in kilometers, calculated
  /// using the Spherical Law of Cosines formula.
  static double sphericalLawOfCosinesDistance(LatLng point1, LatLng point2) {
    // Earth's radius in kilometers.
    final double radius = 6371.0;

    // Convert latitude and longitude values to radians.
    double lat1 = (point1.latitude).toRadians();
    double lon1 = (point1.longitude).toRadians();
    double lat2 = (point2.latitude).toRadians();
    double lon2 = (point2.longitude).toRadians();

    // Calculate the difference in longitude.
    double deltaLon = lon2 - lon1;

    // Calculate the distance using the Spherical Law of Cosines formula.
    double distance =
        acos(sin(lat1) * sin(lat2) + cos(lat1) * cos(lat2) * cos(deltaLon)) *
            radius;

    return distance;
  }
}
