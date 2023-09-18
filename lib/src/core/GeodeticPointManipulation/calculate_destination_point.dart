import '../core.dart';

/// A Destination Point class for calculating destination points on the Earth's surface
/// using the Rhumb Line Destination formula.
class DestinationPoint {
  /// Calculates the destination point on the Earth's surface given an initial point
  /// (latitude and longitude), a bearing (azimuth) in degrees, and a distance in
  /// kilometers. This formula provides an approximate destination point when
  /// traveling along a constant compass direction.
  ///
  /// [initialPoint] - The initial LatLng point representing the starting location.
  ///
  /// [bearingDegrees] - The bearing or azimuth angle in degrees, indicating the
  ///                    compass direction from the initial point.
  ///
  /// [distanceKm] - The distance in kilometers to travel along the constant bearing
  ///                direction from the initial point to the destination point.
  ///
  /// Returns a new LatLng object representing the destination point's latitude and
  /// longitude coordinates.
  static LatLng calculateDestinationPoint(
      LatLng initialPoint, double bearingDegrees, double distanceKm) {
    final double radius = 6371.0; // Earth's radius in kilometers
    final double bearing = bearingDegrees * pi / 180.0;

    double lat1 = initialPoint.latitude * pi / 180.0;
    double lon1 = initialPoint.longitude * pi / 180.0;

    double lat2 = lat1 + (distanceKm / radius) * cos(bearing);
    double lon2 = lon1 + (distanceKm / radius) * sin(bearing) / cos(lat1);

    double destinationLatitude = lat2 * 180.0 / pi;
    double destinationLongitude = lon2 * 180.0 / pi;

    return LatLng(destinationLatitude, destinationLongitude);
  }
}
