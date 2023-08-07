import 'core.dart';

///
class RectangleBounds {
  /// GetRectangleBounds
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
