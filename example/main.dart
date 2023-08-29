import 'package:latlong2/latlong.dart';
import 'package:geodesy/geodesy.dart' show Geodesy;

void main() {
  final geodesy = Geodesy();
  final l1 = const LatLng(50.06638889, 5.71472222);
  final l2 = const LatLng(58.64388889, 3.07000000);

  final distance = geodesy.distanceBetweenTwoGeoPoints(l1, l2);
  print('[distanceBetweenTwoGeoPoints] Distance: ' + distance.toString());

  final l3 = const LatLng(51.4778, -0.0015);
  final destinationPoint =
      geodesy.destinationPointByDistanceAndBearing(l3, 7794.0, 300.7);
  print('[destinationPointByDistanceAndBearing] Lat: ' +
      destinationPoint.latitude.toString());
  print('[destinationPointByDistanceAndBearing] Lng: ' +
      destinationPoint.longitude.toString());

  final l4 = const LatLng(52.205, 0.119);
  final l5 = const LatLng(48.857, 2.351);
  final bearing = geodesy.bearingBetweenTwoGeoPoints(l4, l5);
  print('[bearingBetweenTwoGeoPoints] Bearing: ' + bearing.toString());

  final finalBearing = geodesy.finalBearingBetweenTwoGeoPoints(l4, l5);
  print('[finalBearingBetweenTwoGeoPoints] Bearing:' + finalBearing.toString());

  final midpoint = geodesy.midPointBetweenTwoGeoPoints(l4, l5);
  print('[midPointBetweenTwoGeoPoints] Midpoint Lat: ' +
      midpoint.latitude.toString());
  print('[midPointBetweenTwoGeoPoints] Midpoint Lng: ' +
      midpoint.longitude.toString());

  final inBoundingBox = geodesy.isGeoPointInBoundingBox(l3, l5, l4);
  print('[isGeoPointInBoundingBox]: ' + inBoundingBox.toString());

  num b1 = 108.547;
  num b2 = 32.435;
  final intersectionByPaths = geodesy.intersectionByPaths(l4, l5, b1, b2);
  print(
      '[intersectionByPaths] Lat: ' + intersectionByPaths!.latitude.toString());
  print(
      '[intersectionByPaths] Lng: ' + intersectionByPaths.longitude.toString());

  final l6 = const LatLng(50.587, 1.231);
  final distanceToGreatCircle = geodesy.crossTrackDistanceTo(l4, l5, l6);
  print('[crossTrackDistanceTo] :' + distanceToGreatCircle.toString());

  final poly = <LatLng>[
    const LatLng(1.0, 1.0),
    const LatLng(1.0, 2.0),
    const LatLng(2.0, 2.0),
    const LatLng(2.0, 1.0)
  ];
  final l7 = const LatLng(1.5, 1.5);
  final isGeoPointInPolygon = geodesy.isGeoPointInPolygon(l7, poly);
  print('[isGeoPointInPolygon] :' + isGeoPointInPolygon.toString());

  // Great-circle distance between two points using the Haversine formula
  num latitude1 = 37.7749;
  num longitude1 = -122.4194;
  num latitude2 = 37.3382;
  num longitude2 = -121.8863;

  num greatCircleDistance = geodesy.greatCircleDistanceBetweenTwoGeoPoints(
      latitude1, longitude1, latitude2, longitude2);

  print(
      '''[greatCircleDistance]: ${greatCircleDistance.toStringAsFixed(2)} km''');

  // Polygon Coords
  List<LatLng> polygonCoords = [
    const LatLng(37.7749, -122.4194),
    const LatLng(37.3382, -121.8863),
    const LatLng(37.7749, -121.4194),
    const LatLng(37.7749, -123.4194),
  ];

  List<LatLng> rectangleBounds = geodesy.getRectangleBounds(polygonCoords);

  print('[getRectangleBounds]: ');
  for (LatLng coord in rectangleBounds) {
    print(' > Latitude: ${coord.latitude}, Longitude: ${coord.longitude}');
  }

  // Calculate Bounding Box
  // Example central position (San Francisco)
  final centerPoint = const LatLng(37.7749, -122.4194);
  // Example distance in kilometers
  final distanceInKm = 1.0;

  final boundingBox = geodesy.calculateBoundingBox(centerPoint, distanceInKm);

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

  LatLng centroid = geodesy.findPolygonCentroid(polygon);

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

  final List<LatLng> intersectionPoints =
      geodesy.getPolygonIntersection(polygon1, polygon2);

  print('Intersection Points:');
  for (final point in intersectionPoints) {
    print('Latitude: ${point.latitude}, Longitude: ${point.longitude}');
  }

  // Vincenty formula for Geodesic Distance Calculation
  final LatLng point1 = const LatLng(37.7749, -122.4194); // San Francisco
  final LatLng point2 = const LatLng(34.0522, -118.2437); // Los Angeles

  final double calculatedDistance = geodesy.vincentyDistance(
      point1.latitude, point1.longitude, point2.latitude, point2.longitude);

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

  final area = geodesy.calculatePolygonWithHolesArea(outerPolygon, holes);
  print("Area of polygon with holes: $area");

  // Equirectangular approximation Calculation
  final firstPoint = const LatLng(52.5200, 13.4050); // Berlin, Germany
  final secondPoint = const LatLng(48.8566, 2.3522); // Paris, France

  double equirectangularDistance =
      geodesy.equirectangularDistance(firstPoint, secondPoint);
  print(
      '''Equirectangular Distance: ${equirectangularDistance.toStringAsFixed(2)} km
      ''');
}
