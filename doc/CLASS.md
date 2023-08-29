# Geodesy Class

The `Geodesy` class provides a collection of methods for performing various geodetic calculations, including distance calculations, point intersections, and more. This class is designed to work with geographical coordinates in the form of latitude and longitude.

```dart
final Geodesy geodesy = Geodesy();
```

Call any function which is given blow using geodesy Instance

## Methods

### Destination Point By Distance And Bearing

Calculate a destination point given an initial point, a distance, a bearing, and an optional radius.

```dart
LatLng destinationPointByDistanceAndBearing(
  LatLng initialPoint, num distance, num bearing, [num? radius]
)
```

- `initialPoint` (LatLng): The initial geographical point (latitude, longitude).
- `distance` (num): The distance in meters.
- `bearing` (num): The bearing angle in degrees.
- `radius` (num, optional): The Earth's radius (default is `null`).

Returns a `LatLng` object representing the calculated destination point.

### Mid Point Between Two GeoPoints

Calculate the geographical midpoint between two points.

```dart
LatLng midPointBetweenTwoGeoPoints(LatLng point1, LatLng point2)
```

- `point1` (LatLng): The first geographical point (latitude, longitude).
- `point2` (LatLng): The second geographical point (latitude, longitude).

Returns a `LatLng` object representing the midpoint between the two input points.

### Intersection By Paths

Calculate the intersection point of two paths defined by points and bearings.

```dart
LatLng? intersectionByPaths(
  LatLng point1, LatLng point2, num bearing1, num bearing2
)
```

- `point1` (LatLng): The first geographical point (latitude, longitude).
- `point2` (LatLng): The second geographical point (latitude, longitude).
- `bearing1` (num): The bearing angle for the first path in degrees.
- `bearing2` (num): The bearing angle for the second path in degrees.

Returns a `LatLng` object representing the intersection point or `null` if no intersection is found.

### Distance Between Two GeoPoints

Calculate the distance in meters between two geographical points.

```dart
num distanceBetweenTwoGeoPoints(
  LatLng point1, LatLng point2, [num? radius]
)
```

- `point1` (LatLng): The first geographical point (latitude, longitude).
- `point2` (LatLng): The second geographical point (latitude, longitude).
- `radius` (num, optional): The Earth's radius (default is `null`).

Returns the distance in meters between the two input points.

### Bearing Between Two GeoPoints

Calculate the bearing angle from one point to another.

```dart
num bearingBetweenTwoGeoPoints(LatLng fromPoint, LatLng toPoint)
```

- `fromPoint` (LatLng): The starting geographical point (latitude, longitude).
- `toPoint` (LatLng): The target geographical point (latitude, longitude).

Returns the bearing angle in degrees from the starting point to the target point.

### Final BearingBetween Two GeoPoints

Calculate the final bearing angle from one point to another.

```dart
num finalBearingBetweenTwoGeoPoints(LatLng fromPoint, LatLng toPoint)
```

- `fromPoint` (LatLng): The starting geographical point (latitude, longitude).
- `toPoint` (LatLng): The target geographical point (latitude, longitude).

Returns the final bearing angle in degrees from the starting point to the target point.

### Cross Track Distance To

Calculate the signed distance from a point to a line defined by two other points.

```dart
num crossTrackDistanceTo(
  LatLng point, LatLng start, LatLng end, [num? radius]
)
```

- `point` (LatLng): The point to calculate the distance from (latitude, longitude).
- `start` (LatLng): The starting point of the line (latitude, longitude).
- `end` (LatLng): The ending point of the line (latitude, longitude).
- `radius` (num, optional): The Earth's radius (default is `null`).

Returns the signed cross-track distance in meters.

### Is GeoPoint In BoundingBox

Check if a given point is within a bounding box defined by two corner points.

```dart
bool isGeoPointInBoundingBox(
  LatLng point, LatLng topLeft, LatLng bottomRight
)
```

- `point` (LatLng): The point to check (latitude, longitude).
- `topLeft` (LatLng): The top-left corner of the bounding box (latitude, longitude).
- `bottomRight` (LatLng): The bottom-right corner of the bounding box (latitude, longitude).

Returns `true` if the point is within the bounding box, otherwise `false`.

