import '../core.dart';

///
class GeoPoints {
  /// Calculate the Distance in meters between two geo points
  static num distanceBetweenTwoGeoPoints(LatLng l1, LatLng l2, [num? radius]) {
    final R = radius ?? 6371e3;
    final num l1LatRadians = degToRadian(l1.latitude);
    final num l1LngRadians = degToRadian(l1.longitude);
    final num l2LatRadians = degToRadian(l2.latitude);
    final num l2LngRadians = degToRadian(l2.longitude);

    final latRadiansDiff = l2LatRadians - l1LatRadians;
    final lngRadiansDiff = l2LngRadians - l1LngRadians;

    final num a = sin(latRadiansDiff / 2) * sin(latRadiansDiff / 2) +
        cos(l1LatRadians) *
            cos(l2LatRadians) *
            sin(lngRadiansDiff / 2) *
            sin(lngRadiansDiff / 2);
    final num c = 2 * atan2(sqrt(a), sqrt(1 - a));
    final distance = R * c;

    return distance;
  }

  /// Great-circle distance between two points using the Haversine formula
  static num greatCircleDistanceBetweenTwoGeoPoints(
      num lat1, num lon1, num lat2, num lon2) {
    final num earthRadius = 6371e3; // Radius of the earth in kilometers

    num dLat = degToRadian(lat2.toDouble() - lat1.toDouble());
    num dLon = degToRadian(lon2.toDouble() - lon1.toDouble());

    num a = sin(dLat / 2) * sin(dLat / 2) +
        cos(degToRadian(lat1.toDouble())) *
            cos(degToRadian(lat2.toDouble())) *
            sin(dLon / 2) *
            sin(dLon / 2);
    num c = 2 * atan2(sqrt(a), sqrt(1 - a));
    num distance = earthRadius * c;

    return distance;
  }

  /// Calculate the geo point of intersection of two given paths
  static LatLng? intersectionOfTwoGeoPointsByPaths(
      LatLng l1, LatLng l2, num b1, num b2) {
    final num l1LatRadians = degToRadian(l1.latitude);
    final num l1LngRadians = degToRadian(l1.longitude);
    final num l2LatRadians = degToRadian(l2.latitude);
    final num l2LngRadians = degToRadian(l2.longitude);
    final num b1Radians = degToRadian(b1 as double);
    final num b2Radians = degToRadian(b2 as double);

    final latRadiansDiff = l2LatRadians - l1LatRadians;
    final lngRadiansDiff = l2LngRadians - l1LngRadians;

    final num angularDistance = 2 *
        asin(sqrt(sin(latRadiansDiff / 2) * sin(latRadiansDiff / 2) +
            cos(l1LatRadians) *
                cos(l2LatRadians) *
                sin(lngRadiansDiff / 2) *
                sin(lngRadiansDiff / 2)));

    if (angularDistance == 0) return null;

    num initBearingX = acos(
        (sin(l2LatRadians) - sin(l1LatRadians) * cos(angularDistance)) /
            (sin(angularDistance) * cos(l1LatRadians)));
    if (initBearingX.isNaN) initBearingX = 0;

    num initBearingY = acos(
        (sin(l1LatRadians) - sin(l2LatRadians) * cos(angularDistance)) /
            (sin(angularDistance) * cos(l2LatRadians)));

    final finalBearingX = sin(l2LngRadians - l1LngRadians) > 0
        ? initBearingX
        : 2 * pi - initBearingX;
    final finalBearingY = sin(l2LngRadians - l1LngRadians) > 0
        ? 2 * pi - initBearingY
        : initBearingY;

    final angle1 = b1Radians - finalBearingX;
    final angle2 = finalBearingY - b2Radians;

    if (sin(angle1) == 0 && sin(angle2) == 0) return null;
    if (sin(angle1) * sin(angle2) < 0) return null;

    final num angle3 = acos(-cos(angle1) * cos(angle2) +
        sin(angle1) * sin(angle2) * cos(angularDistance));
    final num dst13 = atan2(sin(angularDistance) * sin(angle1) * sin(angle2),
        cos(angle2) + cos(angle1) * cos(angle3));

    final num lat3 = asin(sin(l1LatRadians) * cos(dst13) +
        cos(l1LatRadians) * sin(dst13) * cos(b1Radians));

    final num lngRadiansDiff13 = atan2(
        sin(b1Radians) * sin(dst13) * cos(l1LatRadians),
        cos(dst13) - sin(l1LatRadians) * sin(lat3));

    final l3LngRadians = l1LngRadians + lngRadiansDiff13;

    return LatLng(radianToDeg(lat3 as double),
        (radianToDeg(l3LngRadians as double) + 540) % 360 - 180);
  }

  /// Check if a given geo point is in the a polygon
  /// using even-odd rule algorithm
  static bool isGeoPointInPolygon(LatLng l, List<LatLng> polygon) {
    bool isInPolygon = false;
    for (int i = 0, j = polygon.length - 1; i < polygon.length; j = i++) {
      final vertexI = polygon[i];
      final vertexJ = polygon[j];

      final aboveLatitude =
          (vertexI.latitude <= l.latitude) && (l.latitude < vertexJ.latitude);
      final belowLatitude =
          (vertexJ.latitude <= l.latitude) && (l.latitude < vertexI.latitude);
      final withinLongitude = l.longitude <
          (vertexJ.longitude - vertexI.longitude) *
                  (l.latitude - vertexI.latitude) /
                  (vertexJ.latitude - vertexI.latitude) +
              vertexI.longitude;

      if ((aboveLatitude || belowLatitude) && withinLongitude) {
        isInPolygon = !isInPolygon;
      }
    }

    return isInPolygon;
  }

  /// Calculate the midpoint between teo geo points
  static LatLng midPointBetweenTwoGeoPoints(LatLng l1, LatLng l2) {
    final num l1LatRadians = degToRadian(l1.latitude);
    final num l1LngRadians = degToRadian(l1.longitude);
    final num l2LatRadians = degToRadian(l2.latitude);
    final num lngRadiansDiff = degToRadian(l2.longitude - l1.longitude);

    final num vectorX = cos(l2LatRadians) * cos(lngRadiansDiff);
    final num vectorY = cos(l2LatRadians) * sin(lngRadiansDiff);

    final num x = sqrt(pow((cos(l1LatRadians) + vectorX), 2) + pow(vectorY, 2));
    final num y = sin(l1LatRadians) + sin(l2LatRadians);
    final num latRadians = atan2(y, x);
    final num lngRadians =
        l1LngRadians + atan2(vectorY, cos(l1LatRadians) + vectorX);

    return LatLng(radianToDeg(latRadians as double),
        (radianToDeg(lngRadians as double) + 540) % 360 - 180);
  }
}
