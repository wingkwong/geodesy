import 'dart:math' as math;
import 'lat_lng.dart';

class Geodesy {
  final LatLng latlng;
  final num RADIUS = 6371e3; // meters
  final num PI = math.pi;

  const Geodesy() : 
    latlng = const LatLng(0.0, 0.0);

  // calculate the distance in meters between two geo points
  num distanceBetweenTwoGeoPoints(LatLng l1, LatLng l2, num radius) {
      radius = radius ?? RADIUS;
      var R = radius;
      num l1LatRadians = degreesToRadians(l1.lat);
      num l1LngRadians = degreesToRadians(l1.lng);
      num l2LatRadians = degreesToRadians(l2.lat);
      num l2LngRadians = degreesToRadians(l2.lng);
      num latRadiansDiff = l2LatRadians - l1LatRadians;
      num lngRadiansDiff = l2LngRadians - l1LngRadians;

      var a = math.sin(latRadiansDiff/2) * math.sin(latRadiansDiff/2)
            + math.cos(l1LatRadians) * math.cos(l2LatRadians)
            * math.sin(lngRadiansDiff/2) * math.sin(lngRadiansDiff/2);
      var c = 2 * math.atan2(math.sqrt(a), math.sqrt(1-a));
      num distance = R * c;

    return distance;
   }

   LatLng destinationPointByDistanceAndBearing(LatLng l, num distance, num bearing, num radius) {
     radius = radius ?? RADIUS;

      var angularDistanceRadius = distance / radius;
      var bearingRadians = degreesToRadians(bearing);

      var latRadians = degreesToRadians(l.lat);
      var lngRadians = degreesToRadians(l.lng);

      num sinLatRadians = math.sin(latRadians);
      num cosLatRadians = math.cos(latRadians);
      num sinAngularDistanceRadius = math.sin(angularDistanceRadius);
      num cosAngularDistanceRadius = math.cos(angularDistanceRadius);
      num sinBearingRadians = math.sin(bearingRadians);
      num cosBearingRadians = math.cos(bearingRadians);

      num sinLatRadians2 = sinLatRadians * cosAngularDistanceRadius + cosLatRadians * sinAngularDistanceRadius * cosBearingRadians;
      num latRadians2 = math.asin(sinLatRadians2);
      num y = sinBearingRadians * sinAngularDistanceRadius * cosLatRadians;
      num x = cosAngularDistanceRadius - sinLatRadians * sinLatRadians2;
      num lngRadians2 = lngRadians + math.atan2(y, x);
      return new LatLng(radiansToDegrees(latRadians2), (radiansToDegrees(lngRadians2) + 540) % 360 - 180);
   }

   // convert degrees to radians
   num degreesToRadians(num degrees) {
     return degrees * PI / 180;
   }

   // convert degrees to radians
   num radiansToDegrees(num radians) {
     return radians * 180 / PI;
   }
} 