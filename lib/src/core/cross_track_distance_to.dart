import 'core.dart';

/// Calculate signed distance from a geo point
/// to create circle with start and end points
num cTrackDistanceTo(LatLng l1, LatLng start, LatLng end, [num? radius]) {
  final R = radius ?? 6371e3;

  final distStartL1 = dBetweenTwoGeoPoints(start, l1, R) / R;
  final bearingStartL1 = degToRadian(bBetweenTwoGeoPoints(start, l1) as double);
  final bearingStartEnd =
      degToRadian(bBetweenTwoGeoPoints(start, end) as double);

  final x = asin(sin(distStartL1) * sin(bearingStartL1 - bearingStartEnd));

  return x * R;
}
