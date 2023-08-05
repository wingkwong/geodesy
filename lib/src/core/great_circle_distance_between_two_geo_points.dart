import 'core.dart';

/// Great-circle distance between two points using the Haversine formula
num gCircleDistanceBetweenTwoGeoPoints(num lat1, num lon1, num lat2, num lon2) {
  final num earthRadius = 6371e3; // Radius of the earth in kilometers

  num dLat = degToRadian(lat2.toDouble() - lat1.toDouble());
  num dLon = degToRadian(lon2.toDouble() - lon1.toDouble());

  num a =  sin(dLat / 2) *  sin(dLat / 2) +
       cos(degToRadian(lat1.toDouble())) *
           cos(degToRadian(lat2.toDouble())) *
           sin(dLon / 2) *
           sin(dLon / 2);
  num c = 2 *  atan2( sqrt(a),  sqrt(1 - a));
  num distance = earthRadius * c;

  return distance;
}
