import '../core.dart';

/// Rectangle Bounds class for calculating the bounding rectangle of a set of LatLng points.
class RectangleBounds {
  /// Calculates the bounding rectangle (four corner points) that encloses a list
  /// of LatLng coordinates.
  ///
  /// [polygonCoords] - A list of LatLng coordinates to calculate the bounding
  ///                   rectangle for.
  ///
  /// Returns a list of LatLng points representing the corners of the bounding
  /// rectangle, ordered in the following sequence:
  ///
  /// 1. Bottom-left corner
  /// 2. Bottom-right corner
  /// 3. Top-right corner
  /// 4. Top-left corner
  ///
  /// The bounding rectangle encompasses all the points provided in the input list.
  static List<LatLng> getRectangleBounds(List<LatLng> polygonCoords) {
    num minLatitude = double.infinity.toDouble();
    num maxLatitude = double.negativeInfinity.toDouble();
    num minLongitude = double.infinity.toDouble();
    num maxLongitude = double.negativeInfinity.toDouble();

    for (LatLng coord in polygonCoords) {
      if (coord.latitude < minLatitude) {
        minLatitude = coord.latitude;
      }
      if (coord.latitude > maxLatitude) {
        maxLatitude = coord.latitude;
      }
      if (coord.longitude < minLongitude) {
        minLongitude = coord.longitude;
      }
      if (coord.longitude > maxLongitude) {
        maxLongitude = coord.longitude;
      }
    }

    List<LatLng> rectangleBounds = [
      LatLng(minLatitude.toDouble(), minLongitude.toDouble()),
      LatLng(minLatitude.toDouble(), maxLongitude.toDouble()),
      LatLng(maxLatitude.toDouble(), maxLongitude.toDouble()),
      LatLng(maxLatitude.toDouble(), minLongitude.toDouble()),
    ];

    return rectangleBounds;
  }
}
