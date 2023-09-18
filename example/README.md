# Example

## Geodesy Class

Check out full examples [here](./class_example.dart).

```dart
import 'package:geodesy/geodesy.dart';

void main() {
  final Geodesy geodesy = Geodesy();
  List<LatLng> polygon = [
    const LatLng(0, 0),
    const LatLng(4, 0),
    const LatLng(4, 4),
    const LatLng(0, 4)
  ];
  LatLng centroid = geodesy.findPolygonCentroid(polygon);
  // Centroid: 2.0, 2.0
  print("Centroid: ${centroid.latitude}, ${centroid.longitude}");
}
```

## Static Methods

Check out full examples [here](./static_example.dart).

```dart
import 'package:geodesy/geodesy.dart';

void main() {
  List<LatLng> polygon = [
    const LatLng(0, 0),
    const LatLng(4, 0),
    const LatLng(4, 4),
    const LatLng(0, 4)
  ];
  final LatLng centroid = PolygonCentroid.findPolygonCentroid(polygon);
  // Centroid: 2.0, 2.0
  print("Centroid: ${centroid.latitude}, ${centroid.longitude}");
}
```