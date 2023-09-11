import '../core.dart';

/// Calculate Polygon Area Using Shoelace formula
class PolygonArea {
  /// The calculatePolygonArea function takes a list of LatLng points
  /// representing the vertices of the polygon as input.
  /// It checks if the number of points is less than 3,
  /// in which case it returns 0 because a polygon must have at
  /// least 3 points to form an area.
  /// It then iterates through the points and uses the Shoelace formula to
  /// Calculate the area of the polygon.
  /// Finally, it returns the absolute value of the calculated area,
  /// which is divided by 2 to get the final area in square meters.
  static double calculatePolygonArea(List<LatLng> polygonPoints) {
    if (polygonPoints.length < 3) {
      // A polygon must have at least 3 points to form an area.
      return 0.0;
    }

    double area = 0.0;

    for (int i = 0; i < polygonPoints.length; i++) {
      final LatLng currentPoint = polygonPoints[i];
      final LatLng nextPoint = polygonPoints[(i + 1) % polygonPoints.length];

      area += (currentPoint.latitude + nextPoint.latitude) *
          (currentPoint.longitude - nextPoint.longitude);
    }

    area = area.abs() / 2.0;
    return area;
  }
}