### IsGeo Point In Polygon

Check if a given point is within a polygon using the even-odd rule algorithm.

```dart
bool isGeoPointInPolygon(LatLng point, List<LatLng> polygon)
```

- `point` (LatLng): The point to check (latitude, longitude).
- `polygon` (List`<LatLng>`): A list of vertices defining the polygon.

Returns `true` if the point is within the polygon, otherwise `false`.

### Points In Range

Get a list of points within a certain distance from a given point.

```dart
List<LatLng> pointsInRange(LatLng point, List<LatLng> pointsToCheck, num distance)
```

- `point` (LatLng): The center point (latitude, longitude).
- `pointsToCheck` (List`<LatLng>`): List of points to check against.
- `distance` (num): The maximum distance in meters.

Returns a list of `LatLng` points within the specified distance from the center point.

### Great Circle Distance Between Two GeoPoints

Calculate the great-circle distance between two points using the Haversine formula.

```dart
num greatCircleDistanceBetweenTwoGeoPoints(
  num lat1, num lon1, num lat2, num lon2
)
```

- `lat1` (num): Latitude of the first point.
- `lon1` (num): Longitude of the first point.
- `lat2` (num): Latitude of the second point.
- `lon2` (num): Longitude of the second point.

Returns the great-circle distance in meters.

### Get Rectangle Bounds

Get the bounding rectangle for a polygon defined by its vertices.

```dart
List<LatLng> getRectangleBounds(List<LatLng> polygonCoords)
```

- `polygonCoords` (List`<LatLng>`): List of vertices defining the polygon.

Returns a list of `LatLng` points representing the bounding rectangle's corners.

### Calculate BoundingBox

Calculate the bounding box around a point with a given distance.

```dart
List<LatLng> calculateBoundingBox(LatLng centerPoint, num distanceInKm)
```

- `centerPoint` (LatLng): The center point (latitude, longitude).
- `distanceInKm` (num): The distance in kilometers.

Returns a list of `LatLng` points representing the bounding box's corners.

### Find Polygon Centroid

Find the centroid of a polygon defined by its vertices.

```dart
LatLng findPolygonCentroid(List<LatLng> polygon)
```

- `polygon` (List`<LatLng>`): List of vertices defining the polygon.

Returns a `LatLng` object representing the centroid of the polygon.

### Get Polygon Intersection

Calculate the intersection of

 two polygons defined by their vertices.

```dart
List<LatLng> getPolygonIntersection(List<LatLng> polygon1, List<LatLng> polygon2)
```

- `polygon1` (List`<LatLng>`): List of vertices defining the first polygon.
- `polygon2` (List`<LatLng>`): List of vertices defining the second polygon.

Returns a list of `LatLng` points representing the intersection polygon.

### Vincenty formula for Geodesic Distance Calculation

```dart
 final double calculatedDistance = geodesy.vincentyDistance(
      point1.latitude, point1.longitude, point2.latitude, point2.longitude);
```

### Calculate Area of Polygon with Hole

```dart
final calculatedArea =
        geodesy.calculatePolygonWithHolesArea(outerPolygon, holes);
```

### Equirectangular approximation Calculation

```dart
  double equirectangularDistance = geodesy.equirectangularDistance(firstPoint, secondPoint);
```

### Spherical Law Of Cosines Distance

```dart
 double sLCDdistance = geodesy.sphericalLawOfCosinesDistance(bGPoint, pFPoint);
```

### Geodetic Point Manipulation - Rhumb Line Destination Formula

```dart
  LatLng destinationPoints = geodesy.calculateDestinationPoint(initialPoint, bearingDegrees, distanceKm);
```

### Geodetic Point Manipulation - Midpoint between two points

```dart
  LatLng midPointBetweenTwoPoints =
      geodesy.calculateMidpoint(bgPoint1, pFPoint2);
```

### Geodetic Point Manipulation - Calculate Point Along Great Circle

```dart
  List<LatLng> arcPoints =
      geodesy.calculatePointsAlongGreatCircle(startPoint, endPoint, numPoints);
```

---

This `Geodesy` class provides a comprehensive set of methods for performing various geodetic calculations and operations. You can use these methods to calculate distances, bearings, intersections, and more based on geographical coordinates.
