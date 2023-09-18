import '../core.dart';

/// A PolygonIntersection class for finding the intersection points of two polygons.
class PolygonIntersection {
  /// Get the intersection points of two polygons.
  ///
  /// [polygon1] - A list of LatLng coordinates representing the vertices of the first polygon.
  /// [polygon2] - A list of LatLng coordinates representing the vertices of the second polygon.
  ///
  /// Returns a list of LatLng points representing the intersection points of the two polygons.

  static List<LatLng> getPolygonIntersection(
      List<LatLng> polygon1, List<LatLng> polygon2) {
    final List<LatLng> intersectionPoints = <LatLng>[];

    for (int i = 0; i < polygon1.length; i++) {
      final int j = (i + 1) % polygon1.length;
      final LatLng edge1Start = polygon1[i];
      final LatLng edge1End = polygon1[j];

      for (int k = 0; k < polygon2.length; k++) {
        final int l = (k + 1) % polygon2.length;
        final LatLng edge2Start = polygon2[k];
        final LatLng edge2End = polygon2[l];

        final LatLng? intersection =
            _getLineIntersection(edge1Start, edge1End, edge2Start, edge2End);
        if (intersection != null) {
          intersectionPoints.add(intersection);
        }
      }
    }
    return intersectionPoints;
  }

  /// Calculate the intersection point of two line segments defined by their endpoints.
  ///
  /// [start1] - The starting point of the first line segment.
  /// [end1] - The ending point of the first line segment.
  /// [start2] - The starting point of the second line segment.
  /// [end2] - The ending point of the second line segment.
  ///
  /// Returns the intersection point as a LatLng object if it exists; otherwise, returns null.
  static LatLng? _getLineIntersection(
      LatLng start1, LatLng end1, LatLng start2, LatLng end2) {
    final num x1 = start1.latitude;
    final num y1 = start1.longitude;
    final num x2 = end1.latitude;
    final num y2 = end1.longitude;
    final num x3 = start2.latitude;
    final num y3 = start2.longitude;
    final num x4 = end2.latitude;
    final num y4 = end2.longitude;

    final num denominator = (x1 - x2) * (y3 - y4) - (y1 - y2) * (x3 - x4);
    if (denominator == 0) {
      return null; // Lines are parallel or coincident
    }

    final num intersectionX =
        ((x1 * y2 - y1 * x2) * (x3 - x4) - (x1 - x2) * (x3 * y4 - y3 * x4)) /
            denominator;
    final num intersectionY =
        ((x1 * y2 - y1 * x2) * (y3 - y4) - (y1 - y2) * (x3 * y4 - y3 * x4)) /
            denominator;

    final LatLng intersection =
        LatLng(intersectionX.toDouble(), intersectionY.toDouble());

    if (_isPointOnLine(intersection, start1, end1) &&
        _isPointOnLine(intersection, start2, end2)) {
      return intersection;
    } else {
      return null;
    }
  }

  /// Check if a point lies on a line segment defined by its endpoints.
  ///
  /// [point] - The point to check.
  /// [lineStart] - The starting point of the line segment.
  /// [lineEnd] - The ending point of the line segment.
  ///
  /// Returns true if the point lies on the line segment; otherwise, returns false.

  static bool _isPointOnLine(LatLng point, LatLng lineStart, LatLng lineEnd) {
    final minX = lineStart.latitude < lineEnd.latitude
        ? lineStart.latitude
        : lineEnd.latitude;
    final maxX = lineStart.latitude > lineEnd.latitude
        ? lineStart.latitude
        : lineEnd.latitude;
    final minY = lineStart.longitude < lineEnd.longitude
        ? lineStart.longitude
        : lineEnd.longitude;
    final maxY = lineStart.longitude > lineEnd.longitude
        ? lineStart.longitude
        : lineEnd.longitude;

    return point.latitude >= minX &&
        point.latitude <= maxX &&
        point.longitude >= minY &&
        point.longitude <= maxY;
  }
}
