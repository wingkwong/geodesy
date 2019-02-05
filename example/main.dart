import '../lib/geodesy.dart';

main() async {
  Geodesy geodesy = Geodesy();
  LatLng l1 = LatLng(50.06638889, 5.71472222);
  LatLng l2 = LatLng(58.64388889, 3.07000000);

  num distance = geodesy.distanceBetweenTwoGeoPoints(l1, l2, null);
  print("[distanceBetweenTwoGeoPoints] Distance: " + distance.toString());

  LatLng l3 = LatLng(51.4778, -0.0015);
  LatLng distinationPoint =
      geodesy.destinationPointByDistanceAndBearing(l3, 7794.0, 300.7, null);
  print("[destinationPointByDistanceAndBearing] Lat: " +
      distinationPoint.lat.toString());
  print("[destinationPointByDistanceAndBearing] Lng: " +
      distinationPoint.lng.toString());

  LatLng l4 = LatLng(52.205, 0.119);
  LatLng l5 = LatLng(48.857, 2.351);
  num bearing = geodesy.bearingBetweenTwoGeoPoints(l4, l5);
  print("[bearingBetweenTwoGeoPoints] Bearing: " + bearing.toString());

  num finalBearing = geodesy.finalBearingBetweenTwoGeoPoints(l4, l5);
  print("[finalBearingBetweenTwoGeoPoints] Bearing:" + finalBearing.toString());

  LatLng midpoint = geodesy.midPointBetweenTwoGeoPoints(l4, l5);
  print(
      "[midPointBetweenTwoGeoPoints] Midpoint Lat: " + midpoint.lat.toString());
  print(
      "[midPointBetweenTwoGeoPoints] Midpoint Lng: " + midpoint.lng.toString());

  bool inBoudingBox = geodesy.isGeoPointInBoudingBox(l3, l5, l4);
  print("[isGeoPointInBoudingBox]: " + inBoudingBox.toString());

  num b1 = 108.547;
  num b2 = 32.435;
  LatLng intersectionByPaths = geodesy.intersectionByPaths(l4, l5, b1, b2);
  print("[intersectionByPaths] Lat: " + intersectionByPaths.lat.toString());
  print("[intersectionByPaths] Lng: " + intersectionByPaths.lng.toString());

  LatLng l6 = LatLng(50.587, 1.231);
  num distanceToGreatCircle = geodesy.crossTrackDistanceTo(l4, l5, l6, null);
  print("[crossTrackDistanceTo] :" + distanceToGreatCircle.toString());
}
