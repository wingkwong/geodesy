# Geodesy

[![pub package](https://img.shields.io/pub/v/geodesy.svg)](https://pub.dartlang.org/packages/geodesy)

A Dart library for implementing geodesic and trigonometric calculations based on a spherical Earth model for working with points and paths such as distances, bearings and destinations

## Getting Started

### Add the following line in your `pubspec.yml` file

```dart
geodesy:<latest_version>
```

### Include the widget in your dart file

```dart
import 'package:geodesy/geodesy.dart';
```

## Usage

### Geodesy()

```dart
final Geodesy geodesy = Geodesy();
```

### LatLng(double latitude, double longitude)

```dart
final LatLng l = LatLng(22.308, 114.1716);
```

## Methods

### destinationPointByDistanceAndBearing(LatLng l, num distance, num bearing, [num radius])

Calculate a destination point given the distance and bearing. If radius is not specified, Earth radius will be used.

```dart
final LatLng destinationPoint = geodesy.destinationPointByDistanceAndBearing(l3, 2400, 420.2);
```

### midPointBetweenTwoGeoPoints(LatLng l1, LatLng l2)

Calculate the midpoint between teo geo points.

```dart
final LatLng midpoint = geodesy.midPointBetweenTwoGeoPoints(l1, l2);
```

### distanceBetweenTwoGeoPoints(LatLng l1, LatLng l2, [num radius])

Calculate the distance in meters between two geo points. If radius is not specified, Earth radius will be used.

```dart
final num distance = geodesy.distanceBetweenTwoGeoPoints(l1, l2);
```

### bearingBetweenTwoGeoPoints(LatLng l1, LatLng l2)

Calculate the bearing from point l1 to point l2.

```dart
final num finalBearing = geodesy.finalBearingBetweenTwoGeoPoints(l1, l2);
```

### finalBearingBetweenTwoGeoPoints(LatLng l1, LatLng l2)

Calculate the final bearing from point l1 to point l2.

```dart
final num finalBearing = geodesy.finalBearingBetweenTwoGeoPoints(l1, l2);
```

### degreesToRadians(num degrees)

Convert degrees to radians

```dart
final num l1LatRadians = degreesToRadians(l1.lat);
```

### radiansToDegrees(num radians)

Convert degrees to radians

```dart
final num degrees = radiansToDegrees(latRadians);
```

### isGeoPointInBoundingBox(LatLng l, LatLng topLeft, LatLng bottomRight)

Check if a given geo point is in the bounding box

```dart
final bool inBoundingBox = geodesy.isGeoPointInBoundingBox(l1, l2, l3);
```

### intersectionByPaths(LatLng l1, LatLng l2, num b1, num b2)

Calculate the geo point of intersection of two given paths

```dart
final LatLng intersectionByPaths = geodesy.intersectionByPaths(l1, l2, b1, b2);
```

### crossTrackDistanceTo(LatLng l1, LatLng start, LatLng end, [num radius])

Calculate signed distance from a geo point to create circle with start and end points

```dart
final num distanceToGreatCircle = geodesy.crossTrackDistanceTo(l1, l2, l3);
```
  
### isGeoPointInPolygon(LatLng l, List<LatLng> polygon)

Check if a given geo point is in the a polygon using even-odd rule algorithm

```dart
final bool isGeoPointInPolygon = geodesy.isGeoPointInPolygon(l, poly);
```

### pointsInRange(LatLng point, List<LatLng> pointsToCheck, num distance)

Get a list of points within a distance in meters from a given point

```dart
final point = LatLng(51.0, 0);
final pointsToCheck = <LatLng>[/* points here */];
final distance = 10000;
List<LatLng> geoFencedPoints = geodesy.pointsInRange(point, pointsToCheck, distance);
```

### getRectangleBounds(List<LatLng> polygonCoords)

Similar to PolygonEnvelop in Python

```dart
  List<LatLng> polygonCoords = [
    const LatLng(37.7749, -122.4194),
    const LatLng(37.3382, -121.8863),
    const LatLng(37.7749, -121.4194),
    const LatLng(37.7749, -123.4194),
  ];

  List<LatLng> rectangleBounds = geodesy.getRectangleBounds(polygonCoords);
```

### Great-circle distance between two points using the Haversine formula

Calculate the Great-Circle Distance between two Geo points

```dart
num latitude1 = 37.7749;
  num longitude1 = -122.4194;
  num latitude2 = 37.3382;
  num longitude2 = -121.8863;

  num greatCircleDistance = geodesy.greatCircleDistanceBetweenTwoGeoPoints(
      latitude1, longitude1, latitude2, longitude2);
```

### calculateBoundingBox(LatLng centerPoint, num distanceInKm)

Given the Latitude and Longitude and distance in kilometers it calculate the bounding box value

```dart
  final centerPoint = const LatLng(
      37.7749, -122.4194); // Example central position (San Francisco)

  final distanceInKm = 1.0; // Example distance in kilometers

  final boundingBox = geodesy.calculateBoundingBox(centerPoint, distanceInKm);
```
