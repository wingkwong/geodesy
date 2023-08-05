import 'core.dart';

/// Check if a given geo point is in the bounding box
bool iGeoPointInBoundingBox(LatLng l, LatLng topLeft, LatLng bottomRight) {
  return (bottomRight.latitude <= l.latitude &&
          l.latitude <= topLeft.latitude) &&
      (topLeft.longitude <= l.longitude &&
          l.longitude <= bottomRight.longitude);
}
