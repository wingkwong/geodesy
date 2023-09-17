import '../core.dart';

/// A Equi- Rectangular Approximation class for calculating the distance
/// between two geographical points
/// using the Equirectangular approximation formula.
class EquirectangularApproximation {
  /// Calculates the distance between two geographic points using the
  /// Equirectangular approximation formula and the Earth's radius.
  ///
  /// The Equirectangular approximation formula is a simple method to estimate
  /// the distance between two points on the Earth's surface, assuming a
  /// perfect sphere. While not as accurate as more complex methods, it is
  /// computationally efficient and suitable for shorter distances.
  ///
  /// [point1] - The first LatLng object representing the latitude and longitude
  ///            coordinates of the first point.
  ///
  /// [point2] - The second LatLng object representing the latitude and
  /// longitude  coordinates of the second point.
  ///
  /// Returns the distance between the two points in kilometers, calculated
  /// using the Equirectangular approximation formula.
  static double equirectangularDistance(LatLng point1, LatLng point2) {
    // Earth's radius in kilometers.
    final double radius = 6371.0;

    // Extract latitude and longitude values from the LatLng objects.
    double lat1 = point1.latitude;
    double lon1 = point1.longitude;
    double lat2 = point2.latitude;
    double lon2 = point2.longitude;

    // Calculate the differences in longitude and latitude.
    double x = (lon2 - lon1) * (radius * cos((lat1 + lat2) / 2));
    double y = (lat2 - lat1) * radius;

    // Calculate the distance using the Pythagorean theorem.
    double distance = sqrt(x * x + y * y);

    return distance;
  }
}
