import 'package:geodesy/geodesy.dart';

void main() {
  // Calculate Bounding Box
  // Example central position (San Francisco)
  final centerPoint = const LatLng(37.7749, -122.4194);
  // Example distance in kilometers
  final distanceInKm = 1.0;
  // Static Method
  final boundingBox =
      BoundingBox.calculateBoundingBox(centerPoint, distanceInKm);

  print('[calculateBoundingBox]: ');
  print(' > Top Left: ${boundingBox[0]}');
  print(' > Bottom Right: ${boundingBox[1]}');

  // Polygon Centroid
  List<LatLng> polygon = [
    const LatLng(0, 0),
    const LatLng(4, 0),
    const LatLng(4, 4),
    const LatLng(0, 4)
  ];
  // Static Methods
  final LatLng centroid = PolygonCentroid.findPolygonCentroid(polygon);

  print("Centroid: ${centroid.latitude}, ${centroid.longitude}");

  // Polygon Intersection
  final List<LatLng> polygon1 = [
    const LatLng(0, 0),
    const LatLng(0, 2),
    const LatLng(2, 2),
    const LatLng(2, 0),
  ];

  final List<LatLng> polygon2 = [
    const LatLng(1, 1),
    const LatLng(1, 3),
    const LatLng(3, 3),
    const LatLng(3, 1),
  ];
  // Static Method
  final List<LatLng> intersectionPoints =
      PolygonIntersection.getPolygonIntersection(polygon1, polygon2);

  print('Intersection Points:');
  for (final point in intersectionPoints) {
    print('Latitude: ${point.latitude}, Longitude: ${point.longitude}');
  }
}
