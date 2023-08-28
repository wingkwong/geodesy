import 'core.dart';

/// Polygon
class Polygon {
  /// In this code, the calculatePolygonWithHolesArea function takes the
  /// outerPolygon (a list of LatLng points) and a list of holes
  /// (each hole represented as a list of LatLng points).
  /// It calculates the area using the given polygon and holes and
  /// returns the final area.
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
