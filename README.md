# Geodesy

[![pub package](https://img.shields.io/pub/v/geodesy.svg)](https://pub.dartlang.org/packages/geodesy)

## About

A Dart library for implementing geodesic and trigonometric calculations based on a spherical Earth model for working with points and paths such as distances, bearings and destinations.

## How to Use Geodesy

### Commands

#### For Dart

```dart
dart pub add geodesy
```

#### For Flutter

```dart
flutter pub add geodesy
```

### Import the library in your dart file

```dart
import 'package:geodesy/geodesy.dart';
```

### Initialization

```dart
final Geodesy geodesy = Geodesy();
```

## Class

The Geodesy class provides a collection of methods for performing various geodetic calculations, including distance calculations, point intersections, and more. This class is designed to work with geographical coordinates in the form of latitude and longitude.

Please see the details [here](doc/CLASS.md).

### Example

Please check out [here](example/class_example.dart).

## Static Methods

Static methods are available without using Geodesy instance.

Please see the details  [here](doc/METHODS.md).
### Example

Please check out [here](example/static_example.dart).
## Code of Conduct

See [here](doc/CODE_OF_CONDUCT.md).

## License

See [here](./LICENSE).
