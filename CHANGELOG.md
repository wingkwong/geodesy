# Changelog

All notable changes to this project are documented in this file.

## 0.12.0

### Breaking changes

- Changed equirectangular and spherical law of cosines distances to return meters. Spherical law of cosines distances previously returned kilometers.
- Corrected equirectangular calculations to convert coordinates to radians.
- Changed polygon area calculations from planar degree-squared values to spherical square meters.
- Changed geodesic intersection calculations to operate on finite, shorter great-circle segments.
- Invalid or undefined geodesics now throw `ArgumentError`.

### Fixed

- Bounded Vincenty iteration and reported non-convergence for antipodal and nearly antipodal points instead of hanging.
- Handled coincident, equatorial, dateline, and polar Vincenty cases.
- Validated non-finite and out-of-range Vincenty coordinates.
- Clamped spherical law of cosines input to avoid floating-point domain errors.
- Wrapped distance calculations correctly across the antimeridian.
- Calculated polygon areas with short great-circle edges on a sphere with a radius of 6,371,000 meters.
- Made polygon-hole subtraction independent of ring winding.
- Returned the unique intersection of two finite great-circle segments, including shared endpoints; disjoint, coincident, and overlapping segments return `null`.
- Projected points onto infinite great circles using vector geometry.
- Rejected identical or antipodal geodesic endpoints and projections without a unique result.

### Tests

- Added regression coverage for distance units, radian conversion, Vincenty convergence, polygon areas and holes, geodesic intersections, and projections.

## 0.11.0

### Changed

- Raised the minimum Dart SDK version from 3.0.0 to 3.2.0.
- Updated `latlong2` to `^0.10.0`.
- Updated `lints` to `^6.0.0` and `test` to `^1.31.2`.
- Updated the package version and SDK constraints for current Dart tooling.

## 0.10.2

### Added

- Added numeric extension getters for conversions between metric units.
- Added conversions for inches, feet, yards, miles, and nautical miles.
- Added astronomical-unit, light-year, parsec, and submillimeter conversions.
- Added square-meter and square-kilometer conversions.

### Fixed

- Corrected polygon area multiplication in the shoelace formula.

## 0.10.1

### Documentation

- Added `example/README.md` with runnable usage guidance.
- Revised the main README and class and method reference documents.
- Corrected documentation wording, formatting, and examples.
- Moved the code of conduct to the repository root.

### Changed

- Removed unused imports and unnecessary example output.
- Applied minor source formatting cleanup.

## 0.10.0

### Added

- Added `calculatePolyLineLength` for measuring a path through multiple points.
- Added `calculatePolygonArea` for polygon area calculations.
- Added `calculateGeodesicLineIntersection` for geodesic intersections.
- Added `projectPointOntoGeodesicLine` for projecting a point onto a geodesic.
- Added initial-bearing support to the intersection and projection module.
- Added class and static examples for the expanded API.

### Changed

- Reorganized core implementations by distance, bounds, polygon,
  point-manipulation, and intersection responsibilities.
- Expanded the `Geodesy` facade to expose the new calculations.
- Updated documentation and tests for the reorganized API.

## 0.9.0

### Added

- Added distance calculations using the equirectangular approximation.
- Added distance calculations using the spherical law of cosines.
- Added `calculateDestinationPoint` for distance-and-bearing offsets.
- Added midpoint calculation between two geographic points.
- Added generation of points along a great-circle path.
- Added class and static API coverage for the new calculations.

### Changed

- Grouped distance calculations under dedicated source modules.
- Expanded examples, API documentation, and tests.

## 0.8.0

### Added

- Added WGS-84 geodesic distance calculations using Vincenty's inverse formula.
- Added polygon-with-holes area calculations.
- Added a `toRadians` numeric extension used by geodesic calculations.
- Added class and static entry points for the new calculations.
- Added examples and tests for Vincenty distance and polygon holes.
- Added a code of conduct.

### Changed

- Updated the license text and supporting documentation.
- Revised destination-point calculations and formatting.

## 0.7.0

