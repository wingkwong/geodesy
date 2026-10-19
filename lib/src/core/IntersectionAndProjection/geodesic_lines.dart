import '../core.dart';

/// Spherical intersections and projections for great-circle geodesics.
class GeodesicLines {
  static const double _vectorTolerance = 1e-15;
  static const double _arcTolerance = 1e-10;

  /// Returns the intersection of two shorter great-circle segments.
  ///
  /// Each segment includes its endpoints. Returns `null` when the segments do
  /// not intersect or lie on the same great circle. Coincident or overlapping
  /// segments have no unique intersection and therefore also return `null`.
  ///
  /// Throws [ArgumentError] for non-finite or out-of-range coordinates and for
  /// identical or antipodal endpoints, which do not define a unique segment.
  static LatLng? calculateGeodesicLineIntersection(
      LatLng start1, LatLng end1, LatLng start2, LatLng end2) {
    final a = _vectorFor(start1, 'start1');
    final b = _vectorFor(end1, 'end1');
    final c = _vectorFor(start2, 'start2');
    final d = _vectorFor(end2, 'end2');
    final normal1 = _greatCircleNormal(a, b, 'start1', 'end1');
    final normal2 = _greatCircleNormal(c, d, 'start2', 'end2');

    final intersectionAxis = normal1.cross(normal2);
    final axisLength = intersectionAxis.magnitude;
    if (axisLength < _vectorTolerance) {
      return null;
    }

    final candidate = intersectionAxis.scaled(1 / axisLength);
    for (final point in [candidate, candidate.scaled(-1)]) {
      if (_isOnMinorArc(point, a, b) && _isOnMinorArc(point, c, d)) {
        return point.toLatLng();
      }
    }
    return null;
  }

  /// Returns the nearest point on the infinite great circle through [start]
  /// and [end].
  ///
  /// The result is not clamped to the shorter segment between the endpoints.
  /// Throws [ArgumentError] for non-finite or out-of-range coordinates; for
  /// identical or antipodal endpoints; or when [point] is a pole of the great
  /// circle and therefore has no unique nearest point.
  static LatLng projectPointOntoGeodesicLine(
      LatLng point, LatLng start, LatLng end) {
    final source = _vectorFor(point, 'point');
    final a = _vectorFor(start, 'start');
    final b = _vectorFor(end, 'end');
    final normal = _greatCircleNormal(a, b, 'start', 'end');

    // Remove the component perpendicular to the great-circle plane.
    final projected = source.subtract(normal.scaled(source.dot(normal)));
    final projectedLength = projected.magnitude;
    if (projectedLength < _vectorTolerance) {
      throw ArgumentError(
          'point has no unique projection onto the geodesic line');
    }
    return projected.scaled(1 / projectedLength).toLatLng();
  }

  /// Calculates the initial bearing from [start] to [end] in degrees.
  static double initialBearing(LatLng start, LatLng end) {
    final lat1 = start.latitude.toRadians();
    final lon1 = start.longitude.toRadians();
    final lat2 = end.latitude.toRadians();
    final lon2 = end.longitude.toRadians();
    final dLon = lon2 - lon1;
    final y = sin(dLon) * cos(lat2);
    final x = cos(lat1) * sin(lat2) - sin(lat1) * cos(lat2) * cos(dLon);
    return atan2(y, x).toDegrees();
  }

  static _GeodesicVector _vectorFor(LatLng point, String name) {
    if (!point.latitude.isFinite ||
        !point.longitude.isFinite ||
        point.latitude.abs() > 90 ||
        point.longitude.abs() > 180) {
      throw ArgumentError.value(point, name,
          'Coordinates must be finite, with latitude in [-90, 90] and longitude in [-180, 180]');
    }
    return _GeodesicVector.fromLatLng(point);
  }

  static _GeodesicVector _greatCircleNormal(_GeodesicVector start,
      _GeodesicVector end, String startName, String endName) {
    final cross = start.cross(end);
    final length = cross.magnitude;
    if (length < _vectorTolerance) {
      throw ArgumentError(
          '$startName and $endName must be distinct and non-antipodal');
    }
    return cross.scaled(1 / length);
  }

  static bool _isOnMinorArc(
      _GeodesicVector point, _GeodesicVector start, _GeodesicVector end) {
    final arcLength = start.angleTo(end);
    final splitLength = start.angleTo(point) + point.angleTo(end);
    return (splitLength - arcLength).abs() <= _arcTolerance;
  }
}

class _GeodesicVector {
  final double x;
  final double y;
  final double z;

  const _GeodesicVector(this.x, this.y, this.z);

  factory _GeodesicVector.fromLatLng(LatLng point) {
    final latitude = point.latitude.toRadians();
    final longitude = point.longitude.toRadians();
    final cosLatitude = cos(latitude);
    return _GeodesicVector(
      cosLatitude * cos(longitude),
      cosLatitude * sin(longitude),
      sin(latitude),
    );
  }

  double get magnitude => sqrt(dot(this));

  double dot(_GeodesicVector other) => x * other.x + y * other.y + z * other.z;

  _GeodesicVector cross(_GeodesicVector other) => _GeodesicVector(
        y * other.z - z * other.y,
        z * other.x - x * other.z,
        x * other.y - y * other.x,
      );

  _GeodesicVector subtract(_GeodesicVector other) =>
      _GeodesicVector(x - other.x, y - other.y, z - other.z);

  _GeodesicVector scaled(double factor) =>
      _GeodesicVector(x * factor, y * factor, z * factor);

  double angleTo(_GeodesicVector other) =>
      atan2(cross(other).magnitude, dot(other).clamp(-1.0, 1.0));

  LatLng toLatLng() {
    final latitude = asin(z.clamp(-1.0, 1.0)).toDegrees();
    final rawLongitude = atan2(y, x).toDegrees();
    final longitude = (rawLongitude + 540) % 360 - 180;
    return LatLng(
        latitude == -0.0 ? 0.0 : latitude, longitude == -0.0 ? 0.0 : longitude);
  }
}
