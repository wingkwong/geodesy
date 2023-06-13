import 'package:test/test.dart';
import 'package:geodesy/geodesy.dart';

void main() {
  final geodesy = Geodesy();

  test('distanceBetweenTwoGeoPoints', () async {
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

  test('bearingBetweenTwoGeoPoints', () async {
    final l4 = const LatLng(52.205, 0.119);
    final l5 = const LatLng(48.857, 2.351);
    final bearing = geodesy.bearingBetweenTwoGeoPoints(l4, l5);
    final expectedBearing = 156.16658258153177;
    expect(bearing, expectedBearing);
  });

  test('finalBearingBetweenTwoGeoPoints', () async {
    final l4 = const LatLng(52.205, 0.119);
    final l5 = const LatLng(48.857, 2.351);
    final finalBearing = geodesy.finalBearingBetweenTwoGeoPoints(l4, l5);
    final expectedFinalBearing = 157.89044019049243;
    expect(finalBearing, expectedFinalBearing);
  });

  test('midPointBetweenTwoGeoPoints', () async {
    final l4 = const LatLng(52.205, 0.119);
    final l5 = const LatLng(48.857, 2.351);
    final midpoint = geodesy.midPointBetweenTwoGeoPoints(l4, l5);
    final expectedMidpoint = const LatLng(50.536327, 1.274614);
    expect(midpoint.toString(), expectedMidpoint.toString());
  });

  test('isGeoPointInBoundingBox', () async {
    final l3 = const LatLng(51.4778, -0.0015);
    final l4 = const LatLng(52.205, 0.119);
    final l5 = const LatLng(48.857, 2.351);
    final inBoundingBox = geodesy.isGeoPointInBoundingBox(l3, l5, l4);
    expect(inBoundingBox, false);
  });

  test('intersectionByPaths', () async {
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

  test('crossTrackDistanceTo', () async {
    final l4 = const LatLng(52.205, 0.119);
    final l5 = const LatLng(48.857, 2.351);
    final l6 = const LatLng(50.587, 1.231);
    final distanceToGreatCircle = geodesy.crossTrackDistanceTo(l4, l5, l6);
    final expectedDistanceToGreatCircle = 1240.3379338876143;
    expect(distanceToGreatCircle, expectedDistanceToGreatCircle);
  });

  test('crossTrackDistanceTo', () async {
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

  test('pointsInRange', () async {
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
}
