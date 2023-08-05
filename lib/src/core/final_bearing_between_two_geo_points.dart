import 'core.dart';

/// calculate the final bearing from point l1 to point l2
num fBearingBetweenTwoGeoPoints(LatLng l1, LatLng l2) {
  return (bBetweenTwoGeoPoints(l2, l1) + 180) % 360;
}
