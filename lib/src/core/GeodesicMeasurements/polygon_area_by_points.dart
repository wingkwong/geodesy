import '../core.dart';

/// A Polygon Area class for calculating the area of a polygon using the Shoelace formula.
class PolygonArea {
  /// Calculates the area of a polygon defined by a list of LatLng points.
  ///
  /// The function checks if the number of points is less than 3, in which case
  /// it returns 0 because a polygon must have at least 3 points to form an area.
  /// It then iterates through the points and uses the Shoelace formula to calculate
  /// the signed area of the polygon. The result is the absolute value of the
  /// calculated area, divided by 2, which gives the final area in square meters.
  ///
  /// [polygonPoints] - A list of LatLng points representing the vertices of the polygon.
  ///
  /// Returns the area of the polygon in square meters.
  static double calculatePolygonArea(List<LatLng> polygonPoints) {
    if (polygonPoints.length < 3) {
      // A polygon must have at least 3 points to form an area.
      return 0.0;
    }

    double area = 0.0;

    for (int i = 0; i < polygonPoints.length; i++) {
      final LatLng currentPoint = polygonPoints[i];
      final LatLng nextPoint = polygonPoints[(i + 1) % polygonPoints.length];

      area += (currentPoint.latitude * nextPoint.longitude -
          nextPoint.latitude * currentPoint.longitude);
    }

    area = area.abs() / 2.0;
    return area;
  }
}
