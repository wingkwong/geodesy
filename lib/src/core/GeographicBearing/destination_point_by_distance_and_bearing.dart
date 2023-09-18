import '../core.dart';

/// A DistanceAndBearing class for calculating destination points based on a starting point,
/// a distance, a direction (bearing), and optionally a radius.
class DistanceAndBearing {
  /// Calculates the coordinates of a destination point based on a starting point,
  /// a distance, a direction (bearing), and optionally a radius.
  ///
  /// [l] - The LatLng coordinates of the starting point.
  ///
  /// [distance] - The distance in meters to travel from the starting point.
  ///
  /// [bearing] - The direction or bearing in degrees (0 to 360) from the starting
  ///              point (0 degrees points north, 90 degrees points east, etc.).
  ///
  /// [radius] - The radius of the Earth or the sphere being considered. It is
  ///            an optional parameter and defaults to the Earth's radius (6371e3 meters).
  ///
  /// Returns a new LatLng object representing the coordinates of the destination point.
  static LatLng destinationPointByDistanceAndBearing(
      LatLng l, num distance, num bearing,
      [num? radius]) {
    radius = radius ?? 6371e3;
    final num angularDistanceRadius = distance / radius;
    final num bearingRadians = degToRadian(bearing as double);

    final num latRadians = degToRadian(l.latitude);
    final num lngRadians = degToRadian(l.longitude);

    final num sinLatRadians = sin(latRadians);
    final num cosLatRadians = cos(latRadians);
    final num sinAngularDistanceRadius = sin(angularDistanceRadius);
    final num cosAngularDistanceRadius = cos(angularDistanceRadius);
    final num sinBearingRadians = sin(bearingRadians);
    final num cosBearingRadians = cos(bearingRadians);

    final sinLatRadians2 = sinLatRadians * cosAngularDistanceRadius +
        cosLatRadians * sinAngularDistanceRadius * cosBearingRadians;
    final num latRadians2 = asin(sinLatRadians2);
    final y = sinBearingRadians * sinAngularDistanceRadius * cosLatRadians;
    final x = cosAngularDistanceRadius - sinLatRadians * sinLatRadians2;
    final num lngRadians2 = lngRadians + atan2(y, x);

    return LatLng(radianToDeg(latRadians2.toDouble()),
        (radianToDeg(lngRadians2.toDouble()) + 540.0) % 360.0 - 180.0);
  }
}
