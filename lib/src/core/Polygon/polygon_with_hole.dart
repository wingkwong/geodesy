import '../core.dart';
import '../GeodesicMeasurements/polygon_area_by_points.dart';

/// A Polygon Hole class for calculating the area of a polygon with holes.
class PolygonHole {
  /// Returns the area of a spherical polygon with holes in square meters.
  ///
  /// [outerPolygon] - A list of LatLng coordinates representing the vertices of the outer polygon.
  /// [holes] - A list of holes, where each hole is represented as a list of LatLng coordinates.
  ///
  /// Uses [PolygonArea.calculatePolygonArea] for every ring, with a sphere of
  /// radius 6,371,000 meters and short great-circle edges. Ring orientation
  /// does not matter. An empty holes list returns the outer polygon's area.
  /// Empty or degenerate holes contribute zero.
  ///
  /// The caller must supply simple, non-overlapping holes contained in the
  /// outer polygon's smaller enclosed region; topology is not checked.
  /// Throws [ArgumentError] if total hole area exceeds the outer area (beyond
  /// floating-point tolerance), or if any ring is invalid for [PolygonArea].
  static double calculatePolygonWithHolesArea(
      List<LatLng> outerPolygon, List<List<LatLng>> holes) {
    final outerArea = PolygonArea.calculatePolygonArea(outerPolygon);
    var holeArea = 0.0;
    var compensation = 0.0;
    for (final hole in holes) {
      final adjusted = PolygonArea.calculatePolygonArea(hole) - compensation;
      final next = holeArea + adjusted;
      compensation = (next - holeArea) - adjusted;
      holeArea = next;
    }
    final remainingArea = outerArea - holeArea;
    final tolerance = max(outerArea, holeArea) * 1e-12;
    if (remainingArea < -tolerance) {
      throw ArgumentError('Total hole area exceeds the outer polygon area');
    }
    return max(0.0, remainingArea);
  }
}
