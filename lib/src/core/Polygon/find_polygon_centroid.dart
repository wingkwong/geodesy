import '../core.dart';

/// A Polygon Centroid class for finding the centroid of polygons.
class PolygonCentroid {
  /// Finds the centroid of a polygon defined by a list of LatLng points.
  ///
  /// [polygons] - A list of LatLng coordinates representing the vertices of the polygon.
  ///
  /// Returns the centroid of the polygon as a LatLng object.
  static LatLng findPolygonCentroid(List<LatLng> polygons) {
    num x = 0;
    num y = 0;
    num signedArea = 0;

    num vertexCount = polygons.length;

    for (int i = 0; i < vertexCount; i++) {
      final LatLng currentVertex = polygons[i];
      final LatLng nextVertex = polygons[(i + 1) % vertexCount.toInt()];

      num a = currentVertex.longitude * nextVertex.latitude -
          nextVertex.longitude * currentVertex.latitude;
      signedArea += a;
      x += (currentVertex.longitude + nextVertex.longitude) * a;
      y += (currentVertex.latitude + nextVertex.latitude) * a;
    }

    signedArea *= 0.5;
    x /= (6 * signedArea);
    y /= (6 * signedArea);

    // Return the centroid as LatLng object
    return LatLng(
      y.toDouble(),
      x.toDouble(),
    );
  }
}
