import 'core.dart';

/// Calculate the geo point of intersection of two given paths
LatLng? iByPaths(LatLng l1, LatLng l2, num b1, num b2) {
  final num l1LatRadians = degToRadian(l1.latitude);
  final num l1LngRadians = degToRadian(l1.longitude);
  final num l2LatRadians = degToRadian(l2.latitude);
  final num l2LngRadians = degToRadian(l2.longitude);
  final num b1Radians = degToRadian(b1 as double);
  final num b2Radians = degToRadian(b2 as double);

  final latRadiansDiff = l2LatRadians - l1LatRadians;
  final lngRadiansDiff = l2LngRadians - l1LngRadians;

  final num angularDistance = 2 *
       asin( sqrt(
           sin(latRadiansDiff / 2) *  sin(latRadiansDiff / 2) +
               cos(l1LatRadians) *
                   cos(l2LatRadians) *
                   sin(lngRadiansDiff / 2) *
                   sin(lngRadiansDiff / 2)));

  if (angularDistance == 0) return null;

  num initBearingX =  acos(( sin(l2LatRadians) -
           sin(l1LatRadians) *  cos(angularDistance)) /
      ( sin(angularDistance) *  cos(l1LatRadians)));
  if (initBearingX.isNaN) initBearingX = 0;

  num initBearingY =  acos(( sin(l1LatRadians) -
           sin(l2LatRadians) *  cos(angularDistance)) /
      ( sin(angularDistance) *  cos(l2LatRadians)));

  final finalBearingX =  sin(l2LngRadians - l1LngRadians) > 0
      ? initBearingX
      : 2 *  pi - initBearingX;
  final finalBearingY =  sin(l2LngRadians - l1LngRadians) > 0
      ? 2 *  pi - initBearingY
      : initBearingY;

  final angle1 = b1Radians - finalBearingX;
  final angle2 = finalBearingY - b2Radians;

  if ( sin(angle1) == 0 &&  sin(angle2) == 0) return null;
  if ( sin(angle1) *  sin(angle2) < 0) return null;

  final num angle3 =  acos(- cos(angle1) *  cos(angle2) +
       sin(angle1) *  sin(angle2) *  cos(angularDistance));
  final num dst13 =  atan2(
       sin(angularDistance) *  sin(angle1) *  sin(angle2),
       cos(angle2) +  cos(angle1) *  cos(angle3));

  final num lat3 =  asin( sin(l1LatRadians) *  cos(dst13) +
       cos(l1LatRadians) *  sin(dst13) *  cos(b1Radians));

  final num lngRadiansDiff13 =  atan2(
       sin(b1Radians) *  sin(dst13) *  cos(l1LatRadians),
       cos(dst13) -  sin(l1LatRadians) *  sin(lat3));

  final l3LngRadians = l1LngRadians + lngRadiansDiff13;

  return LatLng(radianToDeg(lat3 as double),
      (radianToDeg(l3LngRadians as double) + 540) % 360 - 180);
}
