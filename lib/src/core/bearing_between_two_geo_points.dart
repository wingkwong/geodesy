import 'core.dart';

/// Calculate the bearing from point l1 to point l2
num bBetweenTwoGeoPoints(LatLng l1, LatLng l2) {
  final l1LatRadians = degToRadian(l1.latitude);
  final l2LatRadians = degToRadian(l2.latitude);
  final lngRadiansDiff = degToRadian(l2.longitude - l1.longitude);

  final y = sin(lngRadiansDiff) * cos(l2LatRadians);
  final x = cos(l1LatRadians) * sin(l2LatRadians) -
      sin(l1LatRadians) * cos(l2LatRadians) * cos(lngRadiansDiff);

  final radians = atan2(y, x);
  final degrees = radianToDeg(radians);

  return (degrees + 360) % 360;
}
