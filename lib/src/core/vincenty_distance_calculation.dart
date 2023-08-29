import 'core.dart';

/// Vincenty formula for Geodesic Distance Calculation
class VincentyDistance {
<<<<<<< HEAD
=======
  /// Calculate the geodesic distance between two points 
  /// on the surface of an ellipsoid, such as the Earth.
>>>>>>> 6af10d56dc117c68b23f50df44ca2686268af241
  static double vincentyDistance(
    double lat1,
    double lon1,
    double lat2,
    double lon2,
  ) {
    final double a = 6378137.0; // WGS-84 semi-major axis in meters
    final double f = 1 / 298.257223563; // WGS-84 flattening
    final double b = (1 - f) * a; // WGS-84 semi-minor axis in meters

    final double phi1 = lat1.toRadians();
    final double phi2 = lat2.toRadians();
    final double deltaLambda = (lon2 - lon1).toRadians();

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

    do {
      final double sinLambda = sin(lambda);
      final double cosLambda = cos(lambda);
      sinSigma = sqrt((cosU2 * sinLambda) * (cosU2 * sinLambda) +
          (cosU1 * sinU2 - sinU1 * cosU2 * cosLambda) *
              (cosU1 * sinU2 - sinU1 * cosU2 * cosLambda));

      cosSigma = sinU1 * sinU2 + cosU1 * cosU2 * cosLambda;
      sigma = atan2(sinSigma, cosSigma);

      sinAlpha = cosU1 * cosU2 * sinLambda / sinSigma;
      cosSqAlpha = 1 - sinAlpha * sinAlpha;
      cos2SigmaM = cosSigma - 2 * sinU1 * sinU2 / cosSqAlpha;

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
    } while ((lambda - lambdaP).abs() > 1e-12);

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
