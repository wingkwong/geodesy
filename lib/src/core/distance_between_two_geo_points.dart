import 'core.dart';
/// Calculate the distance in meters between two geo points
num dBetweenTwoGeoPoints(LatLng l1, LatLng l2, [num? radius]) {
  final R = radius ?? 6371e3;
  final num l1LatRadians = degToRadian(l1.latitude);
  final num l1LngRadians = degToRadian(l1.longitude);
  final num l2LatRadians = degToRadian(l2.latitude);
  final num l2LngRadians = degToRadian(l2.longitude);

  final latRadiansDiff = l2LatRadians - l1LatRadians;
  final lngRadiansDiff = l2LngRadians - l1LngRadians;

  final num a =  sin(latRadiansDiff / 2) *  sin(latRadiansDiff / 2) +
       cos(l1LatRadians) *
           cos(l2LatRadians) *
           sin(lngRadiansDiff / 2) *
           sin(lngRadiansDiff / 2);
  final num c = 2 *  atan2( sqrt(a),  sqrt(1 - a));
  final distance = R * c;

  return distance;
}
