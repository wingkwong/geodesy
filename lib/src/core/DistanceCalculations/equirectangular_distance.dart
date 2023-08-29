import '../core.dart';

/// Equirectangular approximation Calculation
class EquirectangularApproximation {
  /// EquirectangularDistance function takes two LatLng objects representing the
  /// latitude and longitude coordinates of two points. It calculates the
  /// distance between the points using the Equirectangular
  /// approximation formula and the Earth's radius.
  static double equirectangularDistance(LatLng point1, LatLng point2) {
    final double radius = 6371.0; // Earth's radius in kilometers

    double lat1 = point1.latitude;
    double lon1 = point1.longitude;
    double lat2 = point2.latitude;
    double lon2 = point2.longitude;

    double x = (lon2 - lon1) * (radius * cos((lat1 + lat2) / 2));
    double y = (lat2 - lat1) * radius;

    // Calculate distance using Pythagorean theorem
    double distance = sqrt(x * x + y * y);

    return distance;
  }
}
