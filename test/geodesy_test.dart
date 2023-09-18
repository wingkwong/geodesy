import 'package:test/test.dart';
import 'package:geodesy/geodesy.dart';

void main() {
  final geodesy = Geodesy();

  test('distanceBetweenTwoGeoPoints', () {
    final l1 = const LatLng(50.06638889, 5.71472222);
    final l2 = const LatLng(58.64388889, 3.07000000);
    final distance = geodesy.distanceBetweenTwoGeoPoints(l1, l2);
    final expectedDistance = 968853.5466871752;
    expect(distance, expectedDistance);
  });

  test('destinationPointByDistanceAndBearing', () {
    final l3 = const LatLng(51.4778, -0.0015);
    final destinationPoint =
        geodesy.destinationPointByDistanceAndBearing(l3, 7794.0, 300.7);
    final expectedDestinationPoint = const LatLng(51.513546, -0.098345);
    expect(destinationPoint.toString(), expectedDestinationPoint.toString());
  });

  test('bearingBetweenTwoGeoPoints', () {
    final l4 = const LatLng(52.205, 0.119);
    final l5 = const LatLng(48.857, 2.351);
    final bearing = geodesy.bearingBetweenTwoGeoPoints(l4, l5);
    final expectedBearing = 156.16658258153177;
    expect(bearing, expectedBearing);
  });

  test('finalBearingBetweenTwoGeoPoints', () {
    final l4 = const LatLng(52.205, 0.119);
    final l5 = const LatLng(48.857, 2.351);
    final finalBearing = geodesy.finalBearingBetweenTwoGeoPoints(l4, l5);
    final expectedFinalBearing = 157.89044019049243;
    expect(finalBearing, expectedFinalBearing);
  });

  test('midPointBetweenTwoGeoPoints', () {
    final l4 = const LatLng(52.205, 0.119);
    final l5 = const LatLng(48.857, 2.351);
    final midpoint = geodesy.midPointBetweenTwoGeoPoints(l4, l5);
    final expectedMidpoint = const LatLng(50.536327, 1.274614);
    expect(midpoint.toString(), expectedMidpoint.toString());
  });

  test('isGeoPointInBoundingBox', () {
    final l3 = const LatLng(51.4778, -0.0015);
    final l4 = const LatLng(52.205, 0.119);
    final l5 = const LatLng(48.857, 2.351);
    final inBoundingBox = geodesy.isGeoPointInBoundingBox(l3, l5, l4);
    expect(inBoundingBox, false);
  });

  test('intersectionByPaths', () {
    final l4 = const LatLng(52.205, 0.119);
    final l5 = const LatLng(48.857, 2.351);
    final b1 = 108.547;
    final b2 = 32.435;
    final intersectionByPaths = geodesy.intersectionByPaths(l4, l5, b1, b2);
    final expectedIntersectionByPaths =
        const LatLng(51.15151144654275, 4.698604211862175);
    expect(
        intersectionByPaths.toString(), expectedIntersectionByPaths.toString());
  });

  test('crossTrackDistanceTo', () {
    final l4 = const LatLng(52.205, 0.119);
    final l5 = const LatLng(48.857, 2.351);
    final l6 = const LatLng(50.587, 1.231);
    final distanceToGreatCircle = geodesy.crossTrackDistanceTo(l4, l5, l6);
    final expectedDistanceToGreatCircle = 1240.3379338876143;
    expect(distanceToGreatCircle, expectedDistanceToGreatCircle);
  });

  test('crossTrackDistanceTo', () {
    var poly = <LatLng>[
      const LatLng(1.0, 1.0),
      const LatLng(1.0, 2.0),
      const LatLng(2.0, 2.0),
      const LatLng(2.0, 1.0)
    ];
    var l7 = const LatLng(1.5, 1.5);
    var isGeoPointInPolygon = geodesy.isGeoPointInPolygon(l7, poly);
    expect(isGeoPointInPolygon, true);
  });

  test('pointsInRange', () {
    final point = const LatLng(51.0, 0);
    final distance = 10000;
    final pointNotInRange = geodesy.destinationPointByDistanceAndBearing(
        point, distance + 10, 420.0);
    final pointInRange = geodesy.destinationPointByDistanceAndBearing(
        point, distance - 10, 420.0);
    final pointsToCheck = <LatLng>[pointInRange, pointNotInRange];
    final geoFencedPoints =
        geodesy.pointsInRange(point, pointsToCheck, distance);
    expect((geoFencedPoints.contains(pointInRange)), true);
    expect((geoFencedPoints.contains(pointNotInRange)), false);
  });

  test('Great-Circle distance between two points using the Haversine formula',
      () {
    const num latitude1 = 52.5200; // Latitude of the first point
    const num longitude1 = 13.4050; // Longitude of the first point
    const num latitude2 = 48.8566; // Latitude of the second point
    const num longitude2 = 2.3522; // Longitude of the second point

    const num expectedDistance = 877460.0; // Expected distance in kilometers

    final num distance = geodesy.greatCircleDistanceBetweenTwoGeoPoints(
        latitude1, longitude1, latitude2, longitude2);

    expect(distance, closeTo(expectedDistance, 10.0));
  });

  test('getRectangleBounds returns correct rectangle bounds', () {
    List<LatLng> polygonCoords = [
      const LatLng(37.7749, -122.4194),
      const LatLng(37.3382, -121.8863),
      const LatLng(37.7749, -121.4194),
      const LatLng(37.7749, -123.4194),
    ];

    List<LatLng> expectedRectangleBounds = [
      const LatLng(37.3382, -123.4194),
      const LatLng(37.3382, -121.4194),
      const LatLng(37.7749, -121.4194),
      const LatLng(37.7749, -123.4194),
    ];

    List<LatLng> rectangleBounds = geodesy.getRectangleBounds(polygonCoords);

    // Assert that the rectangle bounds are calculated correctly
    expect(rectangleBounds.length, expectedRectangleBounds.length);
    for (int i = 0; i < expectedRectangleBounds.length; i++) {
      LatLng expectedCoord = expectedRectangleBounds[i];
      LatLng actualCoord = rectangleBounds[i];
      expect(actualCoord.latitude, expectedCoord.latitude);
      expect(actualCoord.longitude, expectedCoord.longitude);
    }
  });

  group('calculateBoundingBox', () {
    test(
        '''should calculate the correct bounding box for a given center point and distance''',
        () {
      final centerPoint = const LatLng(40.0, -73.0); // Example center point
      final distanceInKm = 10.0; // Example distance in kilometers

      final result = geodesy.calculateBoundingBox(centerPoint, distanceInKm);

      // Expected coordinates for the bounding box
      final expectedTopLeft =
          const LatLng(40.09090909090909, -73.16323914050199);
      final expectedBottomRight =
          const LatLng(39.90909090909091, -72.836760859498);

      // Check if the calculated bounding box matches the expected coordinates
      expect(result[0].latitude, closeTo(expectedTopLeft.latitude, 0.1));
      expect(result[0].longitude, closeTo(expectedTopLeft.longitude, 0.1));
      expect(result[1].latitude, closeTo(expectedBottomRight.latitude, 0.1));
      expect(result[1].longitude, closeTo(expectedBottomRight.longitude, 0.1));
    });
  });

// Polygon Centroid

  test('findPolygonCentroid calculates the centroid correctly', () {
    // Create a test polygon
    List<LatLng> polygon = [
      const LatLng(0, 0),
      const LatLng(0, 4),
      const LatLng(4, 4),
      const LatLng(4, 0),
    ];

    // Calculate the centroid
    LatLng centroid = geodesy.findPolygonCentroid(polygon);

    // Verify the centroid coordinates
    expect(centroid.latitude, equals(2.0));
    expect(centroid.longitude, equals(2.0));
  });

  // Polygon Intersection
  test('Intersection of two polygons', () {
    final polygon1 = [
      const LatLng(0, 0),
      const LatLng(0, 2),
      const LatLng(2, 2),
      const LatLng(2, 0),
    ];

    final polygon2 = [
      const LatLng(1, 1),
      const LatLng(1, 3),
      const LatLng(3, 3),
      const LatLng(3, 1),
    ];

    final intersectionPoints =
        geodesy.getPolygonIntersection(polygon1, polygon2);

    expect(intersectionPoints.length, 2);
    expect(intersectionPoints[0].latitude, 1);
    expect(intersectionPoints[0].longitude, 2);
    expect(intersectionPoints[1].latitude, 2);
    expect(intersectionPoints[1].longitude, 1);
  });

  // Calculate Vincenty Distance
  test('Calculate Vincenty distance', () {
    // Distance between SF and LA in meters
    final double expectedDistance = 559042.3365044123;

    final double calculatedDistance = geodesy.vincentyDistance(
      37.7749, -122.4194, // San Francisco
      34.0522, -118.2437, // Los Angeles
    );

    expect(calculatedDistance, closeTo(expectedDistance, 0.01));
  });

  /// Calculate Area of Polygon with Hole
  test('Calculate Area of Polygon with Hole', () {
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

    // Combine the outer polygon and holes
    final holes = [hole1];

    // Calculate the area of the polygon with the hole
    final calculatedArea =
        geodesy.calculatePolygonWithHolesArea(outerPolygon, holes);

    // Expected area of the polygon with the hole
    final expectedArea = 0.75; // This value should match the actual calculation

    expect(calculatedArea, expectedArea);
  });

  //
  test('Equirectangular Distance Calculation', () {
    final LatLng point1 = const LatLng(52.5200, 13.4050); // Berlin, Germany
    final LatLng point2 = const LatLng(48.8566, 2.3522); // Paris, France

    double distance = geodesy.equirectangularDistance(point1, point2);

    // Expected distance between Berlin and Paris in kilometers (approximate)
    double expectedDistance = 68326.0664427471;

    // Define a tolerance for floating-point comparison
    double tolerance = 0.01;

    expect(distance, closeTo(expectedDistance, tolerance));
  });
  test('Spherical Law of Cosines Distance Calculation', () {
    final LatLng point1 = const LatLng(52.5200, 13.4050); // Berlin, Germany
    final LatLng point2 = const LatLng(48.8566, 2.3522); // Paris, France

    double distance = geodesy.sphericalLawOfCosinesDistance(point1, point2);

    // Expected distance between Berlin and Paris in kilometers (approximate)
    double expectedDistance = 877.4633259175409;

    // Define a tolerance for floating-point comparison
    double tolerance = 0.01;

    expect(distance, closeTo(expectedDistance, tolerance));
  });
  test('Destination point for 45 degree bearing and 100 km distance', () {
    final initialPoint = const LatLng(52.5200, 13.4050); // Berlin, Germany
    final bearingDegrees = 45.0; // 45 degrees bearing (northeast)
    final distanceKm = 100.0; // 100 kilometers distance

    LatLng destinationPoint = geodesy.calculateDestinationPoint(
        initialPoint, bearingDegrees, distanceKm);

    // Expected destination point coordinates
    double expectedLatitude = 53.155916406012715;
    double expectedLongitude = 14.450082411263415;

    // Define a tolerance for latitude and longitude comparisons
    double tolerance = 0.001;

    expect(destinationPoint.latitude, closeTo(expectedLatitude, tolerance));
    expect(destinationPoint.longitude, closeTo(expectedLongitude, tolerance));
  });

  test('Midpoint between Berlin and Paris', () {
    final point1 = const LatLng(52.5200, 13.4050); // Berlin, Germany
    final point2 = const LatLng(48.8566, 2.3522); // Paris, France

    LatLng midpoint = geodesy.calculateMidpoint(point1, point2);

    // Expected midpoint coordinates (approximate)
    double expectedLatitude = 50.6883;
    double expectedLongitude = 7.8786;

    // Define a tolerance for latitude and longitude comparisons
    double tolerance = 0.001;

    expect(midpoint.latitude, closeTo(expectedLatitude, tolerance));
    expect(midpoint.longitude, closeTo(expectedLongitude, tolerance));
  });
  test('Points along Great Circle Arc', () {
    final startPoint = const LatLng(52.5200, 13.4050); // Berlin, Germany
    final endPoint = const LatLng(48.8566, 2.3522); // Paris, France
    final numPoints = 5; // Number of points along the arc

    List<LatLng> arcPoints = geodesy.calculatePointsAlongGreatCircle(
        startPoint, endPoint, numPoints);

    // Expected points along the great circle arc (approximate)
    List<LatLng> expectedPoints = [
      const LatLng(52.5200, 13.4050),
      const LatLng(51.78732, 11.19444),
      const LatLng(51.05464, 8.98388),
      const LatLng(50.321960000000004, 6.773319999999998),
      const LatLng(49.589279999999995, 4.562759999999999)
    ];

    // Define a tolerance for latitude and longitude comparisons
    double tolerance = 0.001;

    for (int i = 0; i < numPoints; i++) {
      expect(arcPoints[i].latitude,
          closeTo(expectedPoints[i].latitude, tolerance));
      expect(arcPoints[i].longitude,
          closeTo(expectedPoints[i].longitude, tolerance));
    }
  });

  test('Calculate the area of a square', () {
    // Create a square with four vertices
    List<LatLng> squarePoints = [
      const LatLng(0.0, 0.0),
      const LatLng(0.0, 1.0),
      const LatLng(1.0, 1.0),
      const LatLng(1.0, 0.0),
    ];

    // Calculate the area of the square
    double area = geodesy.calculatePolygonArea(squarePoints);

    // The area of a square with side length 1 is 1 square meter
    expect(area, equals(1.0));
  });

  test('Calculate the length of a straight line in meters', () {
    // Create a straight line with two points
    List<LatLng> linePoints = [
      const LatLng(0.0, 0.0),
      const LatLng(0.0, 1.0),
    ];

    // Calculate the length of the line in meters
    double length = geodesy.calculatePolyLineLength(linePoints);

    // The length of a straight line from (0,0) to (0,1) in meters
    // is 111319.0 meters
    expect(length, equals(111319.0));
  });

  test('Lines are parallel and do not intersect', () {
    // Create two parallel lines with no intersection
    LatLng start1 = const LatLng(0.0, 0.0);
    LatLng end1 = const LatLng(1.0, 0.0);
    LatLng start2 = const LatLng(0.0, 1.0);
    LatLng end2 = const LatLng(1.0, 1.0);

    // Calculate intersection point
    LatLng? intersection =
        geodesy.calculateGeodesicLineIntersection(start1, end1, start2, end2);

    // There should be no intersection
    expect(intersection, isNull);
  });

  test('Project a point onto a geodesic line', () {
    // Define the geodesic line
    LatLng start = const LatLng(42.345, -71.098);
    LatLng end = const LatLng(42.355, -71.108);

    // Define the point to be projected
    LatLng point = const LatLng(42.350, -71.103);

    // Calculate the expected projected point manually (e.g., using a GIS tool)
    LatLng expectedProjection =
        const LatLng(42.3512233054802, -71.09799913598741);

    // Project the point onto the geodesic line
    LatLng projection = geodesy.projectPointOntoGeodesicLine(point, start, end);

    // Check if the projected point is close enough to the expected result
    expect(projection.latitude, closeTo(expectedProjection.latitude, 0.0001));
    expect(projection.longitude, closeTo(expectedProjection.longitude, 0.0001));
  });
}
