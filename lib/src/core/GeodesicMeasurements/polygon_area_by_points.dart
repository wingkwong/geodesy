import '../core.dart';

/// Calculates polygon areas on a spherical Earth.
class PolygonArea {
  /// Returns the area of a simple polygon in square meters.
  ///
  /// Uses a sphere of radius 6,371,000 meters and the shorter great-circle arc
  /// between consecutive vertices. The ring is closed implicitly; repeating
  /// the first vertex is also supported. Either winding returns the smaller
  /// enclosed region (at most a hemisphere). Self-intersections are unsupported
  /// and are not checked. Rings with fewer than three vertices return zero.
  ///
  /// Throws [ArgumentError] for non-finite or out-of-range coordinates,
  /// antipodal consecutive vertices (whose connecting arc is ambiguous), or
  /// a ring that cannot be triangulated stably.
  static double calculatePolygonArea(List<LatLng> polygonPoints) {
    const radius = 6371000.0;
    final vertices = <_AreaVector>[];
    for (final point in polygonPoints) {
      if (!point.latitude.isFinite ||
          !point.longitude.isFinite ||
          point.latitude.abs() > 90 ||
          point.longitude.abs() > 180) {
        throw ArgumentError('Polygon coordinates must be finite, with latitude '
            'in [-90, 90] and longitude in [-180, 180]');
      }
      vertices.add(_AreaVector.fromPoint(point));
    }
    if (vertices.length < 3) return 0;

    for (var i = 0; i < vertices.length; i++) {
      final a = vertices[i];
      final b = vertices[(i + 1) % vertices.length];
      final cross = a.cross(b);
      if (a.dot(b) < 0 && cross.dot(cross) < 1e-30) {
        throw ArgumentError(
            'Consecutive polygon vertices must not be antipodal');
      }
    }

    // Sum signed triangle solid angles. A reference vertex keeps small
    // polygons accurate. Alternate references avoid antipodal diagonals in
    // large polygons; they do not change the enclosed area modulo 4*pi.
    final diagonal = 1 / sqrt(3);
    for (final reference in [
      vertices.first,
      const _AreaVector(1, 0, 0),
      const _AreaVector(0, 1, 0),
      const _AreaVector(0, 0, 1),
      _AreaVector(diagonal, diagonal, diagonal),
    ]) {
      final solidAngle = _solidAngle(vertices, reference);
      if (solidAngle == null) continue;
      var area = solidAngle.abs() % (4 * pi);
      if (area > 2 * pi) area = 4 * pi - area;
      return area * radius * radius;
    }
    throw ArgumentError('Polygon cannot be triangulated stably');
  }

  static double? _solidAngle(
      List<_AreaVector> vertices, _AreaVector reference) {
    var sum = 0.0;
    var compensation = 0.0;
    for (var i = 0; i < vertices.length; i++) {
      final a = vertices[i];
      final b = vertices[(i + 1) % vertices.length];
      // det(reference, a, b), translated to reduce cancellation for tiny rings.
      final numerator =
          reference.dot(a.subtract(reference).cross(b.subtract(reference)));
      final denominator = 1 + reference.dot(a) + a.dot(b) + b.dot(reference);
      if (numerator.abs() < 1e-15 && denominator.abs() < 1e-15) return null;
      final angle = 2 * atan2(numerator, denominator);
      // Compensated summation limits accumulated error for many edges.
      final adjusted = angle - compensation;
      final next = sum + adjusted;
      compensation = (next - sum) - adjusted;
      sum = next;
    }
    return sum;
  }
}

class _AreaVector {
  final double x;
  final double y;
  final double z;

  const _AreaVector(this.x, this.y, this.z);

  factory _AreaVector.fromPoint(LatLng point) {
    final lat = point.latitude.toRadians();
    final lon = point.longitude.toRadians();
    return _AreaVector(cos(lat) * cos(lon), cos(lat) * sin(lon), sin(lat));
  }

  double dot(_AreaVector other) => x * other.x + y * other.y + z * other.z;

  _AreaVector subtract(_AreaVector other) =>
      _AreaVector(x - other.x, y - other.y, z - other.z);

  _AreaVector cross(_AreaVector other) => _AreaVector(y * other.z - z * other.y,
      z * other.x - x * other.z, x * other.y - y * other.x);
}
