# geodesy
A Dart library for implementing geodesic and trigonometric calculations based on a spherical Earth model for working with points and paths such as distances, bearings and destinations

## Getting Started
### Add the following line in your pubspec file
````
geodesy:
````

###  Include the widget in your dart file
````
import 'package:geodesy/geodesy.dart';
````

## Usage 

### Geodesy()
````
Geodesy geodesy = Geodesy();
````

### LatLng(double latitude, double longitude)
````
LatLng l = LatLng(22.308, 114.1716);
````

## Methods
### destinationPointByDistanceAndBearing(LatLng l, num distance, num bearing, [num radius])
Calculate a destination point given the distance and bearing. If raduis is not specified, Earth radius will be used.
````
LatLng distinationPoint = geodesy.destinationPointByDistanceAndBearing(l3, 2400, 420.2);
````

### midPointBetweenTwoGeoPoints(LatLng l1, LatLng l2)
Calcuate the midpoint bewteen teo geo points.
````
LatLng midpoint = geodesy.midPointBetweenTwoGeoPoints(l1, l2);
````

### distanceBetweenTwoGeoPoints(LatLng l1, LatLng l2, [num radius]) 
Calculate the distance in meters between two geo points. If raduis is not specified, Earth radius will be used.
````
num distance = geodesy.distanceBetweenTwoGeoPoints(l1, l2);
````

### bearingBetweenTwoGeoPoints(LatLng l1, LatLng l2)
Calculate the bearing from point l1 to point l2.
````
num finalBearing = geodesy.finalBearingBetweenTwoGeoPoints(l1, l2);
````

### finalBearingBetweenTwoGeoPoints(LatLng l1, LatLng l2)
Calculate the final bearing from point l1 to point l2.
````
num finalBearing = geodesy.finalBearingBetweenTwoGeoPoints(l1, l2);
````

### degreesToRadians(num degrees)
Convert degrees to radians
````
num l1LatRadians = degreesToRadians(l1.lat);
````

### radiansToDegrees(num radians)
Convert degrees to radians
````
num degrees = radiansToDegrees(latRadians);
````

### isGeoPointInBoudingBox(LatLng l, LatLng topLeft, LatLng bottomRight)
Check if a given geo point is in the bouding box
````
bool inBoudingBox = geodesy.isGeoPointInBoudingBox(l1, l2, l3);
````

### intersectionByPaths(LatLng l1, LatLng l2, num b1, num b2) 
Calculate the geo point of intersection of two given paths
````
LatLng intersectionByPaths = geodesy.intersectionByPaths(l1, l2, b1, b2);
````

### crossTrackDistanceTo(LatLng l1, LatLng start, LatLng end, [num radius])
Calculate signed distance from a geo point to greate circle with start and end points
````
num distanceToGreatCircle = geodesy.crossTrackDistanceTo(l1, l2, l3);
````
  
### isGeoPointInPolygon(LatLng l, List<LatLng> polygon)
Check if a given geo point is in the a polygon using even-odd rule algorithm
````
bool isGeoPointInPolygon = geodesy.isGeoPointInPolygon(l, poly);
````
 