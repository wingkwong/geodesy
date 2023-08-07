import 'core.dart';

///
class TrackDistance {
  /// Calculate signed distance from a geo point
  /// to create circle with start and end points
  static num crossTrackDistanceTo(LatLng l1, LatLng start, LatLng end,
      [num? radius]) {
    final R = radius ?? 6371e3;

    final distStartL1 = GeoPoints.distanceBetweenTwoGeoPoints(start, l1, R) / R;
    final bearingStartL1 = degToRadian(
        BearingBetweenTwoGeoPoints.bearingBetweenTwoGeoPoints(start, l1)
            as double);
    final bearingStartEnd = degToRadian(
        BearingBetweenTwoGeoPoints.bearingBetweenTwoGeoPoints(start, end)
            as double);

    final x = asin(sin(distStartL1) * sin(bearingStartL1 - bearingStartEnd));

    return x * R;
  }
}
