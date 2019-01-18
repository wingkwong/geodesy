import 'dart:math' as math;
import 'lat_lng.dart';

class Geodesy {
  final LatLng latlng;
  final double RADIUS = 6371e3; // meters
  final double PI = math.pi;

  const Geodesy() : 
    latlng = const LatLng(0.0, 0.0);

  // calculate the distance in meters between two geo points
  double distanceBetweenTwoGeoPoints(LatLng l1, LatLng l2, double radius) {
      radius = radius ?? RADIUS;
      var R = radius;
      double l1LatRadians = degreesToRadians(l1.lat);
      double l1LngRadians = degreesToRadians(l1.lng);
      double l2LatRadians = degreesToRadians(l2.lat);
      double l2LngRadians = degreesToRadians(l2.lng);
      double latRadiansDiff = l2LatRadians - l1LatRadians;
      double lngRadiansDiff = l2LngRadians - l1LngRadians;

      var a = math.sin(latRadiansDiff/2) * math.sin(latRadiansDiff/2)
            + math.cos(l1LatRadians) * math.cos(l2LatRadians)
            * math.sin(lngRadiansDiff/2) * math.sin(lngRadiansDiff/2);
      var c = 2 * math.atan2(math.sqrt(a), math.sqrt(1-a));
      double distance = R * c;

    return distance;
   }

   // convert degrees to radians
   double degreesToRadians(double degrees) {
     return degrees * PI / 180;
   }
} 