# Static Methods

The `Geodesy` Static Methods provides a collection of methods for performing various geodetic calculations, including distance calculations, point intersections, and more. This  designed to work with geographical coordinates in the form of latitude and longitude.

Call any Static Methods which is given below without using geodesy Instance.

## Methods

### Destination Point By Distance And Bearing

Calculate a destination point given an initial point, a distance, a bearing, and an optional radius.

```dart
DistanceAndBearing.destinationPointByDistanceAndBearing(l, distance, bearing, radius);
```

Returns a `LatLng` object representing the calculated destination point.

### Mid Point Between Two GeoPoints

Calculate the geographical midpoint between two points.

```dart
GeoPoints.midPointBetweenTwoGeoPoints(l1, l2);
```

- `l1` (LatLng): The first geographical point (latitude, longitude).
- `l2` (LatLng): The second geographical point (latitude, longitude).

Returns a `LatLng` object representing the midpoint between the two input points.

### Intersection By Paths

Calculate the intersection point of two paths defined by points and bearings.

```dart
GeoPoints.intersectionOfTwoGeoPointsByPaths(l1, l2, b1, b2);
```

- `l1` (LatLng): The first geographical point (latitude, longitude).
- `l2` (LatLng): The second geographical point (latitude, longitude).
- `b1` (num): The bearing angle for the first path in degrees.
- `b2` (num): The bearing angle for the second path in degrees.

Returns a `LatLng` object representing the intersection point or `null` if no intersection is found.

### Distance Between Two GeoPoints

Calculate the distance in meters between two geographical points.

```dart
GeoPoints.distanceBetweenTwoGeoPoints(l1, l2, radius);
```

- `l1` (LatLng): The first geographical point (latitude, longitude).
- `l2` (LatLng): The second geographical point (latitude, longitude).
- `radius` (num, optional): The Earth's radius (default is `null`).

Returns the distance in meters between the two input points.

### Bearing Between Two GeoPoints

Calculate the bearing angle from one point to another.

```dart
BearingBetweenTwoGeoPoints.bearingBetweenTwoGeoPoints(l1, l2);
```

- `l1` (LatLng): The starting geographical point (latitude, longitude).
- `l2` (LatLng): The target geographical point (latitude, longitude).

Returns the bearing angle in degrees from the starting point to the target point.

### Final BearingBetween Two GeoPoints

Calculate the final bearing angle from one point to another.

```dart
BearingBetweenTwoGeoPoints.finalBearingBetweenTwoGeoPoints(l1, l2);
```

- `l1` (LatLng): The starting geographical point (latitude, longitude).
- `l2` (LatLng): The target geographical point (latitude, longitude).

Returns the final bearing angle in degrees from the starting point to the target point.

### Cross Track Distance To

Calculate the signed distance from a point to a line defined by two other points.

```dart
TrackDistance.crossTrackDistanceTo(l1, start, end, radius);
```

- `l1` (LatLng): The point to calculate the distance from (latitude, longitude).
- `start` (LatLng): The starting point of the line (latitude, longitude).
- `end` (LatLng): The ending point of the line (latitude, longitude).
- `radius` (num, optional): The Earth's radius (default is `null`).

Returns the signed cross-track distance in meters.

### Is GeoPoint In BoundingBox

Check if a given point is within a bounding box defined by two corner points.

```dart
BoundingBox.isGeoPointInBoundingBox(l, topLeft, bottomRight);
```

- `l` (LatLng): The point to check (latitude, longitude).
- `topLeft` (LatLng): The top-left corner of the bounding box (latitude, longitude).
- `bottomRight` (LatLng): The bottom-right corner of the bounding box (latitude, longitude).

Returns `true` if the point is within the bounding box, otherwise `false`.

### IsGeo Point In Polygon

Check if a given point is within a polygon using the even-odd rule algorithm.

```dart
GeoPoints.isGeoPointInPolygon(l, polygon);
```

- `l` (LatLng): The point to check (latitude, longitude).
- `polygon` (List`<LatLng>`): A list of vertices defining the polygon.

Returns `true` if the point is within the polygon, otherwise `false`.

### Points In Range

Get a list of points within a certain distance from a given point.

```dart
PointRange.pointInRange(point, pointsToCheck, distance);
```

- `point` (LatLng): The center point (latitude, longitude).
- `pointsToCheck` (List`<LatLng>`): List of points to check against.
- `distance` (num): The maximum distance in meters.

Returns a list of `LatLng` points within the specified distance from the center point.

### Great Circle Distance Between Two GeoPoints

Calculate the great-circle distance between two points using the Haversine formula.

```dart
GeoPoints.greatCircleDistanceBetweenTwoGeoPoints(lat1, lon1, lat2, lon2);
```

- `lat1` (num): Latitude of the first point.
- `lon1` (num): Longitude of the first point.
- `lat2` (num): Latitude of the second point.
- `lon2` (num): Longitude of the second point.

Returns the great-circle distance in meters.

### Get Rectangle Bounds

Get the bounding rectangle for a polygon defined by its vertices.

```dart
RectangleBounds.getRectangleBounds(polygonCoords);
```

- `polygonCoords` (List`<LatLng>`): List of vertices defining the polygon.

Returns a list of `LatLng` points representing the bounding rectangle's corners.

### Calculate BoundingBox

Calculate the bounding box around a point with a given distance.

```dart
BoundingBox.calculateBoundingBox(centerPoint, distanceInKm);
```

- `centerPoint` (LatLng): The center point (latitude, longitude).
- `distanceInKm` (num): The distance in kilometers.

Returns a list of `LatLng` points representing the bounding box's corners.

### Find Polygon Centroid

Find the centroid of a polygon defined by its vertices.

```dart
PolygonCentroid.findPolygonCentroid(polygons);
```

- `polygon` (List`<LatLng>`): List of vertices defining the polygon.

Returns a `LatLng` object representing the centroid of the polygon.

### Get Polygon Intersection

Calculate the intersection of

 two polygons defined by their vertices.

```dart
PolygonIntersection.getPolygonIntersection(polygon1, polygon2);
```

- `polygon1` (List`<LatLng>`): List of vertices defining the first polygon.
- `polygon2` (List`<LatLng>`): List of vertices defining the second polygon.

Returns a list of `LatLng` points representing the intersection polygon.

### Vincenty formula for Geodesic Distance Calculation

```dart
VincentyDistance.vincentyDistance(lat1, lon1, lat2, lon2);
```

### Calculate Area of Polygon with Hole

```dart
final area = Polygon.calculatePolygonWithHolesArea(outerPolygon, holes);
```

### Equirectangular approximation Calculation

```dart
  double equirectangularDistance = 
  EquirectangularApproximation.equirectangularDistance(firstPoint,secondPoint);
```

### Spherical Law Of Cosines Distance

```dart
double sLCDdistance =
      SphericalLawOfCosines.sphericalLawOfCosinesDistance(bGPoint, pFPoint);
```

---

This `Geodesy` provides a comprehensive set of methods for performing various geodetic calculations and operations. You can use these methods to calculate distances, bearings, intersections, and more based on geographical coordinates.
