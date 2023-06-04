# Geodesy

[![pub package](https://img.shields.io/pub/v/geodesy.svg)](https://pub.dartlang.org/packages/geodesy)

A Dart library for implementing geodesic and trigonometric calculations based on a spherical Earth model for working with points and paths such as distances, bearings and destinations

## Getting Started

### Add the following line in your pubspec file

```dart
geodesy:
```

### Include the widget in your dart file

```dart
import 'package:geodesy/geodesy.dart';
```

## Usage

### Geodesy()

```dart
Geodesy geodesy = Geodesy();
```

### LatLng(double latitude, double longitude)

```dart
LatLng l = LatLng(22.308, 114.1716);
```

## Methods

### destinationPointByDistanceAndBearing(LatLng l, num distance, num bearing, [num radius])

Calculate a destination point given the distance and bearing. If raduis is not specified, Earth radius will be used.

```dart
LatLng distinationPoint = geodesy.destinationPointByDistanceAndBearing(l3, 2400, 420.2);
```

### midPointBetweenTwoGeoPoints(LatLng l1, LatLng l2)

Calcuate the midpoint bewteen teo geo points.

```dart
LatLng midpoint = geodesy.midPointBetweenTwoGeoPoints(l1, l2);
```

### distanceBetweenTwoGeoPoints(LatLng l1, LatLng l2, [num radius]) 

Calculate the distance in meters between two geo points. If raduis is not specified, Earth radius will be used.

```dart
num distance = geodesy.distanceBetweenTwoGeoPoints(l1, l2);
```

### bearingBetweenTwoGeoPoints(LatLng l1, LatLng l2)

Calculate the bearing from point l1 to point l2.

```dart
num finalBearing = geodesy.finalBearingBetweenTwoGeoPoints(l1, l2);
```

### finalBearingBetweenTwoGeoPoints(LatLng l1, LatLng l2)

Calculate the final bearing from point l1 to point l2.

```dart
num finalBearing = geodesy.finalBearingBetweenTwoGeoPoints(l1, l2);
```

### degreesToRadians(num degrees)

Convert degrees to radians

```dart
num l1LatRadians = degreesToRadians(l1.lat);
```

### radiansToDegrees(num radians)

Convert degrees to radians

```dart
num degrees = radiansToDegrees(latRadians);
```

### isGeoPointInBoundingBox(LatLng l, LatLng topLeft, LatLng bottomRight)

Check if a given geo point is in the bounding box

```dart
bool inBoundingBox = geodesy.isGeoPointInBoundingBox(l1, l2, l3);
```

### intersectionByPaths(LatLng l1, LatLng l2, num b1, num b2)

Calculate the geo point of intersection of two given paths

```dart
LatLng intersectionByPaths = geodesy.intersectionByPaths(l1, l2, b1, b2);
```

### crossTrackDistanceTo(LatLng l1, LatLng start, LatLng end, [num radius])

Calculate signed distance from a geo point to greate circle with start and end points

```dart
num distanceToGreatCircle = geodesy.crossTrackDistanceTo(l1, l2, l3);
```
  
### isGeoPointInPolygon(LatLng l, List<LatLng> polygon)

Check if a given geo point is in the a polygon using even-odd rule algorithm

```dart
bool isGeoPointInPolygon = geodesy.isGeoPointInPolygon(l, poly);
```

### pointsInRange(LatLng point, List<LatLng> pointsToCheck, num distance)

Get a list of points within a distance in meters from a given point

```dart
final point = LatLng(51.0, 0);
final pointsToCheck = <LatLng>[/* points here */];
final distance = 10000;
List<LatLng> geofencedPoints = geodesy.pointsInRange(point, pointsToCheck, distance);
```
 