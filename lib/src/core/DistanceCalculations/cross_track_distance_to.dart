import '../core.dart';

/// Track Distance class for calculating the signed distance between a
/// geographical point  and the great circle defined by a start and end point.
class TrackDistance {
  /// Calculate the signed distance from a geographic point to the great circle
  /// defined by the start and end points, also known as cross-track distance.
  ///
  /// The cross-track distance is the shortest distance from the point `l1` to
  ///
  /// the great circle defined by the line between `start` and `end`.
  /// It can be negative or positive depending on whether the point is to
  /// the left or right of the path.
  ///
  /// [l1] - The geographic point for which to calculate the cross-track
  /// distance.
  ///
  /// [start] - The starting point of the great circle path.
  ///
  /// [end] - The ending point of the great circle path.
  ///
  /// [radius] - (Optional) The radius of the Earth in meters. If not provided,
  /// it  defaults to the mean radius of the Earth
  /// (approximately 6371 kilometers).
  ///
  /// Returns the cross-track distance in meters. A positive value indicates
  ///
  /// that the point `l1` is to the right of the great circle path,
  /// and a negative value
  /// indicates that it is to the left.
  static num crossTrackDistanceTo(LatLng l1, LatLng start, LatLng end,
      [num? radius]) {
    // Calculate the radius of the Earth if not provided.
    final R = radius ?? 6371e3;

    // Calculate the distance between start and l1 in radians.
    final distStartL1 = GeoPoints.distanceBetweenTwoGeoPoints(start, l1, R) / R;

    // Calculate the initial bearing from start to l1 in radians.
    final bearingStartL1 = degToRadian(
        BearingBetweenTwoGeoPoints.bearingBetweenTwoGeoPoints(start, l1)
            .toDouble());

    // Calculate the initial bearing from start to end in radians.
    final bearingStartEnd = degToRadian(
        BearingBetweenTwoGeoPoints.bearingBetweenTwoGeoPoints(start, end)
            .toDouble());

    // Calculate the cross-track distance using the spherical law of sines.
    final x = asin(sin(distStartL1) * sin(bearingStartL1 - bearingStartEnd));

    // Return the cross-track distance in meters.
    return x * R;
  }
}
