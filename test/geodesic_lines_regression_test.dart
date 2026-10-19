import 'package:geodesy/geodesy.dart';
import 'package:test/test.dart';

void _expectPoint(LatLng? actual, double latitude, double longitude,
    [double tolerance = 1e-10]) {
  expect(actual, isNotNull);
  expect(actual!.latitude, closeTo(latitude, tolerance));
  expect(actual.longitude, closeTo(longitude, tolerance));
}

void main() {
  final geodesy = Geodesy();

  for (final useWrapper in [false, true]) {
    group(useWrapper ? 'Geodesy geodesic APIs' : 'Static geodesic APIs', () {
      final intersect = useWrapper
          ? geodesy.calculateGeodesicLineIntersection
          : GeodesicLines.calculateGeodesicLineIntersection;
      final project = useWrapper
          ? geodesy.projectPointOntoGeodesicLine
          : GeodesicLines.projectPointOntoGeodesicLine;

      group('intersection', () {
        test('finds an equator and meridian segment crossing', () {
          _expectPoint(
              intersect(
                const LatLng(0, -1),
                const LatLng(0, 1),
                const LatLng(-1, 0),
                const LatLng(1, 0),
              ),
              0,
              0);
        });

        test('is independent of segment direction and argument order', () {
          const west = LatLng(0, -1);
          const east = LatLng(0, 1);
          const south = LatLng(-1, 0);
          const north = LatLng(1, 0);
          for (final result in [
            intersect(east, west, south, north),
            intersect(west, east, north, south),
            intersect(south, north, west, east),
          ]) {
            _expectPoint(result, 0, 0);
          }
        });

        test('finds a crossing at the antimeridian', () {
          _expectPoint(
              intersect(
                const LatLng(0, 179),
                const LatLng(0, -179),
                const LatLng(-1, 180),
                const LatLng(1, 180),
              ),
              0,
              -180);
        });

        test('returns a shared endpoint', () {
          _expectPoint(
              intersect(
                const LatLng(10, 10),
                const LatLng(20, 20),
                const LatLng(20, 20),
                const LatLng(20, 30),
              ),
              20,
              20);
        });

        test('returns null when only the infinite great circles intersect', () {
          expect(
              intersect(
                const LatLng(0, 0),
                const LatLng(1, 0),
                const LatLng(0, 1),
                const LatLng(1, 1),
              ),
              isNull);
        });

        test('returns null for coincident or overlapping segments', () {
          expect(
              intersect(
                const LatLng(0, -2),
                const LatLng(0, 2),
                const LatLng(0, -1),
                const LatLng(0, 1),
              ),
              isNull);
        });

        test('rejects invalid and ambiguous segments', () {
          expect(
              () => intersect(
                    const LatLng(double.nan, 0),
                    const LatLng(0, 1),
                    const LatLng(-1, 0),
                    const LatLng(1, 0),
                  ),
              throwsArgumentError);
          expect(
              () => intersect(
                    const LatLng(0, 0),
                    const LatLng(0, 0),
                    const LatLng(-1, 0),
                    const LatLng(1, 0),
                  ),
              throwsArgumentError);
          expect(
              () => intersect(
                    const LatLng(0, 0),
                    const LatLng(0, 180),
                    const LatLng(-1, 0),
                    const LatLng(1, 0),
                  ),
              throwsArgumentError);
        });
      });

      group('projection', () {
        test('preserves a point already on the great circle', () {
          _expectPoint(
              project(
                const LatLng(0, 1),
                const LatLng(0, 0),
                const LatLng(0, 2),
              ),
              0,
              1);
        });

        test('projects onto the equator at the same longitude', () {
          _expectPoint(
              project(
                const LatLng(5, 3),
                const LatLng(0, -10),
                const LatLng(0, 10),
              ),
              0,
              3);
        });

        test('projects onto the infinite great circle beyond the endpoints',
            () {
          _expectPoint(
              project(
                const LatLng(5, 30),
                const LatLng(0, -10),
                const LatLng(0, 10),
              ),
              0,
              30);
        });

        test('matches an independent Cartesian-vector reference', () {
          _expectPoint(
              project(
                const LatLng(42.350, -71.103),
                const LatLng(42.345, -71.098),
                const LatLng(42.355, -71.108),
              ),
              42.35000017886313,
              -71.10299967252298,
              1e-9);
        });

        test('is independent of endpoint direction', () {
          final forward = project(
            const LatLng(42.350, -71.103),
            const LatLng(42.345, -71.098),
            const LatLng(42.355, -71.108),
          );
          final reverse = project(
            const LatLng(42.350, -71.103),
            const LatLng(42.355, -71.108),
            const LatLng(42.345, -71.098),
          );
          _expectPoint(reverse, forward.latitude, forward.longitude);
        });

        test('normalizes a projection at the antimeridian', () {
          _expectPoint(
              project(
                const LatLng(5, 180),
                const LatLng(0, 179),
                const LatLng(0, -179),
              ),
              0,
              -180);
        });

        test('rejects invalid, undefined, and ambiguous projections', () {
          expect(
              () => project(
                    const LatLng(0, double.infinity),
                    const LatLng(0, -1),
                    const LatLng(0, 1),
                  ),
              throwsArgumentError);
          expect(
              () => project(
                    const LatLng(1, 1),
                    const LatLng(0, 0),
                    const LatLng(0, 0),
                  ),
              throwsArgumentError);
          expect(
              () => project(
                    const LatLng(1, 1),
                    const LatLng(0, 0),
                    const LatLng(0, 180),
                  ),
              throwsArgumentError);
          expect(
              () => project(
                    const LatLng(90, 0),
                    const LatLng(0, -10),
                    const LatLng(0, 10),
                  ),
              throwsArgumentError);
        });
      });
    });
  }
}
