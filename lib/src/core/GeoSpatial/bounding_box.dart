import '../core.dart';

/// A BoundingBox class for calculating bounding boxes and checking if a point is within a bounding box.
class BoundingBox {
  /// Calculates the bounding box (rectangle) around a center point with a specified
  /// distance in kilometers.
  ///
  /// [centerPoint] - The LatLng coordinates of the center point.
  ///
  /// [distanceInKm] - The distance in kilometers from the center point to each side
  ///                   of the bounding box.
  ///
  /// Returns a list of two LatLng points representing the top-left and bottom-right
  /// corners of the bounding box.
  static List<LatLng> calculateBoundingBox(
      LatLng centerPoint, num distanceInKm) {
    // Earth's radius in kilometers
    final num radiusOfEarth = 6371e3 / 1000;
    // Convert latitude to radians
    final num latInRadians = centerPoint.latitude * (pi / 180.0);
    final num degreeLatDistance = (distanceInKm / radiusOfEarth) * (180.0 / pi);
    final num degreeLngDistance = degreeLatDistance / cos(latInRadians);
    final num topLat = centerPoint.latitude + degreeLatDistance;
    final num leftLng = centerPoint.longitude - degreeLngDistance;
    final num bottomLat = centerPoint.latitude - degreeLatDistance;
    final num rightLng = centerPoint.longitude + degreeLngDistance;
    final LatLng topLeft = LatLng(topLat.toDouble(), leftLng.toDouble());
    final LatLng bottomRight =
        LatLng(bottomLat.toDouble(), rightLng.toDouble());
    return [topLeft, bottomRight];
  }

  /// Checks if a given geo point is inside the bounding box defined by the top-left
  /// and bottom-right corners.
  ///
  /// [l] - The LatLng coordinates of the point to check.
  ///
  /// [topLeft] - The LatLng coordinates of the top-left corner of the bounding box.
  ///
  /// [bottomRight] - The LatLng coordinates of the bottom-right corner of the bounding box.
  ///
  /// Returns true if the point is within the bounding box; otherwise, returns false.
  static bool isGeoPointInBoundingBox(
      LatLng l, LatLng topLeft, LatLng bottomRight) {
    return (bottomRight.latitude <= l.latitude &&
            l.latitude <= topLeft.latitude) &&
        (topLeft.longitude <= l.longitude &&
            l.longitude <= bottomRight.longitude);
  }
}