### Changed

- Split the monolithic implementation into focused core classes for bearings,
  bounds, distances, destinations, polygons, ranges, and tracks.
- Kept the `Geodesy` class as a facade over the new core modules.
- Added direct static method access alongside instance-based calls.
- Reorganized public exports through the core library barrel.

### Documentation

- Added separate class-based and static-method API guides.
- Added examples for both calling styles.
- Reworked the README around the refactored API.

## 0.6.0

### Added

- Added `findPolygonCentroid` using the polygon's signed area and vertices.
- Added `getPolygonIntersection` to collect intersections between polygon
  edges.
- Added internal segment-intersection and point-on-segment helpers.
- Added examples, README guidance, and tests for both polygon operations.

## 0.5.0

### Added

- Added `greatCircleDistanceBetweenTwoGeoPoints` using the haversine formula.
- Added `getRectangleBounds` for finding a polygon's rectangular extent.
- Added `calculateBoundingBox` around a center point and distance.
- Added examples and tests for distance and bounding-box calculations.

### Changed

- Simplified bounding-box implementation details.
- Expanded the README with the new APIs and example output.

## 0.4.2

### Fixed

- Improved numeric handling across destination, midpoint, bearing, distance,
  intersection, and bounding-box calculations.
- Reduced repeated trigonometric work by reusing intermediate values.
- Updated tests for revised numeric results and types.

### Documentation

- Revised README descriptions and examples for the calculation APIs.

## 0.4.1

### Fixed

- Renamed the misspelled `isGeoPointInBoudingBox` API to
  `isGeoPointInBoundingBox`.
- Corrected bounding-box containment comparisons for latitude and longitude.
- Updated tests, examples, and README references to the corrected method.

## 0.4.0

### Changed

- Completed the stable null-safety migration.
- Added Dart 3 compatibility and raised the minimum SDK version to 3.0.0.
- Migrated the coordinate dependency to `latlong2`.
- Removed deprecated fields left from the pre-null-safety API.
- Used const `LatLng` values where possible.
- Revised the test suite for the updated SDK and dependency APIs.

## 0.4.0-nullsafety.0

### Changed

- Migrated library source, examples, and tests to sound null safety.
- Added nullable return types where calculations may not produce a point.
- Published a prerelease for consumers testing null-safe Dart applications.

## 0.3.2

### Added

- Added the first automated test suite for core geodesy calculations.
- Added `pointsInRange` for filtering points within a given distance.
- Added test coverage and README documentation for range filtering.
- Added test and coverage configuration to the package.

## 0.3.1

### Changed

- Made Earth-radius parameters optional where a default radius is available.
- Enabled stricter static analysis with an analysis options file.
- Added the `pedantic` lint dependency.
- Added explicit return types and numeric casts required by stricter analysis.
- Updated examples for the optional-radius API.

## 0.3.0

### Changed

- Replaced the package's own coordinate implementation with `LatLng` from the
  `latlong` package.
- Updated every public calculation to accept the dependency's `LatLng` type.
- Updated examples and package exports for the new coordinate type.

### Deprecated

- Deprecated the package-local `LatLng` implementation.
- Deprecated `degreesToRadians` and `radiansToDegrees` in favor of dependency
  utilities.

## 0.2.0

### Added

- Added `intersectionByPaths` for finding the intersection of two paths from
  their start points and bearings.
- Added `crossTrackDistanceTo` for measuring distance from a point to a path.
- Added `isGeoPointInPolygon` using ray casting.
- Exported and documented all three calculations.

## 0.1.1

### Added

- Added a runnable package example.
- Added package metadata and SDK constraints needed for publication.

### Changed

- Applied Dart formatting across the package.
- Expanded API comments and README usage information.

## 0.1.0

### Added

- Published the initial package release.
- Added the package-local `LatLng` coordinate type.
- Added point-to-point distance calculations.
- Added destination-point calculations from distance and bearing.
- Added initial and final bearing calculations.
- Added midpoint calculations.
- Added bounding-box containment checks.
