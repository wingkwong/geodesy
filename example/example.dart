import 'package:geodesy/geodesy.dart';
import 'package:geodesy/src/core/equirectangular_distance.dart';
import 'package:geodesy/src/core/polygon_with_hole.dart';

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

  // Vincenty formula for Geodesic Distance Calculation
  final LatLng point1 = const LatLng(37.7749, -122.4194); // San Francisco
  final LatLng point2 = const LatLng(34.0522, -118.2437); // Los Angeles

  final double calculatedDistance = VincentyDistance.vincentyDistance(
    point1.latitude,
    point1.longitude,
    point2.latitude,
    point2.longitude,
  );

  print(
    '''Distance between San Francisco and Los Angeles: 
    $calculatedDistance meters''',
  );

  // Define the outer polygon
  final outerPolygon = [
    const LatLng(0.0, 0.0),
    const LatLng(0.0, 1.0),
    const LatLng(1.0, 1.0),
    const LatLng(1.0, 0.0),
  ];

  // Define a hole within the outer polygon
  final hole1 = [
    const LatLng(0.25, 0.25),
    const LatLng(0.25, 0.75),
    const LatLng(0.75, 0.75),
    const LatLng(0.75, 0.25),
  ];

  final holes = [hole1];

  final area = Polygon.calculatePolygonWithHolesArea(outerPolygon, holes);
  print("Area of polygon with holes: $area");

  // Equirectangular approximation Calculation
  final firstPoint = const LatLng(52.5200, 13.4050); // Berlin, Germany
  final secondPoint = const LatLng(48.8566, 2.3522); // Paris, France

  double equirectangularDistance =
      EquirectangularApproximation.equirectangularDistance(
          firstPoint, secondPoint);
  print(
      '''Equirectangular Distance: ${equirectangularDistance.toStringAsFixed(2)} km
      ''');
}
