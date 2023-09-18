import 'package:geodesy/geodesy.dart';

/// Geodesy class that acts as a wrapper for various geodetic calculations. This class provides a
/// wide range of geo-spatial functionalities, from calculating distances and bearings to working
/// with polygons, points, and lines. This can be a valuable utility for geo-spatial applications
class Geodesy {
  /// Calculate a destination point given the starting point, distance, bearing, and optional radius.
  ///
  /// Given a starting point [l], a distance in meters [distance], a bearing in degrees [bearing], and an optional radius in meters [radius], this function calculates the destination point on the Earth's surface.
  /// The [radius] parameter allows you to specify a different radius than the Earth's default radius of approximately 6,371,000 meters.
  /// Returns a [LatLng] object representing the destination point.
  LatLng destinationPointByDistanceAndBearing(
      LatLng l, num distance, num bearing,
      [num? radius]) {
    return DistanceAndBearing.destinationPointByDistanceAndBearing(
        l, distance, bearing, radius);
  }

  /// Calculate the midpoint between two geographic points.
  ///
  /// Given two geographic points [l1] and [l2], this function calculates and returns the midpoint between these two points.
  LatLng midPointBetweenTwoGeoPoints(LatLng l1, LatLng l2) {
    return GeoPoints.midPointBetweenTwoGeoPoints(l1, l2);
  }

  /// Calculate the geographic point of intersection of two paths.
  ///
  /// Given two geographic points [l1] and [l2], and two bearings [b1] and [b2], this function calculates and returns the point of intersection between the paths defined by these points and bearings.
  /// Returns a [LatLng] object representing the intersection point or `null` if no intersection is found.
  LatLng? intersectionByPaths(LatLng l1, LatLng l2, num b1, num b2) {
    return GeoPoints.intersectionOfTwoGeoPointsByPaths(l1, l2, b1, b2);
  }

  /// Calculate the distance in meters between two geographic points.
  ///
  /// Given two geographic points [l1] and [l2], and an optional radius in meters [radius], this function calculates and returns the distance between these two points on the Earth's surface.
  /// The [radius] parameter allows you to specify a different radius than the Earth's default radius of approximately 6,371,000 meters.
  num distanceBetweenTwoGeoPoints(LatLng l1, LatLng l2, [num? radius]) {
    return GeoPoints.distanceBetweenTwoGeoPoints(l1, l2, radius);
  }

  /// Calculate the initial bearing from point [l1] to point [l2].
  ///
  /// Given two geographic points [l1] and [l2], this function calculates and returns the initial bearing from point [l1] to point [l2] in degrees.
  num bearingBetweenTwoGeoPoints(LatLng l1, LatLng l2) {
    return BearingBetweenTwoGeoPoints.bearingBetweenTwoGeoPoints(l1, l2);
  }

  /// Calculate the final bearing from point [l1] to point [l2].
  ///
  /// Given two geographic points [l1] and [l2], this function calculates and returns the final bearing from point [l1] to point [l2] in degrees.
  num finalBearingBetweenTwoGeoPoints(LatLng l1, LatLng l2) {
    return BearingBetweenTwoGeoPoints.finalBearingBetweenTwoGeoPoints(l1, l2);
  }

  /// Calculate the signed distance from a geographic point [l1] to create a circle with start [start] and end [end] points.
  ///
  /// Given a geographic point [l1], and start [start] and end [end] points, this function calculates and returns the signed distance in meters from point [l1] to create a circle with the specified start and end points.
  num crossTrackDistanceTo(LatLng l1, LatLng start, LatLng end, [num? radius]) {
    return TrackDistance.crossTrackDistanceTo(l1, start, end);
  }

  /// Check if a given geographic point [l] is within a bounding box defined by the top-left and bottom-right corners.
  ///
  /// Given a geographic point [l] and the top-left [topLeft] and bottom-right [bottomRight] corners of a bounding box, this function checks if the point is within the specified bounding box.
  bool isGeoPointInBoundingBox(LatLng l, LatLng topLeft, LatLng bottomRight) {
    return BoundingBox.isGeoPointInBoundingBox(l, topLeft, bottomRight);
  }

