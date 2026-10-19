import '../core.dart';

/// Vincenty Distance class for calculating geodesic distances between two points on
/// the surface of an ellipsoid using the Vincenty formula.
class VincentyDistance {
  /// Calculates the geodesic distance between two points on the surface of an
  /// ellipsoid using the Vincenty formula.
  ///
  /// The Vincenty formula provides a highly accurate method for calculating
  /// geodesic distances, which are the shortest distances between two points
  /// on the curved surface of an ellipsoid (such as the Earth).
  ///
  /// [lat1] - The latitude of the first point in decimal degrees.
  ///
  /// [lon1] - The longitude of the first point in decimal degrees.
  ///
  /// [lat2] - The latitude of the second point in decimal degrees.
  ///
  /// [lon2] - The longitude of the second point in decimal degrees.
  ///
  /// Returns the geodesic distance between the two points in meters.
  ///
  /// Throws [ArgumentError] for non-finite coordinates, latitudes outside
  /// [-90, 90], or longitudes outside [-180, 180]. Throws [StateError] if
  /// Vincenty's iteration does not converge within 200 iterations, which can
  /// occur for antipodal or nearly antipodal points.
  static double vincentyDistance(
    double lat1,
    double lon1,
    double lat2,
    double lon2,
  ) {
    for (final coordinate in {'lat1': lat1, 'lat2': lat2}.entries) {
      if (!coordinate.value.isFinite || coordinate.value.abs() > 90) {
        throw ArgumentError.value(coordinate.value, coordinate.key,
            'Must be finite and in [-90, 90]');
      }
    }
    for (final coordinate in {'lon1': lon1, 'lon2': lon2}.entries) {
      if (!coordinate.value.isFinite || coordinate.value.abs() > 180) {
        throw ArgumentError.value(coordinate.value, coordinate.key,
            'Must be finite and in [-180, 180]');
      }
    }

    // Equivalent longitudes at the dateline and at a pole are coincident.
    final longitudeDifference = (lon2 - lon1 + 180) % 360 - 180;
    if (lat1 == lat2 && (longitudeDifference == 0 || lat1.abs() == 90)) {
      return 0;
    }

    final double a = 6378137.0; // WGS-84 semi-major axis in meters
    final double f = 1 / 298.257223563; // WGS-84 flattening
    final double b = (1 - f) * a; // WGS-84 semi-minor axis in meters

    final double phi1 = lat1.toRadians();
    final double phi2 = lat2.toRadians();
    final double deltaLambda = longitudeDifference.toRadians();

    final double u1 = atan((1 - f) * tan(phi1));
    final double u2 = atan((1 - f) * tan(phi2));

    final double sinU1 = sin(u1);
    final double cosU1 = cos(u1);
    final double sinU2 = sin(u2);
    final double cosU2 = cos(u2);

    double lambda = deltaLambda;
    double lambdaP;
    double sinSigma;
    double cosSigma;
    double sigma;
    double sinAlpha;
    double cosSqAlpha;
    double cos2SigmaM;
    double C;
    var iterations = 0;

    do {
      final double sinLambda = sin(lambda);
      final double cosLambda = cos(lambda);
      sinSigma = sqrt((cosU2 * sinLambda) * (cosU2 * sinLambda) +
          (cosU1 * sinU2 - sinU1 * cosU2 * cosLambda) *
              (cosU1 * sinU2 - sinU1 * cosU2 * cosLambda));

      cosSigma = sinU1 * sinU2 + cosU1 * cosU2 * cosLambda;
      if (sinSigma == 0) {
        if (cosSigma > 0) return 0;
        throw StateError(
            'Vincenty distance is indeterminate for antipodal points');
      }
      sigma = atan2(sinSigma, cosSigma);

      sinAlpha = cosU1 * cosU2 * sinLambda / sinSigma;
      cosSqAlpha = max(0.0, 1 - sinAlpha * sinAlpha);
      // On an equatorial geodesic cosSqAlpha is zero, making the general
      // expression indeterminate. Vincenty's equatorial limit is zero.
      cos2SigmaM =
          cosSqAlpha == 0 ? 0 : cosSigma - 2 * sinU1 * sinU2 / cosSqAlpha;

      C = f / 16 * cosSqAlpha * (4 + f * (4 - 3 * cosSqAlpha));

      lambdaP = lambda;
      lambda = deltaLambda +
          (1 - C) *
              f *
              sinAlpha *
              (sigma +
                  C *
                      sinSigma *
                      (cos2SigmaM +
                          C * cosSigma * (-1 + 2 * cos2SigmaM * cos2SigmaM)));
      iterations++;
    } while ((lambda - lambdaP).abs() > 1e-12 && iterations < 200);

    if (!lambda.isFinite || (lambda - lambdaP).abs() > 1e-12) {
      throw StateError(
          'Vincenty distance failed to converge after 200 iterations');
    }

    final double uSq = cosSqAlpha * ((a * a - b * b) / (b * b));
    final double A =
        1 + uSq / 16384 * (4096 + uSq * (-768 + uSq * (320 - 175 * uSq)));
    final double B = uSq / 1024 * (256 + uSq * (-128 + uSq * (74 - 47 * uSq)));
    final double deltaSigma = B *
        sinSigma *
        (cos2SigmaM +
            B /
                4 *
                (cosSigma * (-1 + 2 * cos2SigmaM * cos2SigmaM) -
                    B /
                        6 *
                        cos2SigmaM *
                        (-3 + 4 * sinSigma * sinSigma) *
                        (-3 + 4 * cos2SigmaM * cos2SigmaM)));

    final double distance = b * A * (sigma - deltaSigma);

    return distance;
  }
}
