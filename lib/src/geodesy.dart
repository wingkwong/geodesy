import 'package:geodesy/geodesy.dart';
import 'package:geodesy/src/core/GeodeticPointManipulation/calculate_destination_point.dart';
import 'package:geodesy/src/core/GeodeticPointManipulation/calculate_points_along_great_circle.dart';
import 'package:geodesy/src/core/GeodeticPointManipulation/mid_point_between_two_points.dart';
import 'package:geodesy/src/core/polygon_with_hole.dart';

/// The main Geodesy Class
class Geodesy {
  /// Calculate a destination point given the distance and bearing
  LatLng destinationPointByDistanceAndBearing(
      LatLng l, num distance, num bearing,
      [num? radius]) {
    return DistanceAndBearing.destinationPointByDistanceAndBearing(
        l, distance, bearing, radius);
  }

  /// Calculate the midpoint between teo geo points
  LatLng midPointBetweenTwoGeoPoints(LatLng l1, LatLng l2) {
    return GeoPoints.midPointBetweenTwoGeoPoints(l1, l2);
  }

  /// Calculate the geo point of intersection of two given paths
  LatLng? intersectionByPaths(LatLng l1, LatLng l2, num b1, num b2) {
    return GeoPoints.intersectionOfTwoGeoPointsByPaths(l1, l2, b1, b2);
  }

  /// calculate the distance in meters between two geo points
  num distanceBetweenTwoGeoPoints(LatLng l1, LatLng l2, [num? radius]) {
    return GeoPoints.distanceBetweenTwoGeoPoints(l1, l2, radius);
  }

  /// calculate the bearing from point l1 to point l2
  num bearingBetweenTwoGeoPoints(LatLng l1, LatLng l2) {
    return BearingBetweenTwoGeoPoints.bearingBetweenTwoGeoPoints(l1, l2);
  }

  /// calculate the final bearing from point l1 to point l2
  num finalBearingBetweenTwoGeoPoints(LatLng l1, LatLng l2) {
    return BearingBetweenTwoGeoPoints.finalBearingBetweenTwoGeoPoints(l1, l2);
  }

  /// calculate signed distance from a geo point
  /// to create circle with start and end points
  num crossTrackDistanceTo(LatLng l1, LatLng start, LatLng end, [num? radius]) {
    return TrackDistance.crossTrackDistanceTo(l1, start, end);
  }

  /// check if a given geo point is in the bounding box
  bool isGeoPointInBoundingBox(LatLng l, LatLng topLeft, LatLng bottomRight) {
    return BoundingBox.isGeoPointInBoundingBox(l, topLeft, bottomRight);
  }

  /// check if a given geo point is in the a polygon
  /// using even-odd rule algorithm
  bool isGeoPointInPolygon(LatLng l, List<LatLng> polygon) {
    return GeoPoints.isGeoPointInPolygon(l, polygon);
  }

  /// Get a list of [LatLng] points within a distance from
  /// a given point
  /// Distance is in meters
  List<LatLng> pointsInRange(
      LatLng point, List<LatLng> pointsToCheck, num distance) {
    return PointRange.pointInRange(point, pointsToCheck, distance);
  }

  /// great-circle distance between two points using the Haversine formula
  num greatCircleDistanceBetweenTwoGeoPoints(
      num lat1, num lon1, num lat2, num lon2) {
    return GeoPoints.greatCircleDistanceBetweenTwoGeoPoints(
        lat1, lon1, lat2, lon2);
  }

  /// GetRectangleBounds
  List<LatLng> getRectangleBounds(List<LatLng> polygonCoords) {
    return RectangleBounds.getRectangleBounds(polygonCoords);
  }

  /// Bounding Box per distance in Kilometers
  List<LatLng> calculateBoundingBox(LatLng centerPoint, num distanceInKm) {
    return BoundingBox.calculateBoundingBox(centerPoint, distanceInKm);
  }

  /// finds the centroid of polygons
  LatLng findPolygonCentroid(List<LatLng> polygons) {
    return PolygonCentroid.findPolygonCentroid(polygons);
  }

  /// Get Polygon Intersection
  List<LatLng> getPolygonIntersection(
      List<LatLng> polygon1, List<LatLng> polygon2) {
    return PolygonIntersection.getPolygonIntersection(polygon1, polygon2);
  }

  /// Vincenty formula for Geodesic Distance Calculation
  double vincentyDistance(double lat1, double lon1, double lat2, double lon2) {
    return VincentyDistance.vincentyDistance(lat1, lon1, lat2, lon2);
  }

  /// Calculate the Area inside polygon Hole
  double calculatePolygonWithHolesArea(
      List<LatLng> outerPolygon, List<List<LatLng>> holes) {
    return Polygon.calculatePolygonWithHolesArea(outerPolygon, holes);
  }

  /// Geodetic Point Manipulation - Rhumb Line Destination Formula
  LatLng calculateDestinationPoint(
      LatLng initialPoint, double bearingDegrees, double distanceKm) {
    return DestinationPoint.calculateDestinationPoint(
        initialPoint, bearingDegrees, distanceKm);
  }

  /// Geodetic Point Manipulation - Calculate Point Along Great Circle
  List<LatLng> calculatePointsAlongGreatCircle(
      LatLng startPoint, LatLng endPoint, int numPoints) {
    return GreatCirclePoint.calculatePointsAlongGreatCircle(
        startPoint, endPoint, numPoints);
  }

  /// Geodetic Point Manipulation - Midpoint between two points
  LatLng calculateMidpoint(LatLng point1, LatLng point2) {
    return MidPointBetweenTwoPoints.calculateMidpoint(point1, point2);
  }

  /// Equirectangular approximation Calculation
  double equirectangularDistance(LatLng point1, LatLng point2) {
    return EquirectangularApproximation.equirectangularDistance(point1, point2);
  }

  /// Calculate Spherical Law Of Cosines Distance
  double sphericalLawOfCosinesDistance(LatLng point1, LatLng point2) {
    return SphericalLawOfCosines.sphericalLawOfCosinesDistance(point1, point2);
  }
}
