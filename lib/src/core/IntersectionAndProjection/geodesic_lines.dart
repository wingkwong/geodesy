import '../core.dart';

/// A Geodesic Lines class for calculating geodesic lines, intersections, and projections.
class GeodesicLines {
  /// Calculates the intersection point of two geodesic lines defined by their
  /// starting and ending points.
  ///
  /// [start1] - The LatLng coordinates of the starting point of the first line.
  ///
  /// [end1] - The LatLng coordinates of the ending point of the first line.
  ///
  /// [start2] - The LatLng coordinates of the starting point of the second line.
  ///
  /// [end2] - The LatLng coordinates of the ending point of the second line.
  ///
  /// Returns the intersection point as a LatLng object, or null if no intersection
  /// is found.
  static LatLng? calculateGeodesicLineIntersection(
      LatLng start1, LatLng end1, LatLng start2, LatLng end2) {
    const double earthRadius = 6371000; // Earth's radius in meters

    final Distance distance = const Distance();
    final num bearing13 = initialBearing(start1, end1);
    final num bearing23 = initialBearing(start2, end2);
    final num lat1 = (start1.latitude).toRadians();
    final num lon1 = (start1.longitude).toRadians();
    final num lat2 = (start2.latitude).toRadians();
    final num lon2 = (start2.longitude).toRadians();
    final num lat3 = (end2.latitude).toRadians();

    final num dLon = lon2 - lon1;

    final num dist12 = distance(start1, start2);
    if (dist12 == 0) {
      return null; // The two starting points are the same.
    }

    final num alpha1 = bearing13;
    final num alpha2 = bearing23;
    final num alpha3 = acos(cos(dist12 / earthRadius) /
        (cos(lat1) * cos(lat2) * sin(alpha1) * sin(alpha2) * sin(dLon)));
    final num dist13 = earthRadius * alpha3;
    final num bearingA = asin(sin(alpha1) * sin(dist13 / earthRadius));
    final num bearingB = asin(sin(alpha2) * sin(dist13 / earthRadius));

    final num alpha4 = acos(-cos(dist13 / earthRadius) /
        (cos(lat1) * cos(lat3) * sin(bearingA) * sin(bearingB)));
    final num dist14 = earthRadius * alpha4;

    if (dist14.isNaN) {
      return null; // No intersection found.
    }

    final num lat4 = atan2(
        sin(lat1) * cos(dist14 / earthRadius) * sin(bearingA),
        cos(lat1) * sin(dist14 / earthRadius) * sin(bearingA) * cos(bearing13) -
            sin(lat1) *
                cos(dist14 / earthRadius) *
                cos(bearingA) *
                sin(bearing13) +
            cos(lat1) *
                cos(dist14 / earthRadius) *
                cos(bearingA) *
                cos(bearing13));

    final num lon4 = lon1 +
        atan2(
            sin(bearing13) * sin(dist14 / earthRadius) * sin(bearingA),
            cos(dist14 / earthRadius) -
                sin(lat1) * sin(lat4) -
                cos(lat1) * cos(lat4) * cos(bearingA));
    return LatLng((lat4).toDegrees(), (lon4).toDegrees());
  }

  /// Projects a given point onto a geodesic line defined by two endpoints.
  ///
  /// [point] - The LatLng coordinates of the point to project.
  ///
  /// [start] - The LatLng coordinates of the starting point of the geodesic line.
  ///
  /// [end] - The LatLng coordinates of the ending point of the geodesic line.
  ///
  /// Returns the projected point as a LatLng object.
  static LatLng projectPointOntoGeodesicLine(
      LatLng point, LatLng start, LatLng end) {
    const double earthRadius = 6371000; // Earth's radius in meters

    final Distance distance = const Distance();

    // Calculate the initial bearing from start to end
    final double initialBearingValue = initialBearing(start, end);

    // Calculate the distance between start and the given point
    final double distanceToStart = distance(start, point);

    // Calculate the angular distance in radians
    final double angularDistance = distanceToStart / earthRadius;

    // Calculate the final bearing using the initial bearing and
    // angular distance
    final double finalBearing =
        asin(sin(angularDistance) * sin(initialBearingValue));

    // Calculate the destination point (projection) on the line
    final double lat1 = (start.latitude).toRadians();
    final double lon1 = (start.longitude).toRadians();
    final double lat2 = asin(sin(lat1) * cos(angularDistance) +
        cos(lat1) * sin(angularDistance) * cos(finalBearing));
    final double lon2 = lon1 +
        atan2(sin(finalBearing) * sin(angularDistance) * cos(lat1),
            cos(angularDistance) - sin(lat1) * sin(lat2));

    return LatLng((lat2).toDegrees(), (lon2).toDegrees());
  }

  /// Calculates the initial bearing (azimuth) from one point to another.
  ///
  /// [start] - The LatLng coordinates of the starting point.
  ///
  /// [end] - The LatLng coordinates of the ending point.
  ///
  /// Returns the initial bearing in degrees, where 0 degrees indicates
  /// a northward direction and 90 degrees indicates an eastward direction.
  static double initialBearing(LatLng start, LatLng end) {
    final double lat1 = (start.latitude).toRadians();
    final double lon1 = (start.longitude).toRadians();
    final double lat2 = (end.latitude).toRadians();
    final double lon2 = (end.longitude).toRadians();

    final double dLon = lon2 - lon1;

    final double y = sin(dLon) * cos(lat2);
    final double x = cos(lat1) * sin(lat2) - sin(lat1) * cos(lat2) * cos(dLon);
    final double initialBearings = atan2(y, x);

    // Convert initial bearing from radians to degrees
    return (initialBearings).toDegrees();
  }
}