  /// Check if a given geographic point [l] is within a polygon defined by a list of [polygon] points using the even-odd rule algorithm.
  ///
  /// Given a geographic point [l] and a list of [polygon] points representing a polygon, this function checks if the point is inside the specified polygon using the even-odd rule algorithm.
  bool isGeoPointInPolygon(LatLng l, List<LatLng> polygon) {
    return GeoPoints.isGeoPointInPolygon(l, polygon);
  }

  /// Get a list of [LatLng] points within a specified distance from a given point.
  ///
  /// Given a geographic point [point], a list of [pointsToCheck], and a distance in meters [distance], this function returns a list of [LatLng] points from [pointsToCheck] that are within the specified distance from the given point.
  List<LatLng> pointsInRange(
      LatLng point, List<LatLng> pointsToCheck, num distance) {
    return PointRange.pointInRange(point, pointsToCheck, distance);
  }

  /// Calculate the great-circle distance between two geographic points using the Haversine formula.
  ///
  /// Given the latitude and longitude of two points [lat1], [lon1], [lat2], and [lon2], this function calculates and returns the great-circle distance between these two points in meters using the Haversine formula.
  num greatCircleDistanceBetweenTwoGeoPoints(
      num lat1, num lon1, num lat2, num lon2) {
    return GeoPoints.greatCircleDistanceBetweenTwoGeoPoints(
        lat1, lon1, lat2, lon2);
  }

  /// Calculate the bounds of a rectangle that encloses a polygon defined by a list of [polygonCoords] points.
  ///
  /// Given a list of [polygonCoords] representing the vertices of a polygon, this function calculates and returns the bounds of the smallest rectangle that encloses the polygon as a list of two [LatLng] points: the top-left and bottom-right corners of the rectangle.
  List<LatLng> getRectangleBounds(List<LatLng> polygonCoords) {
    return RectangleBounds.getRectangleBounds(polygonCoords);
  }

  /// Calculate a bounding box around a center point with a specified distance in kilometers.
  ///
  /// Given a center point [centerPoint] and a distance in kilometers [distanceInKm], this function calculates and returns the bounding box around the center point.
  List<LatLng> calculateBoundingBox(LatLng centerPoint, num distanceInKm) {
    return BoundingBox.calculateBoundingBox(centerPoint, distanceInKm);
  }

  /// Find the centroid of a polygon defined by a list of [polygons] points.
  ///
  /// Given a list of [polygons] points representing the vertices of a polygon, this function calculates and returns the centroid of the polygon as a [LatLng] object.
  LatLng findPolygonCentroid(List<LatLng> polygons) {
    return PolygonCentroid.findPolygonCentroid(polygons);
  }

  /// Calculate the intersection points of two polygons represented by lists of [polygon1] and [polygon2] points.
  ///
  /// Given two lists of [polygon1] and [polygon2] points representing the vertices of two polygons, this function calculates and returns a list of [LatLng] intersection points between the two polygons.
  List<LatLng> getPolygonIntersection(
      List<LatLng> polygon1, List<LatLng> polygon2) {
    return PolygonIntersection.getPolygonIntersection(polygon1, polygon2);
  }

  /// Calculate the Vincenty formula for geodesic distance calculation between two geographic points.
  ///
  /// Given the latitude and longitude of two points [lat1], [lon1], [lat2], and [lon2], this function calculates and returns the geodesic distance between these two points using the Vincenty formula.
  double vincentyDistance(double lat1, double lon1, double lat2, double lon2) {
    return VincentyDistance.vincentyDistance(lat1, lon1, lat2, lon2);
  }

  /// Calculate the area of a polygon with holes.
  ///
  /// Given an outer polygon defined by a list of [outerPolygon] points and a list of [holes] (each hole represented as a list of LatLng points), this function calculates and returns the area of the polygon with holes.
  double calculatePolygonWithHolesArea(
      List<LatLng> outerPolygon, List<List<LatLng>> holes) {
    return PolygonHole.calculatePolygonWithHolesArea(outerPolygon, holes);
  }

