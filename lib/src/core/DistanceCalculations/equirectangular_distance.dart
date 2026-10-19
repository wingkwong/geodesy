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
  /// Returns the distance between the two points in meters, calculated
  /// using the Equirectangular approximation formula.
  static double equirectangularDistance(LatLng point1, LatLng point2) {
    // Mean Earth radius in meters.
    const double radius = 6371000.0;

    final lat1 = point1.latitude.toRadians();
    final lat2 = point2.latitude.toRadians();
    // Wrap the difference before converting to radians so short dateline
    // crossings are treated the same as other nearby pairs.
    final deltaLon =
        ((point2.longitude - point1.longitude + 180) % 360 - 180).toRadians();

    // Calculate the differences in longitude and latitude.
    double x = deltaLon * (radius * cos((lat1 + lat2) / 2));
    double y = (lat2 - lat1) * radius;

    // Calculate the distance using the Pythagorean theorem.
    double distance = sqrt(x * x + y * y);

    return distance;
  }
}
