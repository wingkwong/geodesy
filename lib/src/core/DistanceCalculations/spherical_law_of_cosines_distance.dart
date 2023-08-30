import '../core.dart';

/// Calculate Spherical Law Of Cosines Distance
class SphericalLawOfCosines {
  /// This function takes two LatLng objects representing the latitude and
  /// longitude coordinates of two points. It calculates the distance
  /// between the points using the Spherical Law of Cosines formula
  /// and the Earth's radius.
  static double sphericalLawOfCosinesDistance(LatLng point1, LatLng point2) {
    final double radius = 6371.0; // Earth's radius in kilometers

    double lat1 = (point1.latitude).toRadians();
    double lon1 = (point1.longitude).toRadians();
    double lat2 = (point2.latitude).toRadians();
    double lon2 = (point2.longitude).toRadians();

    double deltaLon = lon2 - lon1;

    double distance =
        acos(sin(lat1) * sin(lat2) + cos(lat1) * cos(lat2) * cos(deltaLon)) *
            radius;

    return distance;
  }
}