  /// Calculate a destination point given an initial point, bearing in degrees, and distance in kilometers.
  ///
  /// Given an initial point [initialPoint], a bearing in degrees [bearingDegrees], and a distance in kilometers [distanceKm], this function calculates and returns the destination point on the Earth's surface.
  LatLng calculateDestinationPoint(
      LatLng initialPoint, double bearingDegrees, double distanceKm) {
    return DestinationPoint.calculateDestinationPoint(
        initialPoint, bearingDegrees, distanceKm);
  }

  /// Calculate a list of points along a great circle arc connecting two points.
  ///
  /// Given two points [startPoint] and [endPoint] and the number of intermediate points to calculate [numPoints], this function calculates and returns a list of [LatLng] points along the great circle arc connecting the two input points. The intermediate points are equally spaced along the arc.
  List<LatLng> calculatePointsAlongGreatCircle(
      LatLng startPoint, LatLng endPoint, int numPoints) {
    return GreatCirclePoint.calculatePointsAlongGreatCircle(
        startPoint, endPoint, numPoints);
  }

  /// Calculate the midpoint between two geographic points.
  ///
  /// Given two geographic points [point1] and [point2], this function calculates and returns the midpoint between these two points as a [LatLng] object.
  LatLng calculateMidpoint(LatLng point1, LatLng point2) {
    return MidPointBetweenTwoPoints.calculateMidpoint(point1, point2);
  }

  /// Calculate the equirectangular approximation distance between two geographic points.
  ///
  /// Given two geographic points [point1] and [point2], this function calculates and returns the equirectangular approximation distance between these two points in meters.
  double equirectangularDistance(LatLng point1, LatLng point2) {
    return EquirectangularApproximation.equirectangularDistance(point1, point2);
  }

  /// Calculate the Spherical Law of Cosines distance between two geographic points.
  ///
  /// Given two geographic points [point1] and [point2], this function calculates and returns the Spherical Law of Cosines distance between these two points in meters.
  double sphericalLawOfCosinesDistance(LatLng point1, LatLng point2) {
    return SphericalLawOfCosines.sphericalLawOfCosinesDistance(point1, point2);
  }

  /// Calculate the length of a polyline formed by connecting multiple points.
  ///
  /// Given a list of [polyLinePoints] representing the vertices of a polyline, this function calculates and returns the length of the polyline in meters.
  double calculatePolyLineLength(List<LatLng> polyLinePoints) {
    return PolyLine.calculatePolyLineLength(polyLinePoints);
  }

  /// Calculate the area of a polygon defined by a list of [polygonPoints] points.
  ///
  /// Given a list of [polygonPoints] representing the vertices of a polygon, this function calculates and returns the area of the polygon.
  double calculatePolygonArea(List<LatLng> polygonPoints) {
    return PolygonArea.calculatePolygonArea(polygonPoints);
  }

  /// Calculate the intersection points of two geodesic lines defined by start and end points.
  ///
  /// Given four geographic points [start1], [end1], [start2], and [end2] representing the start and end points of two geodesic lines, this function calculates and returns the intersection point of these two lines as a [LatLng] object. If no intersection is found, it returns `null`.
  LatLng? calculateGeodesicLineIntersection(
      LatLng start1, LatLng end1, LatLng start2, LatLng end2) {
    return GeodesicLines.calculateGeodesicLineIntersection(
        start1, end1, start2, end2);
  }

  /// Project a point onto a geodesic line.
  ///
  /// Given a geographic point [point], and start [start] and end [end] points defining a geodesic line, this function calculates and returns the projection (closest point) of the given point onto the geodesic line as a [LatLng] object.
  LatLng projectPointOntoGeodesicLine(LatLng point, LatLng start, LatLng end) {
    return GeodesicLines.projectPointOntoGeodesicLine(point, start, end);
  }
}
