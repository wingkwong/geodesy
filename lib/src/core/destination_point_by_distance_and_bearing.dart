import 'core.dart';

/// DestinationPointByDistanceAndBearing
class DistanceAndBearing {
  /// DestinationPointByDistanceAndBearing:
  /// This code takes a starting point, a distance, a direction (bearing), and
  /// optionally a radius, and calculates the coordinates of a new point based
  /// on these inputs, using trigonometric calculations and the Haversine formula
  /// for spherical geometry.
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

    return LatLng(radianToDeg(latRadians2 as double),
        (radianToDeg(lngRadians2 as double) + 540) % 360 - 180);
  }
}
