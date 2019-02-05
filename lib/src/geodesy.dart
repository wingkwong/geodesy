import 'dart:math' as math;
import 'lat_lng.dart';

class Geodesy {
  final LatLng latlng;
  final num RADIUS = 6371e3; // meters
  final num PI = math.pi;

  const Geodesy() : latlng = const LatLng(0.0, 0.0);

  // calculate a destination point given the distance and bearing
  LatLng destinationPointByDistanceAndBearing(
      LatLng l, num distance, num bearing, num radius) {
    radius = radius ?? RADIUS;

    num angularDistanceRadius = distance / radius;
    num bearingRadians = degreesToRadians(bearing);

    num latRadians = degreesToRadians(l.lat);
    num lngRadians = degreesToRadians(l.lng);

    num sinLatRadians = math.sin(latRadians);
    num cosLatRadians = math.cos(latRadians);
    num sinAngularDistanceRadius = math.sin(angularDistanceRadius);
    num cosAngularDistanceRadius = math.cos(angularDistanceRadius);
    num sinBearingRadians = math.sin(bearingRadians);
    num cosBearingRadians = math.cos(bearingRadians);

    num sinLatRadians2 = sinLatRadians * cosAngularDistanceRadius +
        cosLatRadians * sinAngularDistanceRadius * cosBearingRadians;
    num latRadians2 = math.asin(sinLatRadians2);
    num y = sinBearingRadians * sinAngularDistanceRadius * cosLatRadians;
    num x = cosAngularDistanceRadius - sinLatRadians * sinLatRadians2;
    num lngRadians2 = lngRadians + math.atan2(y, x);
    return new LatLng(radiansToDegrees(latRadians2),
        (radiansToDegrees(lngRadians2) + 540) % 360 - 180);
  }

  // calcuate the midpoint bewteen teo geo points
  LatLng midPointBetweenTwoGeoPoints(LatLng l1, LatLng l2) {
    num l1LatRadians = degreesToRadians(l1.lat);
    num l1LngRadians = degreesToRadians(l1.lng);
    num l2LatRadians = degreesToRadians(l2.lat);
    num lngRadiansDiff = degreesToRadians(l2.lng - l1.lng);

    num vectorX = math.cos(l2LatRadians) * math.cos(lngRadiansDiff);
    num vectorY = math.cos(l2LatRadians) * math.sin(lngRadiansDiff);

    num x = math.sqrt((math.cos(l1LatRadians) + vectorX) *
            (math.cos(l1LatRadians) + vectorX) +
        vectorY * vectorY);
    num y = math.sin(l1LatRadians) + math.sin(l2LatRadians);
    num latRadians = math.atan2(y, x);
    num lngRadians =
        l1LngRadians + math.atan2(vectorY, math.cos(l1LatRadians) + vectorX);

    return new LatLng(radiansToDegrees(latRadians),
        (radiansToDegrees(lngRadians) + 540) % 360 - 180);
  }

  // calculate the distance in meters between two geo points
  num distanceBetweenTwoGeoPoints(LatLng l1, LatLng l2, num radius) {
    radius = radius ?? RADIUS;
    num R = radius;
    num l1LatRadians = degreesToRadians(l1.lat);
    num l1LngRadians = degreesToRadians(l1.lng);
    num l2LatRadians = degreesToRadians(l2.lat);
    num l2LngRadians = degreesToRadians(l2.lng);
    num latRadiansDiff = l2LatRadians - l1LatRadians;
    num lngRadiansDiff = l2LngRadians - l1LngRadians;

    num a = math.sin(latRadiansDiff / 2) * math.sin(latRadiansDiff / 2) +
        math.cos(l1LatRadians) *
            math.cos(l2LatRadians) *
            math.sin(lngRadiansDiff / 2) *
            math.sin(lngRadiansDiff / 2);
    num c = 2 * math.atan2(math.sqrt(a), math.sqrt(1 - a));
    num distance = R * c;

    return distance;
  }

  // calculate the bearing from point l1 to point l2
  num bearingBetweenTwoGeoPoints(LatLng l1, LatLng l2) {
    num l1LatRadians = degreesToRadians(l1.lat);
    num l2LatRadians = degreesToRadians(l2.lat);
    num lngRadiansDiff = degreesToRadians(l2.lng - l1.lng);
    num y = math.sin(lngRadiansDiff) * math.cos(l2LatRadians);
    num x = math.cos(l1LatRadians) * math.sin(l2LatRadians) -
        math.sin(l1LatRadians) *
            math.cos(l2LatRadians) *
            math.cos(lngRadiansDiff);
    num radians = math.atan2(y, x);

    return (radiansToDegrees(radians) + 360) % 360;
  }

  // calculate the final bearing from point l1 to point l2
  num finalBearingBetweenTwoGeoPoints(LatLng l1, LatLng l2) {
    return (bearingBetweenTwoGeoPoints(l2, l1) + 180) % 360;
  }

  // convert degrees to radians
  num degreesToRadians(num degrees) {
    return degrees * PI / 180;
  }

  // convert degrees to radians
  num radiansToDegrees(num radians) {
    return radians * 180 / PI;
  }

  // check if a given geo point is in the bouding box
  bool isGeoPointInBoudingBox(LatLng l, LatLng topLeft, LatLng bottomRight) {
    return topLeft.lat <= l.lat &&
            l.lat <= bottomRight.lat &&
            topLeft.lng <= l.lng &&
            l.lng <= bottomRight.lng
        ? true
        : false;
  }
}
