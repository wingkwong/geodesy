import '../core.dart';

/// Geodetic Point Manipulation - Rhumb Line Destination Formula

class DestinationPoint {
  /// Calculate the destination point given an initial point
  /// (latitude and longitude), a bearing (azimuth), and a distance,
  /// you can use the formula known as the "Direct Rhumb Line" formula or
  /// "Rhumb Line Destination" formula.
  /// This formula provides an approximate destination point when traveling
  ///  along a constant compass direction.
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
