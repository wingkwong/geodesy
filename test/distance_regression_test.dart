import 'dart:isolate';

import 'package:geodesy/geodesy.dart';
import 'package:test/test.dart';

// A separate isolate lets the test stop an accidentally unbounded iteration.
Future<Object?> _vincentyOutcome(
    List<double> coordinates, bool useWrapper) async {
  final port = ReceivePort();
  final isolate = await Isolate.spawn((SendPort result) {
    try {
      final distance = useWrapper
          ? Geodesy().vincentyDistance
          : VincentyDistance.vincentyDistance;
      result.send(distance(
          coordinates[0], coordinates[1], coordinates[2], coordinates[3]));
    } on StateError {
      result.send('non-convergent');
    } catch (error) {
      result.send(error.toString());
    }
  }, port.sendPort);
  try {
    return await port.first.timeout(const Duration(seconds: 2));
  } finally {
    isolate.kill(priority: Isolate.immediate);
    port.close();
  }
}

void main() {
  final geodesy = Geodesy();
  for (final useWrapper in [false, true]) {
    group(useWrapper ? 'Geodesy wrapper' : 'Static API', () {
      final vincenty = useWrapper
          ? geodesy.vincentyDistance
          : VincentyDistance.vincentyDistance;
      final equirectangular = useWrapper
          ? geodesy.equirectangularDistance
          : EquirectangularApproximation.equirectangularDistance;
      final cosine = useWrapper
          ? geodesy.sphericalLawOfCosinesDistance
          : SphericalLawOfCosines.sphericalLawOfCosinesDistance;

      group('Vincenty', () {
        test('identical coordinates have zero distance', () {
          expect(vincenty(10, 20, 10, 20), 0);
          expect(vincenty(0, 0, 0, 0), 0);
        });

        test('equivalent dateline and pole coordinates have zero distance', () {
          expect(vincenty(10, 180, 10, -180), 0);
          expect(vincenty(90, 0, 90, 120), 0);
          expect(vincenty(-90, 0, -90, -120), 0);
        });

        test('equatorial distance uses the WGS-84 semi-major axis', () {
          // An equatorial arc of one degree is exactly a * pi / 180.
          const expectedMeters = 111319.49079327357;
          expect(vincenty(0, 0, 0, 1), closeTo(expectedMeters, 0.001));
          expect(vincenty(0, 1, 0, 0), closeTo(expectedMeters, 0.001));
          expect(vincenty(0, 179.5, 0, -179.5), closeTo(expectedMeters, 0.001));
        });

        test('matches the published Flinders Peak to Buninyong reference', () {
          // https://www.movable-type.co.uk/scripts/latlong-vincenty.html
          expect(
              vincenty(
                  -(37 + 57 / 60 + 3.72030 / 3600),
                  144 + 25 / 60 + 29.52440 / 3600,
                  -(37 + 39 / 60 + 10.15610 / 3600),
                  143 + 55 / 60 + 35.38390 / 3600),
              closeTo(54972.271, 0.001));
        });

        for (final coordinates in [
          [0.0, 0.0, 0.0, 180.0],
          [0.5, 0.0, -0.5, 179.7],
        ]) {
          test('reports non-convergence for $coordinates without hanging',
              () async {
            expect(await _vincentyOutcome(coordinates, useWrapper),
                'non-convergent');
          });
        }

        test('rejects invalid coordinates', () {
          for (final coordinates in [
            [double.nan, 0.0, 0.0, 0.0],
            [0.0, double.infinity, 0.0, 0.0],
            [0.0, 0.0, double.negativeInfinity, 0.0],
            [0.0, 0.0, 0.0, double.nan],
            [91.0, 0.0, 0.0, 0.0],
            [0.0, 181.0, 0.0, 0.0],
            [0.0, 0.0, -91.0, 0.0],
            [0.0, 0.0, 0.0, -181.0],
          ]) {
            expect(
                () => vincenty(coordinates[0], coordinates[1], coordinates[2],
                    coordinates[3]),
                throwsArgumentError);
          }
        });
      });

      for (final entry in {
        'equirectangular': equirectangular,
        'spherical law of cosines': cosine,
      }.entries) {
        group(entry.key, () {
          final distance = entry.value;
          test('returns meters for one degree on the equator', () {
            expect(distance(const LatLng(0, 0), const LatLng(0, 1)),
                closeTo(111194.92664455874, 0.001));
          });

          test('returns meters for one degree on a meridian', () {
            expect(distance(const LatLng(45, 10), const LatLng(46, 10)),
                closeTo(111194.92664455874, 0.001));
          });

          test('uses the short longitude difference across the dateline', () {
            const start = LatLng(0, 179.5);
            const end = LatLng(0, -179.5);
            expect(distance(start, end), closeTo(111194.92664455874, 0.001));
            expect(distance(end, start), closeTo(111194.92664455874, 0.001));
          });

          test('identical coordinates return zero and remain finite', () {
            for (final latitude in [0.0, 10.0, 27.0, 45.0, 89.0, 90.0]) {
              final point = LatLng(latitude, 20);
              expect(distance(point, point), 0);
            }
          });

          test('uses radians for latitude away from the equator', () {
            // At 60 degrees, a short east-west arc is about half as long.
            expect(distance(const LatLng(60, 10), const LatLng(60, 10.01)),
                closeTo(555.974633, 0.001));
          });
        });
      }

      test('spherical law of cosines handles antipodal coordinates', () {
        expect(cosine(const LatLng(0, 0), const LatLng(0, 180)),
            closeTo(20015086.79602057, 0.001));
      });
    });
  }
}
