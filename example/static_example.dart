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
    '''Distance between San Francisco and Los Angeles:  $calculatedDistance meters''',
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

  final area = PolygonHole.calculatePolygonWithHolesArea(outerPolygon, holes);
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

  /// Calculate Spherical Law Of Cosines Distance
  final bGPoint = const LatLng(52.5200, 13.4050); // Berlin, Germany
  final pFPoint = const LatLng(48.8566, 2.3522); // Paris, France

  double sLCDdistance =
      SphericalLawOfCosines.sphericalLawOfCosinesDistance(bGPoint, pFPoint);
  print(
      '''Spherical Law of Cosines Distance: ${sLCDdistance.toStringAsFixed(2)} km
      ''');

  /// Geodetic Point Manipulation - Rhumb Line Destination Formula
  final initialPoint = const LatLng(52.5200, 13.4050); // Berlin, Germany
  final bearingDegrees = 45.0; // 45 degrees bearing (northeast)
  final distanceKm = 100.0; // 100 kilometers distance

  LatLng destinationPoints = DestinationPoint.calculateDestinationPoint(
      initialPoint, bearingDegrees, distanceKm);

  print('Initial Point: ${initialPoint.latitude}, ${initialPoint.longitude}');
  print('''Destination Point: ${destinationPoints.latitude}, 
      ${destinationPoints.longitude}''');

  /// Geodetic Point Manipulation - Midpoint between two points
  final bgPoint1 = const LatLng(52.5200, 13.4050); // Berlin, Germany
  final pFPoint2 = const LatLng(48.8566, 2.3522); // Paris, France

  LatLng midPointBetweenTwoPoints =
      MidPointBetweenTwoPoints.calculateMidpoint(bgPoint1, pFPoint2);

  print('''Midpoint: ${midPointBetweenTwoPoints.latitude}, 
      ${midPointBetweenTwoPoints.longitude}''');

  /// Geodetic Point Manipulation - Calculate Point Along Great Circle
  final startPoint = const LatLng(52.5200, 13.4050); // Berlin, Germany
  final endPoint = const LatLng(48.8566, 2.3522); // Paris, France
  final numPoints = 5; // Number of points along the arc

  List<LatLng> arcPoints = GreatCirclePoint.calculatePointsAlongGreatCircle(
      startPoint, endPoint, numPoints);

  print('Points along Great Circle Arc:');
  for (var point in arcPoints) {
    print('${point.latitude}, ${point.longitude}');
  }

  /// PolyLine Length
  // Create a list of LatLng points representing your polyLine
  List<LatLng> polyLinePoints = [
    const LatLng(42.345, -71.098), // Add your points here
    const LatLng(42.355, -71.108),
    const LatLng(42.365, -71.118),
    // Add more points as needed
  ];

  // Calculate the length of the polyLine
  double length = PolyLine.calculatePolyLineLength(polyLinePoints);

  print('Length of the polyLine: $length meters');

  /// Polygon Area by Using Shoelace formula
  // Create a list of LatLng points representing your polygon
  List<LatLng> polygonPoints = [
    const LatLng(42.345, -71.098), // Add your points here
    const LatLng(42.355, -71.108),
    const LatLng(42.365, -71.118),
    // Add more points as needed
  ];

  // Calculate the area of the polygon
  double polygonArea = PolygonArea.calculatePolygonArea(polygonPoints);

  print('Area of the polygon: $polygonArea square meters');

  /// Calculate intersection points of two geodesic lines
  // Example geodesic lines
  LatLng start1 = const LatLng(42.345, -71.098);
  LatLng end1 = const LatLng(42.355, -71.108);
  LatLng start2 = const LatLng(42.355, -71.108);
  LatLng end2 = const LatLng(42.365, -71.118);

  // Calculate intersection point
  LatLng? intersection = GeodesicLines.calculateGeodesicLineIntersection(
      start1, end1, start2, end2);

  if (intersection != null) {
    print(''''Intersection point: Latitude ${intersection.latitude}, 
        Longitude ${intersection.longitude}''');
  } else {
    print('No intersection found.');
  }

  /// Project a point onto a geodesic line
  // Example geodesic line and point
  LatLng start = const LatLng(42.345, -71.098);
  LatLng end = const LatLng(42.355, -71.108);
  LatLng point = const LatLng(42.350, -71.103);

  // Project the point onto the geodesic line
  LatLng projection =
      GeodesicLines.projectPointOntoGeodesicLine(point, start, end);

  print('''Projected Point: Latitude ${projection.latitude}, 
      Longitude ${projection.longitude}''');
}
