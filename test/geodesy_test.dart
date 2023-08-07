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
}
