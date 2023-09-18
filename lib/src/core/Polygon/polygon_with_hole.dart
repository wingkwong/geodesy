import '../core.dart';

/// A Polygon Hole class for calculating the area of a polygon with holes.
class PolygonHole {
  /// Calculate the area of a polygon with holes.
  ///
  /// [outerPolygon] - A list of LatLng coordinates representing the vertices of the outer polygon.
  /// [holes] - A list of holes, where each hole is represented as a list of LatLng coordinates.
  ///
  /// Returns the area of the polygon with holes in square meters.
  static double calculatePolygonWithHolesArea(
      List<LatLng> outerPolygon, List<List<LatLng>> holes) {
    // Calculate and sum the areas of holes
    final holeAreas = holes.map((hole) {
      double area = 0.0;
      for (int i = 0; i < hole.length; i++) {
        final j = (i + 1) % hole.length;
        area += (hole[i].longitude + hole[j].longitude) *
            (hole[j].latitude - hole[i].latitude);
      }
      return area / 2.0;
    }).toList();

    // Calculate the area of the outer polygon
    double outerArea = 0.0;
    for (int i = 0; i < outerPolygon.length; i++) {
      final j = (i + 1) % outerPolygon.length;
      outerArea += (outerPolygon[i].longitude + outerPolygon[j].longitude) *
          (outerPolygon[j].latitude - outerPolygon[i].latitude);
    }

    // Subtract hole areas from the outer area to get the final area
    final finalArea =
        (outerArea / 2.0 - holeAreas.reduce((a, b) => a + b)).abs();

    return finalArea;
  }
}
