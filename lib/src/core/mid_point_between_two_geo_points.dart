import 'core.dart';

/// Calculate the midpoint between teo geo points
LatLng mPointBetweenTwoGeoPoints(LatLng l1, LatLng l2) {
  final num l1LatRadians = degToRadian(l1.latitude);
  final num l1LngRadians = degToRadian(l1.longitude);
  final num l2LatRadians = degToRadian(l2.latitude);
  final num lngRadiansDiff = degToRadian(l2.longitude - l1.longitude);

  final num vectorX =  cos(l2LatRadians) *  cos(lngRadiansDiff);
  final num vectorY =  cos(l2LatRadians) *  sin(lngRadiansDiff);

  final num x =  sqrt(
       pow(( cos(l1LatRadians) + vectorX), 2) +  pow(vectorY, 2));
  final num y =  sin(l1LatRadians) +  sin(l2LatRadians);
  final num latRadians =  atan2(y, x);
  final num lngRadians =
      l1LngRadians +  atan2(vectorY,  cos(l1LatRadians) + vectorX);

  return LatLng(radianToDeg(latRadians as double),
      (radianToDeg(lngRadians as double) + 540) % 360 - 180);
}
