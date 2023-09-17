import '../core.dart';

/// A Bearing Between Two GeoPoints class for calculating bearings between two geographical points
/// represented by their latitude and longitude coordinates.
class BearingBetweenTwoGeoPoints {
  /// Calculates the initial bearing (azimuth) from point [l1] to point [l2].
  ///
  /// [l1] - The LatLng coordinates of the starting point.
  ///
  /// [l2] - The LatLng coordinates of the ending point.
  ///
  /// Returns the initial bearing in degrees, where 0 degrees indicates
  /// a northward direction and 90 degrees indicates an eastward direction.
  static num bearingBetweenTwoGeoPoints(LatLng l1, LatLng l2) {
    final l1LatRadians = degToRadian(l1.latitude);
    final l2LatRadians = degToRadian(l2.latitude);
    final lngRadiansDiff = degToRadian(l2.longitude - l1.longitude);

    final y = sin(lngRadiansDiff) * cos(l2LatRadians);
    final x = cos(l1LatRadians) * sin(l2LatRadians) -
        sin(l1LatRadians) * cos(l2LatRadians) * cos(lngRadiansDiff);

    final radians = atan2(y, x);
    final degrees = radianToDeg(radians);

    return (degrees + 360) % 360;
  }

  /// Calculates the final bearing (azimuth) from point [l1] to point [l2].
  ///
  /// The final bearing is the initial bearing when traveling in the reverse
  /// direction from point [l2] to point [l1].
  ///
  /// [l1] - The LatLng coordinates of the starting point.
  ///
  /// [l2] - The LatLng coordinates of the ending point.
  ///
  /// Returns the final bearing in degrees, where 0 degrees indicates
  /// a northward direction and 90 degrees indicates an eastward direction.
  static num finalBearingBetweenTwoGeoPoints(LatLng l1, LatLng l2) {
    return (bearingBetweenTwoGeoPoints(l2, l1) + 180) % 360;
  }
}
